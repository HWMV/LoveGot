# ✅ langchain_config.py (신규 생성)
import os
from typing import Optional
from langchain_openai import ChatOpenAI
from langchain_community.chat_models import ChatAnthropic
from langchain_community.chat_models import ChatGooglePalm
from langchain_community.chat_models import ChatHuggingFace
from langchain_community.chat_models import ChatCohere
from agent.config.agentconfig import AgentConfig

class ModelConfig:
    """지원하는 모델 설정"""
    OPENAI = "openai"
    ANTHROPIC = "anthropic"
    GOOGLE = "google"
    HUGGINGFACE = "huggingface"
    COHERE = "cohere"

def get_langchain_llm(model_name: Optional[str] = None, provider: str = ModelConfig.OPENAI):
    """
    LangChain LLM 인스턴스를 생성합니다.
    
    Args:
        model_name: 사용할 모델 이름
        provider: 모델 제공자 (openai, anthropic, google 등)
    
    Returns:
        LangChain LLM 인스턴스
    """
    if provider == ModelConfig.OPENAI:
        return ChatOpenAI(
            model=model_name or "gpt-4o-mini",  # "gpt-3.5-turbo"
            temperature=0.7,
            api_key=AgentConfig.OPENAI_API_KEY
        )
    elif provider == ModelConfig.ANTHROPIC:
        return ChatAnthropic(
            model=model_name or "claude-2",
            temperature=0.7,
            anthropic_api_key=AgentConfig.ANTHROPIC_API_KEY
        )
    elif provider == ModelConfig.GOOGLE:
        return ChatGooglePalm(
            model=model_name or "chat-bison-001",
            temperature=0.7,
            google_api_key=AgentConfig.GOOGLE_API_KEY
        )
    elif provider == ModelConfig.HUGGINGFACE:
        return ChatHuggingFace(
            model_name=model_name or "google/flan-t5-xxl",
            temperature=0.7,
            huggingfacehub_api_token=AgentConfig.HUGGINGFACE_API_KEY
        )
    elif provider == ModelConfig.COHERE:
        return ChatCohere(
            model=model_name or "command",
            temperature=0.7,
            cohere_api_key=AgentConfig.COHERE_API_KEY
        )
    else:
        raise ValueError(f"지원하지 않는 모델 제공자입니다: {provider}")