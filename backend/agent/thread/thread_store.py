"""
스레드 저장소 모듈

이 모듈은 사용자의 상담 스레드와 메시지를 Firestore에 저장하고 관리하는 기능을 제공합니다.
각 스레드는 고유한 ID를 가지며, 사용자와 AI의 대화 내용을 시간순으로 저장합니다.
"""

from firebase_admin import firestore
from datetime import datetime
import uuid
from typing import Optional
import openai
from agent.config.prompts import SYSTEM_PROMPT_COUNSELING

db = firestore.client()
threads_ref = db.collection("threads")


class ThreadStore:
    """
    상담 스레드 저장소
    
    이 클래스는 다음과 같은 기능을 제공합니다:
    - 새로운 상담 스레드 생성
    - 스레드별 메시지 저장
    - 스레드 제목 자동 요약
    """

    def create_thread(self, user_id: str) -> str:
        """
        새로운 상담 스레드 생성
        
        Args:
            user_id (str): 스레드를 생성할 사용자의 ID
            
        Returns:
            str: 생성된 스레드의 고유 ID
        """
        thread_id = str(uuid.uuid4())
        threads_ref.document(thread_id).set({
            "id": thread_id,
            "user_id": user_id,
            "created_at": datetime.utcnow(),
            "title": "제목 없음",  # 요약 후 업데이트 예정
        })
        return thread_id

    def save_message(self, thread_id: str, role: str, content: str):
        """
        스레드에 새로운 메시지 저장
        
        Args:
            thread_id (str): 메시지를 저장할 스레드의 ID
            role (str): 메시지 발신자 역할 ("user" 또는 "ai")
            content (str): 메시지 내용
        """
        message_ref = threads_ref.document(thread_id).collection("messages")
        message_ref.add({
            "role": role,
            "content": content,
            "created_at": datetime.utcnow()
        })

    def summarize_thread_title(self, thread_id: str) -> Optional[str]:
        """
        스레드의 대화 내용을 요약하여 제목 생성
        
        GPT-4o-mini를 사용하여 대화 내용을 분석하고 10자 이내의 한국어 제목을 생성합니다.
        
        Args:
            thread_id (str): 제목을 생성할 스레드의 ID
            
        Returns:
            Optional[str]: 생성된 제목. 실패 시 None 반환
        """
        messages_ref = threads_ref.document(thread_id).collection("messages")
        messages = messages_ref.order_by("created_at").stream()

        full_text = ""
        for doc in messages:
            msg = doc.to_dict()
            full_text += f"{msg['role']}: {msg['content']}\n"

        prompt = f"""
다음은 연애 고민 상담 대화의 전체 내용입니다. 이 대화의 주제를 요약한 한 줄 제목을 10자 이내의 한국어로 작성해주세요.

{full_text}

제목:
"""

        try:
            completion = openai.ChatCompletion.create(
                model="gpt-4o-mini",
                messages=[
                    {"role": "system", "content": SYSTEM_PROMPT_COUNSELING},
                    {"role": "user", "content": prompt}
                ],
                temperature=0.7
            )
            title = completion.choices[0].message['content'].strip()
            threads_ref.document(thread_id).update({"title": title})
            return title
        except Exception as e:
            print(f"[Error] 제목 요약 실패: {e}")
            return None

    def get_messages(self, thread_id: str) -> list:
        """
        스레드의 모든 메시지를 시간순으로 조회
        
        Args:
            thread_id (str): 조회할 스레드의 ID
            
        Returns:
            list: 메시지 목록
        """
        messages_ref = threads_ref.document(thread_id).collection("messages")
        messages = messages_ref.order_by("created_at").stream()
        return [doc.to_dict() for doc in messages]

    def verify_thread_ownership(self, thread_id: str, user_id: str) -> bool:
        """
        스레드의 소유권을 검증
        
        Args:
            thread_id (str): 검증할 스레드 ID
            user_id (str): 사용자 ID
            
        Returns:
            bool: 소유권 여부
        """
        thread_doc = threads_ref.document(thread_id).get()
        if not thread_doc.exists:
            return False
        return thread_doc.get("user_id") == user_id

    def save_initial_story(self, thread_id: str, story: str):
        """
        스레드의 초기 사연을 저장
        
        Args:
            thread_id (str): 스레드 ID
            story (str): 초기 사연 내용
        """
        threads_ref.document(thread_id).update({
            "initial_story": story,
            "updated_at": datetime.utcnow()
        })

    def get_initial_story(self, thread_id: str) -> Optional[str]:
        """
        스레드의 초기 사연을 조회
        
        Args:
            thread_id (str): 스레드 ID
            
        Returns:
            Optional[str]: 초기 사연 내용
        """
        doc = threads_ref.document(thread_id).get()
        if not doc.exists:
            return None
        return doc.get("initial_story")
