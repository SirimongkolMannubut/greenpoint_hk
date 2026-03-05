import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/qr_model.dart';

class QRNotifier extends Notifier<QRModel?> {
  @override
  QRModel? build() => null;

  void generateQR() {
    state = QRModel(
      id: DateTime.now().toString(),
      code: 'QR-${DateTime.now().millisecondsSinceEpoch}',
      expiresAt: DateTime.now().add(const Duration(minutes: 5)),
    );
  }
}

final qrProvider = NotifierProvider<QRNotifier, QRModel?>(QRNotifier.new);
