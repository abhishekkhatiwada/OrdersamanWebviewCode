import 'package:ordersaman/common/enum/app_environment.dart';

class Env {
  Env({
    required this.baseUrl,
    required this.imageUrl,
    required this.appEnvironment,
    required this.signatureKey,
  });

  final String baseUrl;
  final String imageUrl;
  final AppEnvironment appEnvironment;
  final String signatureKey;
}

class EnvValue {
  static final Env development = Env(
    baseUrl: 'https://dev.frontend.ordersaman.com',
    imageUrl: 'https://dev.frontend.ordersaman.com',
    appEnvironment: AppEnvironment.development,
    signatureKey: "uat_test",
  );

  static final Env production = Env(
    baseUrl: 'https://dev.frontend.ordersaman.com',
    imageUrl: 'https://dev.frontend.ordersaman.com',
    appEnvironment: AppEnvironment.production,
    signatureKey: '',
  );
}
