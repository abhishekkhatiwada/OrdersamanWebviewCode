import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:ordersaman/common/utils/navigation_service.dart';

class CustomSnackBar {
  static Flushbar<dynamic>? _currentFlushbar;

  static void show({
    required String message,
    required SnackBarType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Dismiss the currently visible snackbar
    _currentFlushbar?.dismiss();

    Color backgroundColor;
    IconData icon;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
    }

    _currentFlushbar = Flushbar(
      message: message,
      duration: duration,
      borderRadius: BorderRadius.circular(10),
      margin: EdgeInsets.all(16),
      backgroundColor: backgroundColor,
      flushbarPosition: FlushbarPosition.BOTTOM, // or BOTTOM
      animationDuration: Duration(milliseconds: 500),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      icon: Icon(icon, color: Colors.white),
    )..show(_getOverlayContext());
  }

  static BuildContext _getOverlayContext() {
    return NavigationService.navigatorKey.currentContext!;
  }
}

enum SnackBarType { success, error }
