"""
상담 에이전트 모듈

이 모듈은 사용자의 고민을 받아 공감하고 피드백을 제공하는 대화형 상담 에이전트를 구현합니다.
BaseAgent를 상속받아 LangChain을 활용한 대화 처리를 수행합니다.
"""

from agent.base_agent import BaseAgent
from langchain.prompts import ChatPromptTemplate, SystemMessagePromptTemplate, HumanMessagePromptTemplate
from langchain.chains import LLMChain
from agent.config.prompts import SYSTEM_PROMPT_COUNSELING
from agent.config.langchain_config import ModelConfig
from agent.thread.memory_manager import MemoryManager
from agent.thread.thread_store import ThreadStore
from typing import Optional
import openai

class CounselingAgent(BaseAgent):
    """
    상담 에이전트 클래스
    
    이 클래스는 다음과 같은 기능을 제공합니다:
    - 사용자의 고민에 대한 공감과 피드백 제공
    - LangChain memory를 활용한 대화 문맥 유지
    - 시스템 프롬프트를 통한 상담 특화 응답 생성
    - 초기 사연을 주기적으로 상기시키는 기능
    """
    
    def __init__(self, thread_id: str, initial_story: str = None, model_name: str = None, provider: str = ModelConfig.OPENAI):
        """
        CounselingAgent 초기화
        
        Args:
            thread_id (str): 대화 스레드의 고유 식별자
            initial_story (str, optional): 사용자의 초기 사연
            model_name (str, optional): 사용할 LLM 모델의 이름
            provider (str, optional): LLM 제공자 (기본값: OpenAI)
        """
        super().__init__(model_name=model_name, provider=provider)
        self.thread_id = thread_id
        self.thread_store = ThreadStore()
        self.memory_manager = MemoryManager()
        self.memory = self.memory_manager.get_memory(thread_id)
        self.message_count = 0
        
        # 초기 사연이 없으면 Firestore에서 조회
        if initial_story is None:
            self.initial_story = self.thread_store.get_initial_story(thread_id)
        else:
            self.initial_story = initial_story
        self.chain = self.get_chain()

    def _should_remind_initial_story(self) -> bool:
        """
        초기 사연을 상기시켜야 하는지 판단
        
        Returns:
            bool: 초기 사연 상기 필요 여부
        """
        # 10개의 메시지마다 초기 사연 상기
        return self.message_count > 0 and self.message_count % 10 == 0

    def _get_conversation_context(self) -> tuple[str, str]:
        """
        현재 대화의 주제와 요약을 생성
        
        Returns:
            tuple[str, str]: (현재 주제, 이전 대화 요약)
        """
        messages = self.thread_store.get_messages(self.thread_id)
        if not messages:
            return "새로운 상담", "아직 대화가 시작되지 않았습니다."

        # 최근 3개 메시지로 현재 주제 파악
        recent_messages = messages[-3:]
        current_topic = self._extract_topic_from_messages(recent_messages)
        
        # 이전 대화 요약 (최근 3개 메시지 제외)
        if len(messages) > 3:
            previous_messages = messages[:-3]
            conversation_summary = self._summarize_messages(previous_messages)
        else:
            conversation_summary = "대화가 시작되었습니다."
        
        return current_topic, conversation_summary

    def _extract_topic_from_messages(self, messages: list) -> str:
        """
        메시지에서 주제 추출 (간단한 규칙 기반)
        """
        # 첫 번째 사용자 메시지에서 주제 추출
        for msg in messages:
            if msg['role'] == 'user':
                # 간단한 규칙으로 주제 추출 (예: 첫 문장)
                first_sentence = msg['content'].split('.')[0]
                return first_sentence[:50] + "..." if len(first_sentence) > 50 else first_sentence
        return "상담 진행 중"

    def _summarize_messages(self, messages: list) -> str:
        """
        메시지 목록을 요약 (간단한 버전)
        
        Args:
            messages (list): 요약할 메시지 목록
            
        Returns:
            str: 요약된 대화 내용
        """
        if not messages:
            return "이전 대화 내용이 없습니다."

        # 간단한 요약 생성 (첫 문장만 사용)
        summary_parts = []
        for msg in messages:
            if msg['role'] == 'user':
                first_sentence = msg['content'].split('.')[0]
                summary_parts.append(first_sentence)
        
        return " ".join(summary_parts[-3:])  # 최근 3개 요약만 사용

    def get_chain(self) -> LLMChain:
        """
        상담용 LLMChain 생성
        
        시스템 프롬프트와 사용자 입력을 조합하여 대화 체인을 구성합니다.
        초기 사연 상기가 필요한 경우 이를 포함합니다.
        
        Returns:
            LLMChain: 상담 대화를 처리할 LangChain 체인 객체
        """
        current_topic, conversation_summary = self._get_conversation_context()
        
        # 초기 사연 상기가 필요한 경우
        if self._should_remind_initial_story() and self.initial_story:
            system_prompt = f"""
{SYSTEM_PROMPT_COUNSELING.format(
    current_topic=current_topic,
    conversation_summary=conversation_summary
)}

[초기 사연 상기]
사용자가 처음에 공유한 고민: {self.initial_story}

이 초기 사연을 참고하여, 현재 대화의 맥락을 유지하면서 상담을 진행해주세요.
"""
        else:
            system_prompt = SYSTEM_PROMPT_COUNSELING.format(
                current_topic=current_topic,
                conversation_summary=conversation_summary
            )
        
        prompt = ChatPromptTemplate.from_messages([
            SystemMessagePromptTemplate.from_template(system_prompt),
            HumanMessagePromptTemplate.from_template("{user_input}"),
        ])
        
        return LLMChain(
            llm=self.llm,
            prompt=prompt,
            memory=self.memory
        )

    def run(self, user_input: str) -> str:
        """
        사용자의 입력을 받아 상담 응답을 생성
        
        Args:
            user_input (str): 사용자의 상담 요청 메시지
            
        Returns:
            str: 에이전트의 상담 응답 메시지
            
        Raises:
            RuntimeError: 상담 처리 중 오류가 발생한 경우
        """
        try:
            # 메시지 저장
            self.thread_store.save_message(self.thread_id, "user", user_input)
            self.message_count += 1
            
            # 문맥 업데이트가 필요한 경우에만 체인 재생성
            if self._should_remind_initial_story():
                self.chain = self.get_chain()
            
            # 응답 생성 (항상 GPT 호출)
            response = self.chain.run(user_input=user_input)
            
            # 응답 저장
            self.thread_store.save_message(self.thread_id, "ai", response)
            self.message_count += 1
            
            return response
        except Exception as e:
            print(f"[Error] GPT 상담 실패: {e}")
            raise RuntimeError("상담 중 오류 발생")