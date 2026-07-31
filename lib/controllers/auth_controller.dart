import 'package:tasky/services/auth_service.dart';
import 'package:tasky/services/cache_service.dart';
import 'package:tasky/services/image_service.dart';

class AuthController {
  Future<void> register({
    required String nom,
    required String prenom,
    required String email,
    required String username,
    required String password,
  }) {
    return AuthService.register(
      nom: nom,
      prenom: prenom,
      email: email,
      username: username,
      password: password,
    );
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final token = await AuthService.login(
      username: username,
      password: password,
    );
    await CacheService.saveToken(token);
  }

  bool isLoggedIn() {
    return CacheService.getToken() != null;
  }

  Future<void> logout() {
    return CacheService.deleteToken();
  }

  Future<Map<String, dynamic>> getProfile() {
    return AuthService.getProfile();
  }

  Future<void> updateProfile({
    required String nom,
    required String prenom,
    required String email,
    String? photo,
  }) {
    return AuthService.updateProfile(
      nom: nom,
      prenom: prenom,
      email: email,
      photo: photo,
    );
  }

  // Choisir photo galerie
  Future<String?> pickProfileImage() {
    return ImageService.pickImageAsBase64();
  }
}