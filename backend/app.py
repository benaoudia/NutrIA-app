from flask import Flask, request, jsonify
from flask_cors import CORS
from supabase import create_client, Client
from werkzeug.security import check_password_hash,generate_password_hash
import os
app = Flask(__name__)
CORS(app)

# Supabase credentials (replace with your own)
SUPABASE_URL = "https://tugaozifqqtdacbjincx.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR1Z2FvemlmcXF0ZGFjYmppbmN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc1MzI1MTgsImV4cCI6MjA2MzEwODUxOH0.puaMsmJk84rUoHr1PbKTVyxbrEzdjjZjUmKYCYvKG38"


supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    name = data.get('name')
    email = data.get('email')
    password = data.get('password')

    if not name or not email or not password:
        return jsonify({'error': 'Name, email, and password are required'}), 400

    try:
        hashed_password = generate_password_hash(password)
        response = supabase.table('users').insert({
                'name': name,
                'email': email,
                'password': hashed_password
            }).execute()

        # Check for empty data (meaning it likely failed)
        if not response.data:
            return jsonify({'error': 'Signup failed, response is empty'}), 500

        return jsonify({'message': 'User registered successfully'}), 201

    except Exception as e:
        return jsonify({'error': str(e)}), 500
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()

    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({'error': 'Email and password are required'}), 400

    # Fetch user by email
    result = supabase.table('users').select("*").eq("email", email).execute()

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
    app.run(host='0.0.0.0', port=5000, debug=True)
