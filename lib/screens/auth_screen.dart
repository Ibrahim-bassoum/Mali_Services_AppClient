import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // 10.0.2.2 pour l'émulateur Android ou ton IP locale pour un test USB
  static const String baseUrl = "http://192.168.1.15:8000/api";

  // --- CONNEXION CLIENT ---
  static Future<Map<String, dynamic>?> login(String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "phone": phone.trim(), // On remplace l'email par le téléphone
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // On sauvegarde le token dès que la connexion réussit
        await _saveToken(data['access_token']);
        
        return data;
      } else {
        print("Erreur Login Client: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Erreur réseau Login : $e");
      return null;
    }
  }

  // --- INSCRIPTION CLIENT ---
  static Future<Map<String, dynamic>?> register({
    required String name,
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "phone": phone.trim(),
          "password": password,
          "password_confirmation": password, // Requis par Laravel
          "role": "client", // Fixé sur client pour cette application
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        await _saveToken(data['access_token']);
        return data;
      } else {
        print("Erreur Register Client: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Erreur réseau Register : $e");
      return null;
    }
  }

  // --- GESTION DU STOCKAGE ---

  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}