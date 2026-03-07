import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/animated_widgets.dart';
import '../screens/help_screen.dart';
import '../../store/screens/store_list_screen.dart';
import '../../qr/screens/qr_scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              AnimatedCard(delay: 0, child: _buildHeroPointsCard()),
              const SizedBox(height: 24),
              AnimatedCard(delay: 100, child: _buildMascotTip(context)),
              const SizedBox(height: 24),
              AnimatedCard(delay: 200, child: _buildDailyMissions(context)),
              const SizedBox(height: 24),
              AnimatedCard(delay: 300, child: _buildEcoImpactDashboard()),
              const SizedBox(height: 24),
              AnimatedCard(delay: 400, child: _buildQuickActions(context)),
              const SizedBox(height: 24),
              _buildNearbyStores(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary,
            child: const Text('L', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('👋 Hello, Louis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                SizedBox(height: 2),
                Text('You have 240 GreenPoints', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: AppColors.primary),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroPointsCard() {
    const currentPoints = 20;
    const maxPoints = 100;
    const progress = currentPoints / maxPoints;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [AppColors.softShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('🌿', style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              Text('Your GreenPoints', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 12),
          const Text('240 GP', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text('Today progress', style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          Text('$currentPoints/$maxPoints GP', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildMascotTip(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accent, width: 2),
        boxShadow: const [AppColors.softShadow],
      ),
      child: Row(
        children: [
          const PulseAnimation(child: Text('🌱', style: TextStyle(fontSize: 48))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tip from น้องถุง', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
                const SizedBox(height: 4),
                const Text('Complete daily missions to earn bonus points! 🎯', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyMissions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppColors.softShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Daily Missions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: const Text('1/3 Done', style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildMissionItem('Scan 1 QR', true, '+20 GP', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerScreen()))),
          const SizedBox(height: 12),
          _buildMissionItem('Visit eco store', false, '+20 GP', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreListScreen()))),
          const SizedBox(height: 12),
          _buildMissionItem('Use reusable bag', false, '+20 GP', () {}),
        ],
      ),
    );
  }

  Widget _buildMissionItem(String title, bool completed, String reward, VoidCallback onTap) {
    return AnimatedButton(
      onTap: completed ? () {} : onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: completed ? AppColors.accent.withOpacity(0.2) : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: completed ? AppColors.primary : Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(completed ? Icons.check_circle : Icons.radio_button_unchecked, color: completed ? AppColors.primary : AppColors.textSecondary, size: 24),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: completed ? AppColors.primary : AppColors.textPrimary, decoration: completed ? TextDecoration.lineThrough : null))),
            Text(reward, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: completed ? AppColors.textSecondary : AppColors.primary)),
          ],
        ),
      ),
    );
  }

  Widget _buildEcoImpactDashboard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)]),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppColors.softShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('🌍', style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              Text('Eco Impact Dashboard', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildImpactItem('♻️', 'Plastic saved', '45 items')),
              const SizedBox(width: 12),
              Expanded(child: _buildImpactItem('☁️', 'CO2 reduced', '12.5 kg')),
            ],
          ),
          const SizedBox(height: 12),
          _buildImpactItem('🌳', 'Trees supported', '8 trees', fullWidth: true),
        ],
      ),
    );
  }

  Widget _buildImpactItem(String emoji, String label, String value, {bool fullWidth = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: fullWidth ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              if (fullWidth) const SizedBox(width: 12),
              if (fullWidth) Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)), const SizedBox(height: 4), Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))])),
            ],
          ),
          if (!fullWidth) const SizedBox(height: 8),
          if (!fullWidth) Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11), textAlign: TextAlign.center),
          if (!fullWidth) const SizedBox(height: 4),
          if (!fullWidth) Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickActionButton(context, Icons.qr_code_scanner, 'Scan QR', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScannerScreen()))),
          _buildQuickActionButton(context, Icons.store, 'Find Store', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreListScreen()))),
          _buildQuickActionButton(context, Icons.card_giftcard, 'Rewards', () {}),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return AnimatedButton(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              shape: BoxShape.circle,
              boxShadow: const [AppColors.softShadow],
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildNearbyStores(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Nearby Stores', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreListScreen())), child: const Text('See All')),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            itemBuilder: (context, index) => AnimatedCard(delay: 500 + (index * 50), child: _buildStoreCard(name: 'Eco Market ${index + 1}', distance: '${(index + 1) * 0.4} km', rating: 4.8, imageUrl: 'https://via.placeholder.com/150')),
          ),
        ),
      ],
    );
  }

  Widget _buildStoreCard({required String name, required String distance, required double rating, required String imageUrl}) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppColors.softShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl, height: 100, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 100, color: Colors.grey[300], child: const Icon(Icons.store, size: 40, color: Colors.grey))),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text(rating.toString(), style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                    const Spacer(),
                    const Icon(Icons.location_on, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 2),
                    Flexible(child: Text(distance, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary), overflow: TextOverflow.ellipsis)),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                  child: const Text('🌿 Partner', style: TextStyle(fontSize: 9, color: AppColors.primary, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
