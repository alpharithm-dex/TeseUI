import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  
  static const String _baseUrl = 'http://127.0.0.1:8000'; 
  Future<Map<String, dynamic>> askQuestion(String question) async {
    final url = Uri.parse('$_baseUrl/ask');
    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'question': question}),
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        // Return the whole data map
        return data;
      } else {
        final errorData = json.decode(utf8.decode(response.bodyBytes));
        throw Exception(
            'Server error: ${response.statusCode} - ${errorData['detail']}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the Tese Hub...');
    }
  }
}
