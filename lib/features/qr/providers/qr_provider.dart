import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/qr_model.dart';

final qrProvider = StateNotifierProvider<QRNotifier, QRModel?>((ref) {
  return QRNotifier();
});

class QRNotifier extends StateNotifier<QRModel?> {
  QRNotifier() : super(null);

  void generateQR() {
    state = QRModel(
      id: DateTime.now().toString(),
      code: 'QR-${DateTime.now().millisecondsSinceEpoch}',
      expiresAt: DateTime.now().add(const Duration(minutes: 5)),
    );
  }
}
