# LoveGot Project

## Project Structure

### backend strucuture

```
backend/
 ┣ main.py
 ┣ agent/
 ┃  ┣ agent.py
 ┃  ┗ agentconfig.py
 ┣ utils/
 ┃  ┗ __init__.py
 ┃  ┗ utils.txt
 ┣ data/
 ┃  ┗ data.txt
 ┗ ...
```


```
LoveGot/
├── frontend/                    # Flutter frontend application
│   ├── lib/                     # Main Flutter source code
│   │   ├── feature/            # Feature-based architecture
│   │   │   └── home/           # Home feature
│   │   │       └── home_screen.dart
│   │   └── main.dart           # Application entry point
│   ├── pubspec.yaml            # Flutter dependencies
│   └── README.md               # Frontend specific documentation
│
├── backend/                     # Python backend application
│   ├── agent/                   # AI agent related code
│   ├── data/                    # Data related code
│   ├── utils/                   # Utility functions
│   ├── main.py                 # Backend entry point
│   ├── requirements.txt        # Python dependencies
│   └── .env                    # Environment variables
│
└── README.md                   # Project documentation
```

## Getting Started

### Frontend (Flutter)
1. Navigate to the frontend directory
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

### Backend (Python)
1. Navigate to the backend directory
2. Create a virtual environment: `python -m venv .venv`
3. Activate the virtual environment:
   - Windows: `.venv\Scripts\activate`
   - macOS/Linux: `source .venv/bin/activate`
4. Install dependencies: `pip install -r requirements.txt`
5. Run the backend: `python main.py`

## DATA Schema
3. **데이터 스키마**
3-1. 회원가입 & 로그인
  ```
  users 컬렉션
      {
      "id": "string",
      "email": "string",
      "password": "string (hashed)",
      "nickname": "string",
      "couple_id": "string (nullable)"
    }
  ```
  ```
  couples 컬렉션
    {
      "id": "string",
      "user1_id": "string",
      "user2_id": "string",
      "created_at": "timestamp"
    }
  ```

## 협업 시 규칙
<협업 시 규칙>

** 매우 중요 : branch 변경 후 반드시 Pull 로 로컬 저장소 최신 코드로 업데이트 필수!!! **
1. PR의 생성 순서는 중요하지 않음.
2. 수정하는 코드 영역이 겹치면 충돌이 발생할 수 있음.
-> 이 경우 먼저 병합된 PR에 따라 나중에 병합되는 PR에서 충돌을 해결해야 함.
-> 후 PR 에서 충돌 수정.
!! ->> 동일한 파일을 수정할 경우 무조건 커뮤니케이션을 통한 작업 범위를 명확하게 지정

1. 매 작업 시작 마다 “최신 상태 유지”
-> 최신 변경 사항을 pull 하여 로컬 저장소를 최신 상태로 유지.

1. 서로 같은 스크립트의 코드를 수정할 때,
-> “Fetch” 사용 후 확인하고 “merge”
-> 왠만하면 다른 영역을 각자 수정하고 “pull”로 최신상태 유지 및 merge