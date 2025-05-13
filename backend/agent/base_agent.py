"""
기본 에이전트 클래스 모듈

이 모듈은 모든 에이전트의 기본이 되는 추상 클래스를 정의합니다.
LangChain을 사용하여 LLM과의 대화를 관리하고, 메모리를 유지합니다.
"""

from abc import ABC, abstractmethod
from langchain.memory import ConversationBufferMemory
from langchain.chains import LLMChain
from agent.config.langchain_config import get_langchain_llm, ModelConfig

class BaseAgent(ABC):
    """
    모든 에이전트의 기본이 되는 추상 클래스
    
    이 클래스는 다음과 같은 기능을 제공합니다:
    - LLM(Large Language Model) 초기화
    - 대화 메모리 관리
    - 체인 생성 및 실행을 위한 추상 메서드 정의
    """
    
    def __init__(self, model_name: str = None, provider: str = ModelConfig.OPENAI):
        """
        BaseAgent 초기화
        
        Args:
            model_name (str, optional): 사용할 LLM 모델의 이름
            provider (str, optional): LLM 제공자 (기본값: OpenAI)
        """
        self.llm = get_langchain_llm(model_name, provider)
        self.memory = ConversationBufferMemory(return_messages=True)

    @abstractmethod
    def get_chain(self):
        """
        LLMChain을 생성하는 추상 메서드
        
        Returns:
            LLMChain: LangChain 체인 객체
        """
        pass

    @abstractmethod
    def run(self, user_input: str) -> str:
        """
        사용자 입력을 처리하고 응답을 생성하는 추상 메서드
        
        Args:
            user_input (str): 사용자의 입력 메시지
            
        Returns:
            str: 에이전트의 응답 메시지
        """
        pass