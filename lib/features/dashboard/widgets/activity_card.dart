import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';

class ActivityCard extends ConsumerWidget {
  const ActivityCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(pointTransactionsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ธุรกรรมล่าสุด',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            transactions.when(
              data: (data) => data.isEmpty
                  ? const Text('ไม่มีธุรกรรม')
                  : Column(
                      children: data.take(5).map((t) => ListTile(
                        title: Text(t.description ?? t.type),
                        trailing: Text('${t.points} คะแนน',
                          style: TextStyle(
                            color: t.type == 'earn' ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          )),
                      )).toList(),
                    ),
              loading: () => const CircularProgressIndicator(),
              error: (e, s) => Text('Error: $e'),
            ),
          ],
        ),
      ),
    );
  }
}
