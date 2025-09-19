import 'package:ordersaman/common/constants/env.dart';

class AppConfig {
  static late Env current;

  static void setEnv(Env env) {
    current = env;
  }
}
