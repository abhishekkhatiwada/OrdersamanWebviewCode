import 'package:flutter/material.dart';
import 'package:ordersaman/app/app_colors.dart';
import 'package:ordersaman/common/utils/size_config.dart';
import 'package:ordersaman/common/widgets/%20buttons/custom_rounded_button.dart';
import 'package:ordersaman/common/widgets/bottom_sheet/bottom_sheet_wrapper.dart';
import 'package:ordersaman/common/widgets/title_description_widget.dart';

void showParkingDetailButtomSheet({
  required BuildContext context,
  final String? title,
  required String endPoint,
  required Function() onCallBack,
  bool isSingleSelection = false,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(36),
        topRight: Radius.circular(36),
      ),
    ),
    builder: (context) {
      return ParkingDetailButtomSheet(
        endPoint: endPoint,
        onCallBack: onCallBack,
        title: title ?? 'Select Items',
      );
    },
  );
}

class ParkingDetailButtomSheet extends StatefulWidget {
  final String title;
  final String endPoint;
  final Function() onCallBack;

  const ParkingDetailButtomSheet({
    super.key,
    required this.endPoint,

    required this.title,
    required this.onCallBack,
  });

  @override
  State<ParkingDetailButtomSheet> createState() =>
      _ParkingDetailButtomSheetState();
}

class _ParkingDetailButtomSheetState extends State<ParkingDetailButtomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return BottomSheetWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 218.hp,
            //  width: 218.wp,h
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.red,
            ),
          ),

          SizedBox(height: 23.hp),
          TitleDescriptionWidget(
            middleGap: 10,
            title: "Parking Nmae",
            fontSize: 16,
            description: "Parking Description",
          ),

          SizedBox(height: 25.hp),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the",
            style: textTheme.bodySmall!.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 24.hp),
          Text("Service", style: textTheme.titleMedium),
          SizedBox(height: 22.hp),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.hp),
                      child: Row(
                        children: [
                          Icon(Icons.check, size: 20),
                          SizedBox(width: 5.wp),
                          Text("Lorem", style: textTheme.bodySmall),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10.hp),
                      child: Row(
                        children: [
                          Icon(Icons.check, size: 20),
                          SizedBox(width: 5.wp),
                          Text("Lorem", style: textTheme.bodySmall),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.hp),

          CustomRoundedButton(title: "Book Now", onPressed: widget.onCallBack),
          SizedBox(height: 20.hp),
        ],
      ),
    );
  }
}
