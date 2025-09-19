import 'package:flutter/material.dart';
import 'package:ordersaman/features/web_load_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ordersaman/common/routes/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.root:
        return PageTransition(
          child: const WebLoadPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          settings: settings,
        );

      default:
        return PageTransition(
          child: const WebLoadPage(),
          type: PageTransitionType.fade,
          settings: settings,
          alignment: Alignment.center,
        );
    }
  }
}
