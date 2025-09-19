import 'package:flutter/material.dart';
import 'package:ordersaman/common/enum/floating_action_button_type.dart';
import 'package:ordersaman/common/utils/size_config.dart';
import 'package:ordersaman/common/widgets/appbar/appbar.dart';

class PageWrapper extends StatefulWidget {
  final bool useOwnAppBar;
  final Widget body;
  final bool useOwnScaffold;
  final bool showAppBar;
  final bool showBackButton;
  final bool centerMiddle;
  final PreferredSizeWidget? appBar;
  final String? title;
  final Widget? leadingAppIcon;
  final List<Widget> appActions;
  final EdgeInsets? padding;
  final double appBarLeftPadding;
  final double appBarRightPadding;
  final Widget? floatingActionButton;
  final Widget? bottomNavBar;
  final Color? backgroundColor;
  final Color? appBarColor;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonType floatingActionButtonType;
  final Function()? onBackPressed;
  const PageWrapper({
    super.key,
    this.useOwnAppBar = false,
    required this.body,
    this.useOwnScaffold = false,
    this.showAppBar = true,
    this.showBackButton = true,
    this.appBar,
    this.appActions = const [],
    this.leadingAppIcon,
    this.title,
    this.padding,
    this.bottomNavBar,
    this.appBarColor,
    this.appBarLeftPadding = 0,
    this.appBarRightPadding = 20,
    this.floatingActionButton,
    this.backgroundColor,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerDocked,
    this.floatingActionButtonType = FloatingActionButtonType.button,
    this.onBackPressed,
    this.centerMiddle = true,
  });
  @override
  State<PageWrapper> createState() => _PageWrapperState();
}

class _PageWrapperState extends State<PageWrapper> {
  @override
  Widget build(BuildContext context) {
    if (widget.useOwnScaffold) {
      return widget.body;
    } else {
      return Scaffold(
        floatingActionButton:
            widget.floatingActionButtonType == FloatingActionButtonType.button
                ? (widget.floatingActionButton != null
                    ? AnimatedSwitcher(
                      duration: const Duration(milliseconds: 50),
                      child:
                          MediaQuery.of(context).viewInsets.bottom > 0
                              ? Container()
                              : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      bottom: 20.hp,
                                    ),
                                    child: widget.floatingActionButton,
                                  ),
                                ],
                              ),
                    )
                    : null)
                : widget.floatingActionButton,
        backgroundColor: widget.backgroundColor,
        bottomNavigationBar: widget.bottomNavBar,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        appBar:
            widget.showAppBar
                ? (widget.useOwnAppBar
                    ? widget.appBar
                    : CustomAppBar(
                      centerMiddle: widget.centerMiddle,
                      showBottomBorder: false,
                      showBackButton: widget.showBackButton,
                      actions: widget.appActions,
                      title: widget.title,
                      leftPadding: widget.appBarLeftPadding,
                      rightPadding: widget.appBarRightPadding,
                      leadingIcon: widget.leadingAppIcon,
                      onBackPressed: widget.onBackPressed,
                    ))
                : null,
        body: Container(
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20),
          child: widget.body,
        ),
      );
    }
  }
}
