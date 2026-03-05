import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/qr_display.dart';
import '../providers/qr_provider.dart';

class QRScreen extends ConsumerWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const QRDisplay(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref.read(qrProvider.notifier).generateQR(),
              child: const Text('สร้าง QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
