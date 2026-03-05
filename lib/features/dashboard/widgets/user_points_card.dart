import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';

class UserPointsCard extends ConsumerWidget {
  const UserPointsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(pointsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: points.when(
          data: (data) => Text('คะแนนทั้งหมด: ${data.length}'),
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => Text('Error: $e'),
        ),
      ),
    );
  }
}
