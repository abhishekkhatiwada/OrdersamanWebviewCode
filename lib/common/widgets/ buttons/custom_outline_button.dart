import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.horizontalPadding = 12,
    this.verticalPadding = 12,
    this.fontSize = 14,
    this.textColor,
    this.fontWeight = FontWeight.w700,
    this.horizontalMargin = 10,
    this.borderColor,
  });

  final String title;
  final Function()? onPressed;
  final bool isDisabled;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final Color? textColor;
  final FontWeight fontWeight;
  final double horizontalMargin;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color effectiveBorderColor =
        isDisabled ? theme.disabledColor : (borderColor ?? theme.primaryColor);
    final Color effectiveTextColor =
        isDisabled
            ? theme.textTheme.bodyMedium!.color!
            : (textColor ?? theme.primaryColor);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: effectiveBorderColor),
            ),
            child: Center(
              child: Text(
                title,
                style: theme.textTheme.titleSmall!.copyWith(
                  fontWeight: fontWeight,
                  color: effectiveTextColor,
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
