import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/supabase_provider.dart';
import '../data/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(supabaseProvider));
});

class AuthNotifier extends Notifier<AsyncValue<void>> {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> signIn(String usernameOrEmail, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(authRepositoryProvider).signInWithUsernameOrEmail(usernameOrEmail, password));
  }

  Future<void> signUp(String email, String password, String fullName) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(authRepositoryProvider).signUp(email, password, fullName));
  }

  Future<void> signUpWithDetails(
    String email,
    String password,
    String fullName,
    String username,
    String phone,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(authRepositoryProvider).signUpWithDetails(
      email,
      password,
      fullName,
      username,
      phone,
    ));
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AsyncValue<void>>(AuthNotifier.new);
