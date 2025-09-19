import 'package:flutter/material.dart';
import 'package:ordersaman/app/app_colors.dart';
import 'package:ordersaman/common/utils/size_config.dart';

class CustomCircleWidget extends StatelessWidget {
  final double size;
  final Color color;
  final EdgeInsets margin;

  const CustomCircleWidget({
    super.key,
    this.size = 6,
    this.color = AppColors.black,
    this.margin = const EdgeInsets.symmetric(horizontal: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: size.hp,
      width: size.wp,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
