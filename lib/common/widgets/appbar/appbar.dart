import 'package:flutter/material.dart';
import 'package:ordersaman/common/widgets/%20buttons/custom_icon_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final Widget? centerWidget;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final String? title;
  final bool showBottomBorder;
  final Function()? onBackPressed;
  final bool showBackButton;
  final bool centerMiddle;
  final double? leftPadding;
  final double? rightPadding;
  final double topPadding;

  const CustomAppBar({
    super.key,
    this.centerWidget,
    this.leadingIcon,
    this.bottom,
    this.title,
    this.actions = const [],
    this.showBottomBorder = true,
    this.onBackPressed,
    this.centerMiddle = true,
    this.showBackButton = true,
    this.leftPadding,
    this.rightPadding,
    this.topPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final backgroundColor =
        theme.appBarTheme.backgroundColor ??
        (isDarkMode ? Colors.black : Colors.white);

    final textStyle = theme.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w600,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.only(
              left: leftPadding ?? 20.0,
              right: rightPadding ?? 20.0,
              top: MediaQuery.of(context).padding.top + topPadding,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              border:
                  showBottomBorder
                      ? Border(bottom: BorderSide(color: theme.dividerColor))
                      : null,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 65),
              child: NavigationToolbar(
                leading:
                    leadingIcon != null
                        ? Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [leadingIcon!],
                        )
                        : ((showBackButton)
                            ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconButton(
                                  icon: Icons.arrow_back_ios_new_rounded,
                                  // iconColor: backButtonColor,
                                  onPressed:
                                      onBackPressed ??
                                      () {
                                        Navigator.of(context).pop();
                                      },
                                  shadow: false,
                                  backgroundColor: backgroundColor,
                                ),
                              ],
                            )
                            : null),
                middle:
                    title != null
                        ? Text(title!, style: textStyle)
                        : centerWidget,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions,
                ),
                centerMiddle: centerMiddle,
                middleSpacing: NavigationToolbar.kMiddleSpacing,
              ),
            ),
          ),
        ),
        if (bottom != null)
          Container(color: theme.scaffoldBackgroundColor, child: bottom!),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(160);
}
