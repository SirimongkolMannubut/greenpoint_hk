import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/models/point_model.dart';

class DashboardRepository {
  final SupabaseClient _client;

  DashboardRepository(this._client);

  Future<List<PointModel>> getPoints() async {
    final response = await _client.from('points').select();
    return (response as List).map((e) => PointModel.fromJson(e)).toList();
  }
}
