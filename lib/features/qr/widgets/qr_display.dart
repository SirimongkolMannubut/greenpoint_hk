import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
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

    return QrImageView(
      data: qr.code,
      version: QrVersions.auto,
      size: 200.0,
      backgroundColor: Colors.white,
    );
  }
}
