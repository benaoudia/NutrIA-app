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
git clone https://github.com/benaoudia/NutrIA-app.git
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

 <h3>How to run the chatbot?</h3>
  <p>Create a virtual environment in Python with:</p>
  <pre><code>python -m venv .env</code></pre>

  <p>Activate the environment:</p>
  <ul>
    <li><strong>On Windows:</strong> <code>.\.env\Scripts\activate</code></li>
    <li><strong>On Linux:</strong> <code>source .env/bin/activate</code></li>
  </ul>

  <p>Install the dependencies from <code>requirements.txt</code> with:</p>
  <pre><code>pip install -r requirements.txt</code></pre>

  <p>If you encounter an error while installing packages, install them individually:</p>
  <pre><code>pip install package-name</code></pre>

  <p>Run the backend server with the command:</p>
  <pre><code>uvicorn app.main:app --reload</code></pre>

  <p>Let the server keep running, and in another terminal, launch the Flutter application with:</p>
  <pre><code>flutter run</code></pre>

  <p><strong>Et Voila!</strong> Enjoy the chatbot assistance 🎉</p>
