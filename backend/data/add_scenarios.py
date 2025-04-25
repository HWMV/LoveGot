# 시나리오 데이터 추가 플로우
# 1. scenarios에 원하는 시나리오 추가
# 2. python add_scenarios.py 실행
# 3. 로그에서 업로드 완료 확인!

import firebase_admin
from firebase_admin import credentials, firestore

# Firebase 인증 초기화
cred = credentials.Certificate("../service_account.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

# 시나리오 정의 (result_negative를 배열로 통일)
scenarios = [
    {
        "id": "001",
        "prompt": "연인이 화장실에서 치약을 막 짜서 사용하고 나왔어!",
        "choices": [
            "나는 치약이 중간부터 짜여 있으면 속상해..",
            "치약 짜는 것 좀 신경 써줄래?",
            "치약 또 중간부터 짰네?"
        ],
        "correct_index": 0,
        "result_positive": "미안해.. 끝에서부터 짜도록 노력해볼게",
        "result_negative": [
            "아 몰라몰라! 난 이게 편해!",
            "또라니.. 언제 그랬다고 그래!"
        ]
    },
    {
        "id": "002",
        "prompt": "연인이 약속 시간보다 30분이나 늦게 왔어. 자주 늦는 연인이야!",
        "choices": [
            "많이 기다려서 속상했어.",
            "오늘은 왜 또 늦었어?",
            "늦을 거 같으면 미리 연락 좀 해줘."
        ],
        "correct_index": 0,
        "result_positive": "미안해.. 다음부터 더 신경 쓸게.",
        "result_negative": [
            "뭘 또야! 내가 맨날 늦었어?",
            "아! 알겠어, 뭘 그렇게 예민하게 굴어."
        ]
    }
]

# Firestore 업로드
for scenario in scenarios:
    db.collection("scenarios").document(scenario["id"]).set(scenario)
    print(f"✅ 시나리오 {scenario['id']} 업로드 완료")

