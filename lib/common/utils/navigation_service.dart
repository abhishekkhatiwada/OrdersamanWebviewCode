import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationService {
  // Singleton Pattern
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() => _instance;

  NavigationService._internal();

  // Navigation Key
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // Push Named Route
  static Future<dynamic>? pushNamed({required String routeName, Object? args}) {
    return _navigatorKey.currentState?.pushNamed(routeName, arguments: args);
  }

  // Push Named with Replacement
  static Future<dynamic>? pushReplacementNamed({
    required String routeName,
    Object? args,
  }) {
    return _navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: args,
    );
  }

  // Push with Page Transition
  static Future<dynamic>? push({
    String routeName = '',
    required Widget target,
    Object? args,
  }) {
    return _navigatorKey.currentState?.push(
      PageTransition(
        child: target,
        type: PageTransitionType.fade,
        settings: RouteSettings(name: routeName, arguments: args),
      ),
    );
  }

  // Push Replacement with Page Transition
  static Future<dynamic>? pushReplacement({
    String routeName = '',
    required Widget target,
    Object? args,
  }) {
    return _navigatorKey.currentState?.pushReplacement(
      PageTransition(
        child: target,
        type: PageTransitionType.fade,
        settings: RouteSettings(name: routeName, arguments: args),
      ),
    );
  }

  // Push Until (Remove all previous screens)
  static Future<dynamic>? pushUntil({
    String routeName = '',
    required Widget target,
    Object? args,
  }) {
    return _navigatorKey.currentState?.pushAndRemoveUntil(
      PageTransition(
        child: target,
        type: PageTransitionType.fade,
        settings: RouteSettings(name: routeName, arguments: args),
      ),
      (Route<dynamic> route) => false,
    );
  }

  // Pop Function (Safe Check)
  static void pop() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop();
    }
  }

  // Pop Until a Specific Route
  static void popUntil({required String routeName}) {
    _navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  // Pop Until First Page
  static void popUntilFirstPage() {
    _navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  // Push Named and Remove Until
  static void pushNamedAndRemoveUntil({
    required String routeName,
    Object? args,
  }) {
    _navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: args,
    );
  }

  // Get Current Context (Safe Check)
  static BuildContext? get context =>
      _navigatorKey.currentState?.overlay?.context;
}
