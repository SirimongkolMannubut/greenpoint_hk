import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/point_model.dart';
import '../../../core/models/profile_model.dart';

class DashboardRepository {
  final SupabaseClient _client;

  DashboardRepository(this._client);

  Future<ProfileModel> getProfile() async {
    final userId = _client.auth.currentUser?.id;
    final response = await _client
        .from('profiles')
        .select()
        .eq('id', userId!)
        .single();
    return ProfileModel.fromJson(response);
  }

  Future<List<PointModel>> getPointTransactions() async {
    final userId = _client.auth.currentUser?.id;
    final response = await _client
        .from('point_transactions')
        .select()
        .eq('user_id', userId!)
        .order('created_at', ascending: false)
        .limit(10);
    return (response as List).map((e) => PointModel.fromJson(e)).toList();
  }
}
