import 'package:flutter/material.dart';
import 'package:role_game_app/common_layer/theme/app_colors.dart';
import 'package:role_game_app/common_layer/theme/app_text_styles.dart';
import 'package:role_game_app/common_layer/theme/app_theme.dart';

class AdventureDecisionRow extends StatelessWidget {
  final String letter;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  const AdventureDecisionRow({
    required this.letter,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),  // Smooth transition duration
        padding: EdgeInsets.symmetric(horizontal: AppTheme.leftInnerPadding, vertical: AppTheme.verticalGapUnit*2),
        margin: EdgeInsets.symmetric(vertical: AppTheme.verticalGapUnit),
        decoration: BoxDecoration(
          color: selected ? AppColors.darkColor : AppColors.lightColor,  // Background color transition
          borderRadius: AppTheme.borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for Letter and Title
            Row(
              children: [
                // Letter A, B, C...
                Text(
                  letter,
                  style: AppTextStyles.mainTitle.copyWith(
                    color: selected ? AppColors.lightColor : AppColors.darkColor,  // Text color transition
                  ),
                ),
                SizedBox(width: 8), // Small space between letter and title

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.subtitle.copyWith(
                      color: selected ? AppColors.lightColor : AppColors.darkColor,  // Text color transition
                    ),
                    overflow: TextOverflow.ellipsis,  // Prevent title from overflowing the row
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Description (Animated maxLines)
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Text(
                description,
                style: AppTextStyles.body.copyWith(
                  color: selected ? AppColors.lightColor : AppColors.darkColor,  // Text color transition
                ),
                maxLines: selected ? 4 : 2,  // Expand or collapse description when selected
                overflow: TextOverflow.ellipsis,  // Prevent description from overflowing
              ),
            ),
          ],
        ),
      ),
    );
  }
}
