import 'package:flutter/material.dart';
import 'package:ordersaman/app/app_colors.dart';
import 'package:ordersaman/common/utils/size_config.dart';

class TitleDescriptionWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool hasIcon;
  final IconData? icon;
  final double? fontSize;
  final double? buttomGap;
  final double middleGap;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign descriptionTextAlign;

  const TitleDescriptionWidget({
    super.key,
    required this.title,
    required this.description,
    this.hasIcon = false,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.icon,
    this.buttomGap,
    this.fontSize,
    this.descriptionTextAlign = TextAlign.start,
    this.middleGap = 8,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (hasIcon)
          Container(
            margin: EdgeInsets.only(bottom: 12),
            height: 50.hp,
            width: 50.hp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.iconColor,
            ),
            child: Icon(icon, size: 30),
          ),

        Text(
          title,
          style: textTheme.displayLarge!.copyWith(fontSize: fontSize),
          textAlign: TextAlign.end,
        ),
        SizedBox(height: middleGap),
        Text(
          description,
          style: textTheme.bodySmall!.copyWith(color: AppColors.textSecondary),
          textAlign: descriptionTextAlign,
        ),
        SizedBox(height: buttomGap),
      ],
    );
  }
}
