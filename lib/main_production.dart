import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ordersaman/app/app_prod.dart';
import 'package:ordersaman/app/local_wrapper.dart';
import 'package:ordersaman/app/notification_service.dart';
import 'package:ordersaman/common/constants/app_config.dart';
import 'package:ordersaman/firebase_options.dart';
import 'common/constants/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.initialize(requestPermission: true);
  AppConfig.setEnv(EnvValue.development);
  runApp(LocalWrapper(child: AppProd(env: EnvValue.production)));
}
