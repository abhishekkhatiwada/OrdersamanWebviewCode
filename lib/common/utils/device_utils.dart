import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceUtils {
  static final DeviceUtils _instance = DeviceUtils._internal();
  factory DeviceUtils() => _instance;
  DeviceUtils._internal();

  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static String _deviceId = "";
  static String _deviceModel = "";
  static String _userAgent = "";
  static String _appVersion = "";
  static String _manufacturer = "";
  static String _osVersion = "";

  /// Get Unique Device ID
  static Future<String> get deviceId async {
    if (_deviceId.isNotEmpty) return _deviceId;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        _deviceId = androidInfo.id; // Secure device ID
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        _deviceId = iosInfo.identifierForVendor ?? "";
      }
    } catch (e) {
      debugPrint("Error getting device ID: $e");
    }
    return _deviceId;
  }

  /// Get Device Model & Manufacturer
  static Future<String> get deviceModel async {
    if (_deviceModel.isNotEmpty) return _deviceModel;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        _manufacturer = androidInfo.manufacturer;
        _deviceModel = "$_manufacturer ${androidInfo.model}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        _deviceModel = iosInfo.utsname.machine; // Gets iPhone model name
      }
    } catch (e) {
      debugPrint("Error getting device model: $e");
    }
    return _deviceModel;
  }

  /// Get OS Version
  static Future<String> get osVersion async {
    if (_osVersion.isNotEmpty) return _osVersion;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        _osVersion = "Android ${androidInfo.version.release}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        _osVersion = "iOS ${iosInfo.systemVersion}";
      }
    } catch (e) {
      debugPrint("Error getting OS version: $e");
    }
    return _osVersion;
  }

  /// Get Application Version
  static Future<String> get appVersion async {
    if (_appVersion.isNotEmpty) return _appVersion;

    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      _appVersion = packageInfo.version;
    } catch (e) {
      debugPrint("Error getting app version: $e");
    }
    return _appVersion;
  }

  /// Get Application Package Name
  static Future<String> get packageName async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.packageName;
    } catch (e) {
      debugPrint("Error getting package name: $e");
      return "";
    }
  }

  /// Get User Agent
  Future<String> getUserAgent() async {
    if (_userAgent.isNotEmpty) return _userAgent;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        _userAgent =
            "Android ${androidInfo.version.release} - ${androidInfo.model}";
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        _userAgent =
            "iOS ${iosInfo.systemVersion} - ${iosInfo.utsname.machine}";
      } else {
        _userAgent = "Unknown Device";
      }
    } catch (e) {
      debugPrint("Error getting user agent: $e");
      _userAgent = "Unknown Device";
    }
    return _userAgent;
  }

  /// Generate Device Info Header
  static Future<Map<String, String>> get deviceInfoHeader async {
    return {
      "user_agent": await _instance.getUserAgent(), // ✅ Fixed getter issue
      "device_id": await deviceId,
      "device_model": await deviceModel,
      "os_version": await osVersion,
      "app_version": await appVersion,
      "package_name": await packageName,
    };
  }
}
