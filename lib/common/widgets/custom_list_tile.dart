import 'package:flutter/material.dart';
import 'package:ordersaman/app/app_colors.dart';
import 'package:ordersaman/common/utils/size_config.dart';

class FilledListTile extends StatelessWidget {
  final String title;

  final void Function()? onPressed;
  final IconData? icon;
  final EdgeInsets? margin;
  final String? imageLocation;
  final Widget? midWidget;
  final Widget? trailing;
  final Color? subtitleTextColor;
  final Color? iconColor;
  final double horizontalMargin;
  final double bottomMargin;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double imageHeight;
  final double imageWidth;
  final Color textColor;

  const FilledListTile({
    super.key,
    required this.title,
    this.onPressed,
    this.icon,
    this.margin,
    this.imageLocation,
    this.midWidget,
    this.trailing,
    this.subtitleTextColor,
    this.iconColor,
    this.horizontalMargin = 0,
    this.bottomMargin = 0,
    this.textColor = AppColors.darkGray,

    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    this.imageHeight = 20,
    this.imageWidth = 20,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      margin:
          margin ??
          EdgeInsets.only(
            bottom: bottomMargin,
            left: horizontalMargin,
            right: horizontalMargin,
          ),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
          ),
        ),
        color: AppColors.darkGray.withAlpha(30),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                if (icon != null)
                  Icon(icon, color: iconColor ?? AppColors.darkGray, size: 24),
                SizedBox(width: 15.wp),
                if (imageLocation != null)
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: AppColors.darkGray.withAlpha(30),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    margin: const EdgeInsets.only(right: 15),
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        imageLocation ?? '',
                        height: imageHeight,
                        width: imageWidth,
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (title.isNotEmpty)
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium!.copyWith(
                            color: textColor,
                          ),
                        ),
                    ],
                  ),
                ),
                if (midWidget != null) midWidget!,
                trailing ??
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.darkGray,
                      size: 20,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
