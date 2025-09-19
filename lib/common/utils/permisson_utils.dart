import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  /// Check & Request Camera Permission
  static Future<bool> get isCameraPermissionAvailable async {
    return await _checkAndRequestPermission(Permission.camera);
  }

  /// Check & Request Storage Permission (For older Android versions)
  static Future<bool> get isStoragePermissionAvailable async {
    return await _checkAndRequestPermission(Permission.storage);
  }

  /// Check & Request Photos Permission (For Android 13+)
  static Future<bool> get isPhotosPermissionAvailable async {
    return await _checkAndRequestPermission(Permission.photos);
  }

  /// Check & Request Location Permission (Foreground)
  static Future<bool> get isLocationPermissionAvailable async {
    return await _checkAndRequestPermission(Permission.locationWhenInUse);
  }

  /// Check & Request Background Location Permission
  static Future<bool> get isBackgroundLocationPermissionAvailable async {
    return await _checkAndRequestPermission(Permission.locationAlways);
  }

  /// Generic function to check & request permission
  static Future<bool> _checkAndRequestPermission(Permission permission) async {
    if (await permission.isGranted) return true;

    final res = await permission.request();
    if (res.isGranted || res.isLimited) return true;

    // If permanently denied, guide user to settings
    if (res.isPermanentlyDenied) {
      openAppSettings();
    }

    return false;
  }

  /// Request Multiple Permissions at Once
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(
    List<Permission> permissions,
  ) async {
    return await permissions.request();
  }
}
