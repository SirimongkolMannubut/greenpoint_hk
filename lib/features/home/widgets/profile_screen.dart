import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/animated_widgets.dart';
import '../../dashboard/providers/dashboard_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../streak/screens/streak_screen.dart';
import '../../profile/screens/edit_profile_screen.dart';
import '../screens/help_screen.dart';
import '../../../routes/app_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: profile.when(
        data: (data) => SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileCard(data, context),
              const SizedBox(height: 24),
              _buildStatsCards(data, context),
              const SizedBox(height: 24),
              _buildBadges(context),
              const SizedBox(height: 24),
              _buildStreak(context),
              const SizedBox(height: 24),
              _buildImpact(context),
              const SizedBox(height: 24),
              _buildMenuItems(context, ref),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildProfileCard(dynamic data, BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        boxShadow: const [AppColors.softShadow],
      ),
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, spreadRadius: 3)],
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Text(data.fullName?.substring(0, 1).toUpperCase() ?? 'L', style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
          Text(data.fullName ?? 'Louis', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          Text(data.email, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Level 3 Eco Hero', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(width: 6),
                Text('🌿', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(dynamic data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: AnimatedCard(delay: 0, child: _buildStatCard('Points Earned', '${data.points}', Icons.stars, AppColors.primary))),
              const SizedBox(width: 12),
              Expanded(child: AnimatedCard(delay: 100, child: _buildStatCard('CO2 Saved', '12.5 kg', Icons.cloud, Colors.blue))),
            ],
          ),
          const SizedBox(height: 12),
          AnimatedCard(delay: 200, child: _buildStatCard('Plastic Reduced', '45 items', Icons.recycling, AppColors.earthAccent, fullWidth: true)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, {bool fullWidth = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [AppColors.softShadow],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadges(BuildContext context) {
    return AnimatedCard(
      delay: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [AppColors.softShadow],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text('🏆', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text('Badges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBadge('🌱', 'Eco\nBeginner', Colors.green),
                  _buildBadge('♻️', 'Plastic\nSaver', Colors.blue),
                  _buildBadge('🌟', 'Green\nMaster', Colors.amber),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String emoji, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 32))),
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildStreak(BuildContext context) {
    return AnimatedCard(
      delay: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [AppColors.softShadow],
          ),
          child: Row(
            children: [
              const PulseAnimation(child: Text('🔥', style: TextStyle(fontSize: 48))),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('7 day eco streak', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Keep it up!', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
              AnimatedButton(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StreakScreen())),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: const Text('View', style: TextStyle(color: Color(0xFFFF6B6B), fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImpact(BuildContext context) {
    return AnimatedCard(
      delay: 500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [AppColors.softShadow],
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  Text('🌎', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text('Your Impact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                child: const Column(
                  children: [
                    Text('You saved', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
                    SizedBox(height: 8),
                    Text('3.2 kg CO2', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    SizedBox(height: 4),
                    Text('Equivalent to planting 2 trees 🌳', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AnimatedCard(delay: 600, child: _buildMenuItem(Icons.person, 'Edit Profile', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen())))),
          AnimatedCard(delay: 650, child: _buildMenuItem(Icons.history, 'Transaction History', () {})),
          AnimatedCard(delay: 700, child: _buildMenuItem(Icons.card_giftcard, 'Rewards', () {})),
          AnimatedCard(delay: 750, child: _buildMenuItem(Icons.help_outline, 'Help', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpScreen())))),
          AnimatedCard(delay: 800, child: _buildMenuItem(Icons.settings, 'Settings', () {})),
          const SizedBox(height: 16),
          AnimatedCard(
            delay: 850,
            child: AnimatedButton(
              onTap: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await ref.read(authProvider.notifier).signOut();
                  if (context.mounted) Navigator.pushReplacementNamed(context, AppRouter.login);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [AppColors.softShadow],
                ),
                child: const ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.red),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return AnimatedButton(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [AppColors.softShadow],
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primary),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
