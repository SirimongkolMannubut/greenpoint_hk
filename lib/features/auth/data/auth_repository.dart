import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/secure_storage_service.dart';

class AuthRepository {
  final SupabaseClient _client;

  AuthRepository(this._client);

  Future<AuthResponse> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(email: email, password: password);
    if (response.session?.accessToken != null) {
      await SecureStorageService.saveToken(response.session!.accessToken);
    }
    return response;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    await SecureStorageService.deleteToken();
  }
}
