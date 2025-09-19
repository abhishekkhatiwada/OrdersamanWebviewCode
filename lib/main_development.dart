import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:ordersaman/app/app_dev.dart';
import 'package:ordersaman/app/local_wrapper.dart';
import 'package:ordersaman/app/notification_service.dart';
import 'package:ordersaman/common/constants/app_config.dart';
import 'package:ordersaman/common/constants/env.dart';
import 'package:ordersaman/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.initialize(requestPermission: true);
  const bool isDevicePreviewEnabled = false;
  AppConfig.setEnv(EnvValue.development);
  runApp(
    DevicePreview(
      enabled: isDevicePreviewEnabled,
      builder: (context) {
        return LocalWrapper(child: AppDev(env: EnvValue.development));
      },
    ),
  );
}
