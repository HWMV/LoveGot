# Agent 관련 Configration 스크립트
# agent/agentconfig.py
import os

# 실제 배포 시에는 .env 대신 GCP Secret Manager 혹은 Cloud Run 환경변수 사용 권장
class AgentConfig:
    # OpenAI 설정
    OPENAI_API_KEY = os.getenv("OPENAI_API_KEY", "")
    MODEL_NAME = "gpt-4o-mini"  # 기본 모델

    # Anthropic 설정
    ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY", "")

    # Google 설정
    GOOGLE_API_KEY = os.getenv("GOOGLE_API_KEY", "")

    # HuggingFace 설정
    HUGGINGFACE_API_KEY = os.getenv("HUGGINGFACE_API_KEY", "")

    # Cohere 설정
    COHERE_API_KEY = os.getenv("COHERE_API_KEY", "")
