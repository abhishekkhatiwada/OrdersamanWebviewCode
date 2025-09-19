import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordersaman/app/app_colors.dart';
import 'package:ordersaman/common/enum/text_field_type.dart';
import 'package:ordersaman/common/utils/size_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinCodeField extends StatelessWidget {
  final TextEditingController? controller;
  final int length;
  final void Function(String) onChanged;
  final bool isObscureText;
  final double? fieldHeight;
  final double? fieldWidth;
  final String? Function(String?)? validator;
  final TextFieldType type;
  final MainAxisAlignment mainAxisAlignment;
  const CustomPinCodeField({
    super.key,
    this.controller,
    this.length = 6,
    required this.onChanged,
    this.isObscureText = true,
    this.fieldHeight,
    this.fieldWidth,
    this.validator,
    this.type = TextFieldType.filled,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      obscureText: isObscureText,
      appContext: context,
      length: length,
      blinkWhenObscuring: true,
      blinkDuration: const Duration(milliseconds: 450),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      errorTextMargin: EdgeInsets.only(bottom: 5.hp, top: 10.hp),
      errorTextSpace: 20,
      controller: controller,
      textStyle: Theme.of(context).textTheme.titleLarge,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: fieldHeight ?? 40.wp,
        fieldWidth: fieldWidth ?? 40.wp,
        borderWidth: 1,
        fieldOuterPadding:
            mainAxisAlignment == MainAxisAlignment.start
                ? EdgeInsets.only(right: 5.wp)
                : EdgeInsets.zero,
        activeColor: AppColors.primaryColor,
        activeFillColor:
            type == TextFieldType.filled
                ? AppColors.lightGray
                : Colors.transparent,
        selectedColor: AppColors.primaryColor,
        selectedFillColor:
            type == TextFieldType.filled
                ? AppColors.lightGray
                : Colors.transparent,
        inactiveFillColor:
            type == TextFieldType.filled
                ? AppColors.lightGray
                : Colors.transparent,
        inactiveColor:
            type == TextFieldType.filled
                ? AppColors.lightGray
                : AppColors.lightGray,
      ),
      mainAxisAlignment: mainAxisAlignment,
      animationType: AnimationType.fade,
      enableActiveFill: true,
      autovalidateMode: AutovalidateMode.disabled,
      cursorColor: AppColors.black,
      cursorHeight: 20,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
