import 'package:flutter/foundation.dart';

class CustomLog {
  static void log(
    dynamic value, {
    LogType type = LogType.info,
    String? customColor,
  }) {
    _printWithColor(value, _getColorCode(type, customColor), type);
  }

  static void success(dynamic value) {
    _printWithColor(value, _getColorCode(LogType.success), LogType.success);
  }

  static void error(dynamic value) {
    _printWithColor(value, _getColorCode(LogType.error), LogType.error);
  }

  static void warning(dynamic value) {
    _printWithColor(value, _getColorCode(LogType.warning), LogType.warning);
  }

  static void action(dynamic value) {
    _printWithColor(value, _getColorCode(LogType.action), LogType.action);
  }

  static void custom(dynamic value, String colorCode) {
    _printWithColor(value, colorCode, LogType.custom);
  }

  static void _printWithColor(dynamic value, String colorCode, LogType type) {
    if (kDebugMode) {
      String prefix = _getPrefix(type);
      debugPrint("\x1B[${colorCode}m$prefix$value\x1B[0m");
    }
  }

  static String _getColorCode(LogType type, [String? customColor]) {
    switch (type) {
      case LogType.success:
        return "32"; // Green
      case LogType.error:
        return "31"; // Red
      case LogType.warning:
        return "33"; // Yellow
      case LogType.action:
        return "36"; // Cyan
      case LogType.custom:
        return customColor ?? "37"; // Default to white if no custom color
      case LogType.info:
        return "37"; // White (default log)
    }
  }

  static String _getPrefix(LogType type) {
    switch (type) {
      case LogType.success:
        return "[SUCCESS] ";
      case LogType.error:
        return "[ERROR] ";
      case LogType.warning:
        return "[WARNING] ";
      case LogType.action:
        return "[ACTION] ";
      case LogType.custom:
        return "[CUSTOM] ";
      case LogType.info:
        return "[INFO] ";
    }
  }
}

enum LogType { success, error, warning, action, custom, info }
