# main.py
import os, uuid, bcrypt, jwt
from fastapi import FastAPI, HTTPException, Depends, status, Header
from pydantic import BaseModel, EmailStr
import uvicorn
from typing import Dict, Optional, Annotated
from fastapi.middleware.cors import CORSMiddleware
import firebase_admin
from firebase_admin import credentials, firestore
from datetime import datetime, timedelta

# agent.py와 agentconfig.py는 이미 존재한다고 가정
from agent.agent import GottmanAgent
agent = GottmanAgent()

import openai
openai.api_key = os.getenv("OPENAI_API_KEY")
# ───────────────────────────────── Firebase init ───────────────────────────────
# Cloud Run(또는 로컬)에서 GOOGLE_APPLICATION_CREDENTIALS 환경변수에
# service‑account json 경로를 지정해 두면 한 줄로 초기화됩니다.

# cred_path = "/backend/service_account.json"
cred_path = "service_account.json"
cred = credentials.Certificate(cred_path)
firebase_admin.initialize_app(cred)

db = firestore.client()

users_ref   = db.collection("users")
couples_ref = db.collection("couples")

# ────────────────────────────────── FastAPI app ────────────────────────────────
app = FastAPI(title="LoveGot‑Backend")
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], allow_credentials=True,
    allow_methods=["*"], allow_headers=["*"],
)

# ──────────────────────────────── Pydantic 모델 ────────────────────────────────
# 요청 카드 사용자 입력 정의
class RequestBody(BaseModel):
    user_input: str

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

# ───────────────────────────── JWT helper 함수들 ────────────────────────────────
SECRET_KEY = os.getenv("SECRET_KEY", "super‑secret")
ALGORITHM  = "HS256"
TOKEN_TTL_DAYS = 7

def create_access_token(user_id: str) -> str:
    exp = datetime.utcnow() + timedelta(days=TOKEN_TTL_DAYS)
    return jwt.encode({"user_id": user_id, "exp": exp}, SECRET_KEY, algorithm=ALGORITHM)

async def get_current_user(
    authorization: Annotated[str, Header(alias="Authorization")]
) -> dict:
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                            detail="Missing Bearer token")

    token = authorization.split()[1]
    try:
        payload  = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
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
class ScenarioAnswerRequest(BaseModel):
    scenario_id: str
    selected_index: int

@app.post("/scenario/answer")
def submit_answer(req: ScenarioAnswerRequest):
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


# ────────────────────────────────── main ───────────────────────────────────────
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=int(os.getenv("PORT", 8080)))