# main.py
import os
from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn
from typing import Dict
from fastapi.middleware.cors import CORSMiddleware

# agent.py와 agentconfig.py는 이미 존재한다고 가정
from agent.agent import GottmanAgent

app = FastAPI()
agent = GottmanAgent()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 또는 특정 도메인 리스트
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 사용자 요청 형식
# (2) 요청 바디 정의
class RequestBody(BaseModel):
    user_input: str

# (3) 응답 바디 정의 (샘플)
class ResponseBody(BaseModel):
    user_input: str
    Answer1: str
    Answer2: str
    Answer3: str

@app.get("/")
def root():
    """
    간단한 헬스체크용 엔드포인트
    """
    return {"message": "Hello from LoveGot backend via FastAPI!"}

@app.post("/request_card")
def create_statements(request: RequestBody) -> Dict:
    """
    user_input을 받아서 긍정적 화법 3문장을 생성해 반환
    """
    user_input = request.user_input
    print(f"Received request with user_input: {user_input}")

    # agent의 함수 호출
    answer1, answer2, answer3 = agent.generate_positive_statements(user_input)

    # 원하는 형태의 JSON 반환
    return {
        "user_input": user_input,
        "Answer1": answer1,
        "Answer2": answer2,
        "Answer3": answer3,
    }

if __name__ == "__main__":
    # Cloud Run에서는 환경 변수 PORT=8080을 사용
    port = int(os.getenv("PORT", 8080))
    uvicorn.run(app, host="0.0.0.0", port=port)