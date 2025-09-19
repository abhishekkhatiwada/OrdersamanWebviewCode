import 'package:flutter/material.dart';
import 'package:ordersaman/app/app_colors.dart';
import 'package:ordersaman/common/utils/size_config.dart';

class BottomSheetWrapper extends StatelessWidget {
  final EdgeInsets? padding;
  final double? topPadding;
  final Widget child;
  final bool showTopDivider;
  final int widgetSpacing;
  final String? title;
  const BottomSheetWrapper({
    super.key,
    this.padding,
    this.topPadding,
    this.showTopDivider = true,
    this.widgetSpacing = 17,
    this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Container(
        padding:
            padding ??
            EdgeInsets.only(
              left: AppColors.symmetricHozPadding,
              right: AppColors.symmetricHozPadding,
              top: 15.hp,
              bottom: 10.hp,
            ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null)
              Text(
                title!,
                // style: AppColors.titleLarge.copyWith(
                //   fontWeight: FontWeight.bold,
                // ),
              ),
            if (showTopDivider)
              Container(
                height: 4,
                width: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.gray,
                ),
              ),
            SizedBox(height: widgetSpacing.hp),
            child,
          ],
        ),
      ),
    );
  }
}
