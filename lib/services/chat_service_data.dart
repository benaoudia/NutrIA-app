import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chat_message.dart';

/// Service to interact with the Together AI API using Mistral model.
class ChatService {
  // Together AI API endpoint
  static const String _apiUrl = 'https://api.together.xyz/v1/chat/completions';

  // Store API key securely
  final String _apiKey;

  // Constructor that requires an API key
  ChatService({required String apiKey}) : _apiKey = apiKey;

  /// Sends a user message to the Together AI API and returns the bot's response.
  Future<ChatMessage> sendMessage(String message,
      {List<ChatMessage>? previousMessages}) async {
    // Prepare conversation history for the API
    final List<Map<String, String>> messages = [];

    // Add system message for NutriBot
    messages.add({
      'role': 'system',
      'content': 'You are NutriBot, a friendly and expert virtual nutrition assistant. '
          'You ONLY respond to questions related to nutrition, healthy eating, food, diets, and meal planning. '
          'If asked anything else, respond with: '
          '\'I\'m here to help only with nutrition-related topics. Please ask me something about healthy eating or diet!\''
    });

    // Add previous messages if available
    if (previousMessages != null) {
      for (var msg in previousMessages) {
        messages.add({
          'role': msg.isUser ? 'user' : 'assistant',
          'content': msg.message,
        });
      }
    }

    // Add the current message
    messages.add({
      'role': 'user',
      'content': message,
    });

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'mistralai/Mistral-7B-Instruct-v0.1',
          'messages': messages,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botResponse = data['choices'][0]['message']['content'] as String;

        return ChatMessage(
          message: botResponse,
          isUser: false,
          timestamp: DateTime.now(),
        );
      } else {
        print('API Error: ${response.statusCode}, ${response.body}');
        throw Exception(
            'Failed to get response from Together AI API: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Failed to communicate with Together AI API: $e');
    }
  }
}
