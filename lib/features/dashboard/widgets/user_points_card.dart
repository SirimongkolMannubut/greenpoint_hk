import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';

class UserPointsCard extends ConsumerWidget {
  const UserPointsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: profile.when(
          data: (data) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('สวัสดี ${data.fullName ?? data.email}', 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('คะแนนของคุณ: ${data.points}', 
                style: const TextStyle(fontSize: 24, color: Colors.green)),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => Text('Error: $e'),
        ),
      ),
    );
  }
}
