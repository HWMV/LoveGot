# LoveGot Project

## Project Structure

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

