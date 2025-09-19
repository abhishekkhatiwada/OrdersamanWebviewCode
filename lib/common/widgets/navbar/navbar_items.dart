import 'package:flutter/material.dart';

class NavbarItem {
  final String? title;
  final String? icon;
  final Widget? customWidget;

  NavbarItem({this.icon, this.title, this.customWidget})
    : assert(icon != null || customWidget != null);
}

enum NavbarType { fixed, floating }
