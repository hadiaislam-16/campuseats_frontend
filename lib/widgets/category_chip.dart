import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 11,
        ),

        decoration: BoxDecoration(
          color: selected
              ? AppColors.forest
              : AppColors.white,

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: selected
                ? AppColors.forest
                : const Color(0xFFE7E1D8),
          ),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: selected
                  ? AppColors.cream
                  : AppColors.forest,
            ),

            const SizedBox(width: 7),

            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: selected
                    ? AppColors.cream
                    : AppColors.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}