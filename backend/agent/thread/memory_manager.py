"""
메모리 관리자 모듈

이 모듈은 스레드별 대화 메모리를 관리하는 기능을 제공합니다.
LangChain의 ConversationBufferMemory를 활용하여 각 스레드별로 독립적인 대화 문맥을 유지합니다.
"""

from langchain.memory import ConversationBufferMemory
from typing import Dict


class MemoryManager:
    """
    스레드별 대화 메모리 관리자
    
    이 클래스는 다음과 같은 기능을 제공합니다:
    - 스레드별 독립적인 대화 메모리 관리
    - 메모리 생성 및 조회
    - 메모리 초기화
    """

    def __init__(self):
        """
        MemoryManager 초기화
        
        스레드 ID를 키로 하고 ConversationBufferMemory를 값으로 하는 딕셔너리를 생성합니다.
        """
        self.memory_pool: Dict[str, ConversationBufferMemory] = {}

    def get_memory(self, thread_id: str) -> ConversationBufferMemory:
        """
        특정 스레드의 메모리를 조회하거나 생성
        
        Args:
            thread_id (str): 조회할 스레드의 고유 식별자
            
        Returns:
            ConversationBufferMemory: 해당 스레드의 대화 메모리 객체
        """
        if thread_id not in self.memory_pool:
            self.memory_pool[thread_id] = ConversationBufferMemory(
                return_messages=True
            )
        return self.memory_pool[thread_id]

    def clear_memory(self, thread_id: str):
        """
        특정 스레드의 메모리를 초기화
        
        Args:
            thread_id (str): 초기화할 스레드의 고유 식별자
        """
        if thread_id in self.memory_pool:
            del self.memory_pool[thread_id]
