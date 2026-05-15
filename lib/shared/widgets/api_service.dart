import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<bool> isOnline() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/health'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> saveQuizResult({
    required String careerTrack,
    required Map<String, int> answers,
  }) async {
    //  Save locally
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('career_track', careerTrack);
    await prefs.setString('quiz_answers', jsonEncode(answers));
    await prefs.setString('quiz_date', DateTime.now().toIso8601String());

    // Save to Firestore
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('quiz_results')
            .doc(user.uid)
            .set({
          'userId': user.uid,
          'email': user.email,
          'careerTrack': careerTrack,
          'answers': answers,
          'date': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      // Firestore failed but local save succeeded
    }

    return true;
  }

  static Future<String?> getSavedCareerTrack() async {
    // Try Firestore first
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('quiz_results')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          return doc.data()?['careerTrack'];
        }
      }
    } catch (_) {}

    // Fallback to local
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('career_track');
  }

  static Future<String> sendMessage(String message) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/chat/send'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'message': message,
              'conversation_id': null,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? data['message'] ?? 'No response';
      }
      return 'Error: ${response.statusCode}';
    } catch (e) {
      return 'API is currently offline. Please run the backend server.';
    }
  }
}
