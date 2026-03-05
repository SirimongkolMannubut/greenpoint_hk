import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/point_model.dart';
import '../../../core/providers/supabase_provider.dart';
import '../data/dashboard_repository.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepository(ref.watch(supabaseProvider));
});

final pointsProvider = FutureProvider<List<PointModel>>((ref) {
  return ref.watch(dashboardRepositoryProvider).getPoints();
});
