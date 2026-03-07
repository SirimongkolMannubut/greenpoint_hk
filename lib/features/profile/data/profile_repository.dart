import '../../../core/supabase/supabase_client.dart';

class ProfileRepository {
  final _supabase = SupabaseConfig.client;

  Future<void> updateProfile({
    required String userId,
    String? fullName,
    String? phone,
  }) async {
    await _supabase.from('profiles').update({
      if (fullName != null) 'full_name': fullName,
      if (phone != null) 'phone': phone,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', userId);
  }

  Future<Map<String, dynamic>?> getUserStats(String userId) async {
    final response = await _supabase.from('user_stats').select().eq('user_id', userId).single();
    return response;
  }

  Future<List<Map<String, dynamic>>> getUserBadges(String userId) async {
    final response = await _supabase.from('user_badges').select('*, badges(*)').eq('user_id', userId);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getDailyMissions(String userId) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final response = await _supabase.from('daily_missions').select().eq('user_id', userId).eq('mission_date', today);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getStores() async {
    final response = await _supabase.from('stores').select().eq('is_green_partner', true).order('rating', ascending: false).limit(10);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> createTransaction({
    required String userId,
    String? storeId,
    required String transactionType,
    int pointsEarned = 0,
    String? qrCode,
  }) async {
    await _supabase.from('transactions').insert({
      'user_id': userId,
      'store_id': storeId,
      'transaction_type': transactionType,
      'points_earned': pointsEarned,
      'qr_code': qrCode,
    });

    final currentPoints = await _supabase.from('profiles').select('points').eq('id', userId).single();
    await _supabase.from('profiles').update({'points': (currentPoints['points'] ?? 0) + pointsEarned}).eq('id', userId);
  }
}
