import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/qr_provider.dart';

class QRDisplay extends ConsumerWidget {
  const QRDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qr = ref.watch(qrProvider);

    if (qr == null) {
      return const Text('กดปุ่มเพื่อสร้าง QR Code');
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(qr.code, style: const TextStyle(fontSize: 20)),
    );
  }
}
