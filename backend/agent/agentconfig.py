# Agent 관련 Configration 스크립트
# agent/agentconfig.py
import os

# 실제 배포 시에는 .env 대신 GCP Secret Manager 혹은 Cloud Run 환경변수 사용 권장
class AgentConfig:
    OPENAI_API_KEY = os.getenv("OPENAI_API_KEY", "")

    # 사용할 모델명 (예: gpt-3.5-turbo, gpt-4 등)
    MODEL_NAME = "gpt-4o-mini"
