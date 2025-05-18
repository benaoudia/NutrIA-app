from flask import Flask, request, jsonify
from supabase import create_client, Client
from werkzeug.security import check_password_hash
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)  # Allow requests from Flutter frontend

# Connect to Supabase
SUPABASE_URL = "https://YOUR_PROJECT.supabase.co"
SUPABASE_KEY = "YOUR_SUPABASE_SERVICE_ROLE_KEY"  # keep this safe!
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()

    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({'error': 'Email and password are required'}), 400

    # Fetch user by email
    result = supabase.table('Agency').select("*").eq("email", email).execute()

    if len(result.data) == 0:
        return jsonify({'error': 'Invalid email or password'}), 401

    user = result.data[0]

    # Check hashed password
    if not check_password_hash(user['password'], password):
        return jsonify({'error': 'Invalid email or password'}), 401

    return jsonify({
        'message': 'Login successful',
        'user': {
            'id': user['id'],
            'name': user['name'],
            'email': user['email'],
            # Add more user fields as needed
        }
    }), 200

if __name__ == '__main__':
    app.run(debug=True)
