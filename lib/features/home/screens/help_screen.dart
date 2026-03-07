import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('วิธีใช้งาน'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHelpCard(
            icon: Icons.home,
            title: 'หน้าแรก',
            description: 'ดูโปรโมชั่น แต้มสะสม และร้านค้าใกล้คุณ',
            steps: [
              'ดูแต้มที่สะสมได้ในวันนี้',
              'เช็คโปรโมชั่นพิเศษ',
              'ค้นหาร้านค้าใกล้คุณ',
            ],
          ),
          const SizedBox(height: 16),
          _buildHelpCard(
            icon: Icons.store,
            title: 'ร้านค้าพาร์ทเนอร์',
            description: 'ค้นหาร้านค้าที่ร่วมรณรงค์ลดพลาสติก',
            steps: [
              'ค้นหาร้านค้าด้วยชื่อ',
              'กรองร้านค้าตามประเภท',
              'ดูรายละเอียดและที่อยู่ร้าน',
            ],
          ),
          const SizedBox(height: 16),
          _buildHelpCard(
            icon: Icons.qr_code_scanner,
            title: 'สแกน QR Code',
            description: 'สแกน QR เพื่อรับแต้มสะสม',
            steps: [
              'กดปุ่มสแกน QR',
              'เล็งกล้องไปที่ QR Code',
              'รับแต้มทันที',
            ],
          ),
          const SizedBox(height: 16),
          _buildHelpCard(
            icon: Icons.person,
            title: 'โปรไฟล์',
            description: 'จัดการบัญชีและดูสถิติของคุณ',
            steps: [
              'ดูแต้มสะสมทั้งหมด',
              'เช็คสถิติการลดพลาสติก',
              'ดูประวัติธุรกรรม',
            ],
          ),
          const SizedBox(height: 24),
          Card(
            color: AppColors.primary.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.help_outline, size: 48, color: AppColors.primary),
                  const SizedBox(height: 12),
                  const Text(
                    'ต้องการความช่วยเหลือ?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ติดต่อเราได้ที่\nsupport@greenpoint.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard({
    required IconData icon,
    required String title,
    required String description,
    required List<String> steps,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...steps.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${entry.key + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
