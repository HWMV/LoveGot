# main.py
import os, uuid, bcrypt, jwt
from fastapi import FastAPI, HTTPException, Depends, status, Header

from pydantic import BaseModel, EmailStr, Field
import uvicorn
from typing import Dict, Optional, Annotated
from fastapi.middleware.cors import CORSMiddleware
import firebase_admin
from firebase_admin import credentials, firestore
from datetime import datetime, timedelta

# Firebase 초기화를 가장 먼저 수행
cred_path = "service_account.json"
cred = credentials.Certificate(cred_path)
firebase_admin.initialize_app(cred)

db = firestore.client()
users_ref = db.collection("users")
couples_ref = db.collection("couples")

# 그 다음에 다른 모듈들을 import
from agent.agent_positive import GottmanAgent
from agent.counseling_agent import CounselingAgent
from agent.thread.thread_store import ThreadStore

agent = GottmanAgent()
thread_store = ThreadStore()

# OpenAI API 설정
import openai
openai.api_key = os.getenv("OPENAI_API_KEY")

# ───────────────────────────────── Firebase init ───────────────────────────────
# Cloud Run(또는 로컬)에서 GOOGLE_APPLICATION_CREDENTIALS 환경변수에
# service‑account json 경로를 지정해 두면 한 줄로 초기화됩니다.

# cred_path = "/backend/service_account.json"

# ────────────────────────────────── FastAPI app ────────────────────────────────
app = FastAPI(title="LoveGot‑Backend")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], allow_credentials=True,
    allow_methods=["*"], allow_headers=["*"],
)

# Swagger UI에서 Authorize의 Bearer 토큰을 자동으로 모든 요청에 넣으려면, OpenAPI 보안 스키마 정의가 필요 -> 왜?
from fastapi.openapi.utils import get_openapi

def custom_openapi():
    if app.openapi_schema:
        return app.openapi_schema

    openapi_schema = get_openapi(
        title="LoveGot‑Backend",
        version="1.0.0",
        description="LoveGot 백엔드 API 서버",
        routes=app.routes,
    )

    # Bearer 인증 스키마 추가
    openapi_schema["components"]["securitySchemes"] = {
        "BearerAuth": {
            "type": "http",
            "scheme": "bearer",
            "bearerFormat": "JWT"
        }
    }

    # 모든 API에 보안 스키마 적용
    for path in openapi_schema["paths"].values():
        for method in path.values():
            method.setdefault("security", [{"BearerAuth": []}])

    app.openapi_schema = openapi_schema
    return app.openapi_schema

app.openapi = custom_openapi

# ──────────────────────────────── Pydantic 모델 ────────────────────────────────
# 요청 카드 사용자 입력 정의
class RequestBody(BaseModel):
    user_input: str = Field(
        ...,
        description="상담하고 싶은 고민이나 갈등 상황을 상세히 작성해주세요",
        example="저는 현재 연애 중인데, 파트너와 자주 의견 충돌이 있어요..."
    )

# 요청 카드 AI 개선 답변 Output 정의
class ResponseBody(BaseModel):
    user_input: str
    Answer1: str
    Answer2: str
    Answer3: str

class UserCreate(BaseModel):
    email: EmailStr
    password: str
    nickname: str

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserPublic(BaseModel):
    id: str
    email: EmailStr
    nickname: str
    couple_id: Optional[str] = None

class AuthResponse(UserPublic):
    access_token: str

class CoupleRequest(BaseModel):
    target_user_email: EmailStr   # 상대 이메일

class ScenarioAnswerRequest(BaseModel):
    scenario_id: str
    selected_index: int

class CounselingRequest(BaseModel):
    thread_id: str
    user_input: str

# ───────────────────────────── JWT helper 함수들 ────────────────────────────────
SECRET_KEY = os.getenv("SECRET_KEY", "super‑secret")
ALGORITHM  = "HS256"
TOKEN_TTL_DAYS = 7

def create_access_token(user_id: str) -> str:
    """JWT 토큰 생성 함수"""
    exp = datetime.utcnow() + timedelta(days=TOKEN_TTL_DAYS)
    return jwt.encode({"user_id": user_id, "exp": exp}, SECRET_KEY, algorithm=ALGORITHM)

from fastapi import Request

async def get_current_user(request: Request) -> dict:
    """현재 인증된 사용자 정보를 반환하는 함수"""
    authorization = request.headers.get("Authorization")
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                            detail="Missing or invalid Bearer token")

    token = authorization.split()[1]
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_doc = users_ref.document(payload["user_id"]).get()
        if not user_doc.exists:
            raise ValueError
        return user_doc.to_dict()
    except Exception:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                            detail="Invalid or expired token")

# ──────────────────────────────── 엔드포인트 ──────────────────────────────────
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

# 1) 회원가입
@app.post("/api/auth/register", response_model=AuthResponse)
async def register(user: UserCreate):
    """회원가입 엔드포인트"""
    if users_ref.where("email", "==", user.email).get():
        raise HTTPException(status_code=400, detail="Email already registered")

    hashed = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt()).decode()
    uid = str(uuid.uuid4())

    user_data = {
        "id": uid, "email": user.email, "password": hashed,
        "nickname": user.nickname, "couple_id": None
    }
    users_ref.document(uid).set(user_data)
    token = create_access_token(uid)

    return AuthResponse(**user_data, access_token=token)

# 2) 로그인
@app.post("/api/auth/login", response_model=AuthResponse)
async def login(user: UserLogin):
    """로그인 엔드포인트"""
    docs = users_ref.where("email", "==", user.email).limit(1).get()
    if not docs:
        raise HTTPException(status_code=401, detail="Invalid credentials")

    u = docs[0].to_dict()
    if not bcrypt.checkpw(user.password.encode(), u["password"].encode()):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    token = create_access_token(u["id"])
    return AuthResponse(**u, access_token=token)

# 3) 커플 등록 요청
@app.post("/api/couples/request")
async def request_couple(
    req: CoupleRequest,
    current_user: dict = Depends(get_current_user)
):
    """커플 등록 요청 엔드포인트"""
    # 같은 사람 금지
    if current_user["email"] == req.target_user_email:
        raise HTTPException(400, "Cannot couple with yourself")
    if current_user["couple_id"]:
        raise HTTPException(400, "You are already in a couple")

    target_docs = users_ref.where("email", "==", req.target_user_email).limit(1).get()
    if not target_docs:
        raise HTTPException(404, "Target user not found")

    target = target_docs[0].to_dict()
    if target["couple_id"]:
        raise HTTPException(400, "Target user is already in a couple")

    couple_id = str(uuid.uuid4())
    batch = db.batch()
    batch.update(users_ref.document(current_user["id"]), {"couple_id": couple_id})
    batch.update(users_ref.document(target["id"]),       {"couple_id": couple_id})
    batch.set(couples_ref.document(couple_id), {
        "id": couple_id,
        "user1_id": current_user["id"],
        "user2_id": target["id"],
        "created_at": datetime.utcnow()
    })
    batch.commit()
    return {"couple_id": couple_id, "message": "Couple linked 🎉"}

# 긍정훈련법 시뮬레이션 기능
@app.get("/scenario/{scenario_id}")
def get_scenario(scenario_id: str):
    """시나리오 조회 엔드포인트"""
    doc = db.collection("scenarios").document(scenario_id).get()
    if not doc.exists:
        raise HTTPException(status_code=404, detail="Scenario not found")

    data = doc.to_dict()
    return {
        "scenario_id": scenario_id,
        "prompt": data["prompt"],
        "choices": data["choices"],
    }

# 긍정훈련법 시뮬레이션-사용자 선택 처리 및 결과 반환 API
@app.post("/scenario/answer")
def submit_answer(req: ScenarioAnswerRequest):
    """시나리오 답변 제출 엔드포인트"""
    doc = db.collection("scenarios").document(req.scenario_id).get()
    if not doc.exists:
        raise HTTPException(status_code=404, detail="Scenario not found")

    scenario = doc.to_dict()
    correct = (req.selected_index == scenario["correct_index"])
    score = 10 if correct else 0

    if correct:
        result_message = scenario.get("result_positive", "좋은 선택이에요!")
    else:
        result_negative = scenario.get("result_negative", [])
        # 인덱스 확인 후 메시지 선택
        if isinstance(result_negative, list) and req.selected_index < len(result_negative):
            result_message = result_negative[req.selected_index]
        else:
            result_message = "조금 더 신중한 대화가 필요해 보여요."

    return {
        "is_correct": correct,
        "score": score,
        "result_message": result_message
    }

# Counseling_agent 엔드포인트 api
from agent.counseling_agent import CounselingAgent

# agent.thread 모듈 불러오기
from agent.thread.thread_store import ThreadStore

thread_store = ThreadStore()

# swagger test를 위한 api/threads body를 빈칸으로 만들기 위함

# @app.get("/api/threads")
@app.post("/api/threads", 
    response_model=dict,
    summary="새로운 상담 스레드 생성",
    description="새로운 상담 스레드를 생성하고 초기 사연을 입력하여 상담을 시작합니다."
)
async def create_new_thread(
    request: RequestBody,
    current_user: dict = Depends(get_current_user)
):
    """
    새로운 상담 스레드를 생성하고 초기 사연을 입력하여 상담을 시작합니다.
    
    Args:
        request (RequestBody): 사용자의 초기 고민/갈등 상황
        current_user (dict): 현재 인증된 사용자 정보
        
    Returns:
        dict: 생성된 스레드 ID와 초기 응답
    """
    # 1. 스레드 생성
    thread_id = thread_store.create_thread(user_id=current_user["id"])
    
    # 2. 초기 사연 저장
    thread_store.save_initial_story(thread_id, request.user_input)
    
    # 3. 상담 에이전트 생성 및 초기 응답
    counselor = CounselingAgent(
        thread_id=thread_id,
        initial_story=request.user_input
    )
    response = counselor.run(request.user_input)
    thread_store.save_message(thread_id, "ai", response)
    
    return {
        "thread_id": thread_id,
        "initial_response": response
    }

@app.post("/agent/counseling")
def counseling_entry(
    request: CounselingRequest,
    current_user: dict = Depends(get_current_user)
):
    """
    상담 에이전트 엔드포인트
    
    Args:
        request (CounselingRequest): 상담 요청 정보
        current_user (dict): 현재 인증된 사용자 정보
        
    Returns:
        dict: 상담 응답
        
    Raises:
        HTTPException: 스레드 소유권이 없거나 스레드가 존재하지 않는 경우
    """
    # 스레드 소유권 검증
    if not thread_store.verify_thread_ownership(request.thread_id, current_user["id"]):
        raise HTTPException(
            status_code=403,
            detail="You don't have permission to access this thread"
        )
    
    # 상담 에이전트 생성 및 응답
    counselor = CounselingAgent(thread_id=request.thread_id)
    response = counselor.run(request.user_input)
    
    return {"response": response}

# ────────────────────────────────── main ───────────────────────────────────────
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=int(os.getenv("PORT", 8080)))