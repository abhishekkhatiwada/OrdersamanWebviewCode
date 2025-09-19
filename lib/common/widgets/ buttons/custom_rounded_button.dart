import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
    this.padding,
    this.borderRadius = 4,
    this.color,
    this.horizontalPadding = 10,
    this.verticalPadding = 12,
    this.fontSize = 14,
    this.textColor,
    this.fontWeight = FontWeight.bold,
    this.horizontalMargin = 0,
    this.icon,
  });

  final String title;
  final Function()? onPressed;
  final bool isDisabled;
  final bool isLoading;
  final Color? color;
  final EdgeInsets? padding;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final Color? textColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final double horizontalMargin;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color backgroundColor =
        isDisabled ? theme.disabledColor : (color ?? theme.primaryColor);
    final Color effectiveTextColor =
        isDisabled
            ? theme.textTheme.bodyMedium!.color!
            : (textColor ?? Colors.white);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding:
                padding ??
                EdgeInsets.symmetric(
                  vertical: verticalPadding,
                  horizontal: horizontalPadding,
                ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border:
                  isDisabled
                      ? null
                      : Border.all(color: color ?? theme.primaryColor),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontWeight: fontWeight,
                      color: effectiveTextColor,
                      fontSize: fontSize,
                    ),
                  ),
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(icon, color: effectiveTextColor, size: 22),
                    ),
                  if (isLoading)
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: 14,
                        width: 14,
                        child: CircularProgressIndicator(
                          color: effectiveTextColor,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
