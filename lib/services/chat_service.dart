import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  Future<String> sendMessage(String message, {String? sessionId}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'session_id': sessionId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'];
      } else {
        throw Exception('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error sending message: $e');
    }
  }

  Future<void> clearHistory() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/clear-history'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to clear history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error clearing history: $e');
    }
  }
}
