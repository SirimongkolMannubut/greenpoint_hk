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

  Future<AuthResponse> signUp(String email, String password, String fullName) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName, 'username': fullName},
      );
      
      print('SignUp Response: ${response.user?.id}');
      return response;
    } catch (e) {
      print('SignUp Error Details: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signUpWithDetails(
    String email,
    String password,
    String fullName,
    String username,
    String phone,
  ) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'username': username,
          'phone': phone,
        },
      );
      
      print('SignUp Response: ${response.user?.id}');
      return response;
    } catch (e) {
      print('SignUp Error Details: $e');
      rethrow;
    }
  }

  Future<AuthResponse> signInWithUsernameOrEmail(String usernameOrEmail, String password) async {
    try {
      String email = usernameOrEmail;
      
      // ถ้าไม่มี @ แสดงว่าเป็น username
      if (!usernameOrEmail.contains('@')) {
        try {
          // ค้นหา email จาก username
          final result = await _client
              .from('profiles')
              .select('email')
              .eq('username', usernameOrEmail)
              .maybeSingle();
          
          if (result != null && result['email'] != null) {
            email = result['email'];
          } else {
            // ถ้าไม่เจอใน profiles ลองใช้เป็น email ตรงๆ
            email = usernameOrEmail;
          }
        } catch (e) {
          // ถ้า error ให้ลองใช้เป็น email ตรงๆ
          email = usernameOrEmail;
        }
      }
      
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.session?.accessToken != null) {
        await SecureStorageService.saveToken(response.session!.accessToken);
      }
      return response;
    } catch (e) {
      print('SignIn Error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    await SecureStorageService.deleteToken();
  }
}
