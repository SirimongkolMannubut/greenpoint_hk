import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/constants/app_colors.dart';

class QRScannerScreen extends ConsumerStatefulWidget {
  const QRScannerScreen({super.key});

  @override
  ConsumerState<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends ConsumerState<QRScannerScreen> with SingleTickerProviderStateMixin {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (isScanning) return;
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;
    final String? code = barcodes.first.rawValue;
    if (code == null) return;
    setState(() => isScanning = true);
    _processQRCode(code);
  }

  Future<void> _processQRCode(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(children: [Icon(Icons.check_circle, color: AppColors.primary, size: 28), SizedBox(width: 8), Text('Success!')]),
        content: Text('Received points from store\nQR Code: $code'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(controller: cameraController, onDetect: _onDetect),
          _buildOverlay(),
          _buildTopBar(),
          _buildBottomInfo(),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF1B5E20).withOpacity(0.7)),
      child: Column(
        children: [
          Expanded(flex: 2, child: Container()),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(color: Colors.transparent),
                        ),
                      ),
                      _buildAnimatedBorder(),
                      _buildScanLine(),
                    ],
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
          Expanded(flex: 2, child: Container()),
        ],
      ),
    );
  }

  Widget _buildAnimatedBorder() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.accent.withOpacity(0.3 + (_animationController.value * 0.7)),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(_animationController.value * 0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScanLine() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
          top: _animationController.value * 250,
          left: 0,
          right: 0,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, AppColors.accent, Colors.transparent],
              ),
              boxShadow: [BoxShadow(color: AppColors.accent, blurRadius: 10, spreadRadius: 2)],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () => Navigator.pop(context),
              ),
              const Text('Scan QR Code', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.flash_off, color: Colors.white, size: 28),
                onPressed: () => cameraController.toggleTorch(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Column(
        children: [
          const Icon(Icons.qr_code_scanner, color: Colors.white, size: 48),
          const SizedBox(height: 12),
          const Text('📷', style: TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          const Text(
            'Scan QR from partner store',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            'to receive GreenPoints',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
