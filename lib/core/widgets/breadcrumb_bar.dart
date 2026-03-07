import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class BreadcrumbBar extends StatelessWidget {
  final List<String> paths;
  final VoidCallback? onHomeTap;

  const BreadcrumbBar({
    super.key,
    required this.paths,
    this.onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.background,
      child: Row(
        children: [
          GestureDetector(
            onTap: onHomeTap,
            child: const Icon(Icons.home, size: 16, color: AppColors.primary),
          ),
          for (int i = 0; i < paths.length; i++) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.chevron_right, size: 16, color: AppColors.textSecondary),
            ),
            Text(
              paths[i],
              style: TextStyle(
                fontSize: 13,
                color: i == paths.length - 1 ? AppColors.primary : AppColors.textSecondary,
                fontWeight: i == paths.length - 1 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
