# Nutria

An intelligent nutrition companion that provides personalized meal recommendations and AI-guided nutrition assistance through advanced machine learning algorithms and natural language processing.

NutriAI combines a Flutter mobile frontend with a Flask backend, utilizing BERT embeddings for semantic recipe matching.

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
</head>
<body>
  <pre><code>
┌─── Flutter Mobile App ───┐
│ ├── Authentication       │
│ ├── User Questionnaire   │
│ ├── Recommendation UI    │
│ └── AI Chat Interface    │
└─────────────────────────┘
            │
            ▼
┌──── Flask Backend API ────┐
│ ├── Recipe Recommender    │
│ ├── Mistral AI Chat       │
│ ├── User Management       │
│ └── Data Processing       │
└───────────────────────────┘
            │
            ▼
┌───── Data & Storage ─────┐
│ ├── SQLite (Local)       │
│ ├── Supabase (Auth)      │
│ └── USDA Dataset         │
└──────────────────────────┘
  </code></pre>

  <h2>🔧 Tech Stack</h2>
  <ul>
    <li><strong>Frontend:</strong> Flutter</li>
    <li><strong>Backend:</strong> Flask</li>
    <li><strong>AI Models:</strong> BERT (semantic search), Mistral-7B (chat)</li>
    <li><strong>Database:</strong> SQLite</li>
    <li><strong>Authentication:</strong> Supabase</li>
    <li><strong>Data Source:</strong> USDA Food Dataset</li>
  </ul>

</body>
</html>


Installation & Setup
1. Clone the Repository

cd nutriai
3. Backend Setup
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
cp .env.example .env
4. App running:
flutter pub get
flutter run
5. The recommender system backend and the app backend are not hosted so we need toc hange the url of the server for each run.
