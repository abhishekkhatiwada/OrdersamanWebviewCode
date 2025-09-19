import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ordersaman/app/app_prod.dart';
import 'package:ordersaman/common/constants/env.dart';
import 'package:ordersaman/common/utils/custom_log.dart';
import 'package:ordersaman/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runZonedGuarded(
    () {
      runApp(AppProd(env: EnvValue.production));
    },
    (e, s) {
      CustomLog.error(e);
      CustomLog.action(s);
    },
  );
}
