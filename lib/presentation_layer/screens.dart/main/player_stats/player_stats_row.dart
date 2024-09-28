import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:role_game_app/common_layer/theme/app_colors.dart';
import 'package:role_game_app/common_layer/theme/app_text_styles.dart';  // To load SVG images

class StatRow extends StatelessWidget {
  final String iconPath;
  final String title;
  final int baseValue;
  final int modValue;

  const StatRow({
    required this.iconPath,
    required this.title,
    required this.baseValue,
    required this.modValue,
  });

  @override
  Widget build(BuildContext context) {
    final int finalValue = baseValue + modValue;  // Calculate final value
    final Color modColor = modValue >= 0 ? AppColors.goodColor : AppColors.badColor;  // Determine mod color

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 180),  // Enforce a maximum width of 300px
      child: Row(
      children: [
        SvgPicture.asset(iconPath, width: 28, height: 28),  // Icon
        const SizedBox(width: 12),
        Text(title.substring(0,3).toUpperCase(), style: AppTextStyles.miniTitle.copyWith(fontWeight: FontWeight.bold)),  // Stat title
        const Spacer(),
        const SizedBox(width: 12),
        Text('$baseValue', style: TextStyle(color: AppColors.greyColor)),  // Base value
        const SizedBox(width: 5),
        Text(
          modValue >= 0 ? '+$modValue' : '$modValue',  // Mod value with + or -
          style: TextStyle(color: modColor),  // Mod color (green or red)
        ),
        const SizedBox(width: 5),
        Text('=', style: TextStyle(color: AppColors.greyColor)),  // Equal sign
        const SizedBox(width: 5),
        Text('$finalValue', style: AppTextStyles.mainTitle),  // Final value
      ],
    ));
  }
}
