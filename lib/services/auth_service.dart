import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasky/services/cache_service.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:3000';

  // Register
  static Future<void> register({
    required String nom,
    required String prenom,
    required String email,
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auths/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'email': email,
        'username': username,
        'password': password,
        'photo': 'photo',
      }),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erreur lors de l\'inscription');
    }
  }

  // Login
  static Future<String> login({
    required String username,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auths/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Identifiants ou Mot de passe incorrects');
    }
  }

  // Récupérer le profil de l'user connecté
  static Future<Map<String, dynamic>> getProfile() async {
    final token = CacheService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/auths/profils'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur lors du chargement du profil');
    }
  }

  // Update profil
  static Future<void> updateProfile({
    required String nom,
    required String prenom,
    required String email,
  }) async {
    final token = CacheService.getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/auths/profils'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'nom': nom,
        'prenom': prenom,
        'email': email,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Erreur lors de la modification du profil');
    }
  }
}