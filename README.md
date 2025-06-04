# nutria

An intelligent nutrition companion that provides personalized meal recommendations and AI-guided nutrition assistance through advanced machine learning algorithms and natural language processing.

NutriAI combines a Flutter mobile frontend with a Flask backend, utilizing BERT embeddings for semantic recipe matching and the Mistral-7B model for conversational AI assistance.
┌─── Flutter Mobile App ───┐
│  ├── Authentication      │
│  ├── User Questionnaire  │
│  ├── Recommendation UI   │
│  └── AI Chat Interface   │
└─────────────────────────┘
           │
           ▼
┌──── Flask Backend API ────┐
│  ├── Recipe Recommender  │
│  ├── Mistral AI Chat     │
│  ├── User Management     │
│  └── Data Processing     │
└───────────────────────────┘
           │
           ▼
┌─── Data & Storage ────┐
│  ├── SQLite (Local)  │
│  ├── Supabase (Auth) │
│  └── USDA Dataset    │
└───────────────────────┘


Installation & Setup
1. Clone the Repository
bashgit clone https://github.com/yourusername/nutriai.git
cd nutriai
2. Backend Setup
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
3. App running:
flutter pub get
flutter run
4. The recommender system backend and the app backend are not hosted so we need toc hange the url of the server for each run.
