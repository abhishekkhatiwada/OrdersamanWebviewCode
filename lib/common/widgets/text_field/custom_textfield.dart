import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordersaman/app/app_colors.dart';
import 'package:ordersaman/common/enum/text_field_type.dart';
import 'package:ordersaman/common/utils/size_config.dart';
import 'package:ordersaman/common/widgets/%20buttons/custom_icon_button.dart';

class CustomTextField extends FormField<String> {
  CustomTextField({
    super.key,
    this.controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmited,
    String hintText = "",
    bool showSearchIcon = false,
    bool readOnly = false,
    TextFieldType type = TextFieldType.outline,
    String title = "",
    bool required = false,
    EdgeInsets? margin,
    TextInputType textInputType = TextInputType.text,
    IconData? suffixIcon,
    IconData? prefixIcon,
    VoidCallback? onSuffixPressed,
    int? maxLength,
    double bottomMargin = 0,
    double horizontalMargin = 0,
    super.autovalidateMode,
    bool? enabled,
    super.onSaved,
    super.validator,
    super.restorationId,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
    Widget? prefix,
    int maxLine = 1,
    double borderRadius = 5,
    Widget? trailingTitle,
    bool obscureText = false,
    double suffixIconSize = 25,
    List<TextInputFormatter>? inputFormatters,
    TextInputAction? textInputAction,
  }) : super(
         enabled: enabled ?? true,
         initialValue: controller?.text ?? "",
         builder: (FormFieldState<String> field) {
           final _CustomTextFieldState state = field as _CustomTextFieldState;
           final InputDecoration effectiveDecoration = InputDecoration(
             counterText: "",
             // hintText: hintText,
             prefix: prefix,
             labelText: hintText,
             labelStyle: const TextStyle(
               fontFamily: "Poppins",
               fontWeight: FontWeight.w400,
               fontSize: 14,
               color: AppColors.hintTextColor,
             ),

             hintStyle: const TextStyle(
               fontFamily: "Poppins",
               fontWeight: FontWeight.w400,
               fontSize: 14,
               color: AppColors.hintTextColor,
             ),
             border: InputBorder.none,
             errorBorder: InputBorder.none,
             enabledBorder: InputBorder.none,
             focusedBorder: InputBorder.none,
             disabledBorder: InputBorder.none,
             focusedErrorBorder: InputBorder.none,
           ).applyDefaults(Theme.of(field.context).inputDecorationTheme);
           void onChangedHandler(String value) {
             field.didChange(value);
             if (onChanged != null) {
               onChanged(value);
             }
           }

           return Container(
             margin:
                 margin ??
                 EdgeInsets.only(
                   bottom: bottomMargin,
                   left: horizontalMargin,
                   right: horizontalMargin,
                 ),
             child: UnmanagedRestorationScope(
               bucket: field.bucket,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         padding: EdgeInsets.only(
                           bottom:
                               (trailingTitle != null || title.isNotEmpty)
                                   ? 5
                                   : 0,
                         ),
                         child: Row(
                           children: [
                             if (title.isNotEmpty)
                               RichText(
                                 text: TextSpan(
                                   text: title,
                                   style: const TextStyle(
                                     fontFamily: "Poppins",
                                     fontWeight: FontWeight.w700,
                                     fontSize: 14,
                                     color: AppColors.black,
                                   ),
                                   children: [
                                     if (required)
                                       const TextSpan(
                                         text: "*",
                                         style: TextStyle(
                                           fontFamily: "Poppins",
                                           fontSize: 14,
                                           fontWeight: FontWeight.bold,
                                           color: AppColors.red,
                                         ),
                                       ),
                                   ],
                                 ),
                               ),
                             const Spacer(),
                             if (trailingTitle != null) trailingTitle,
                           ],
                         ),
                       ),
                       GestureDetector(
                         onTap: onTap,
                         child: Row(
                           children: [
                             if (leading != null) leading,
                             Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                   color:
                                       type == TextFieldType.filled
                                           ? AppColors.lightTextfieldBgColor
                                           : AppColors.lightTextfieldBgColor,
                                   borderRadius: BorderRadius.circular(
                                     borderRadius,
                                   ),
                                   border:
                                       type == TextFieldType.outline
                                           ? Border.all(
                                             width: 1,
                                             color: AppColors.primaryColor,
                                           )
                                           : null,
                                 ),
                                 padding: EdgeInsets.only(
                                   left: AppColors.symmetricHozPadding - 10,
                                   right:
                                       showSearchIcon
                                           ? 0
                                           : AppColors.symmetricHozPadding,
                                 ),
                                 child: Row(
                                   children: [
                                     prefixIcon != null
                                         ? Row(
                                           children: [
                                             Icon(
                                               prefixIcon,
                                               size: 20,
                                               color: AppColors.primaryColor,
                                             ),
                                             const SizedBox(width: 8),
                                           ],
                                         )
                                         : const SizedBox(width: 5),
                                     Expanded(
                                       child: TextField(
                                         obscureText: obscureText,
                                         restorationId: restorationId,
                                         controller: state._effectiveController,
                                         decoration: effectiveDecoration,
                                         keyboardType: textInputType,
                                         maxLength: maxLength,
                                         onChanged: onChangedHandler,
                                         textInputAction: textInputAction,
                                         enableInteractiveSelection: !readOnly,
                                         readOnly: readOnly,
                                         maxLines: maxLine,
                                         inputFormatters: inputFormatters,
                                         cursorColor: AppColors.black,
                                         onEditingComplete: () {
                                           FocusScope.of(
                                             field.context,
                                           ).unfocus();
                                           if (onSubmited != null) {
                                             onSubmited(controller?.text ?? "");
                                           }
                                         },
                                         onTap: onTap,
                                         style: const TextStyle(
                                           fontFamily: "Poppins",
                                           fontWeight: FontWeight.w400,
                                           fontSize: 14,
                                           color: AppColors.black,
                                         ),
                                       ),
                                     ),
                                     if (showSearchIcon)
                                       CustomIconButton(
                                         backgroundColor: Colors.transparent,
                                         icon: suffixIcon ?? Icons.search,
                                         shadow: false,
                                         iconSize: suffixIconSize,
                                         iconColor:
                                             AppColors.lightTextfieldIconColor,
                                         onPressed: onSuffixPressed,
                                       ),
                                     SizedBox(width: 10.wp),
                                   ],
                                 ),
                               ),
                             ),
                             if (trailing != null) trailing,
                           ],
                         ),
                       ),
                     ],
                   ),
                   if (state.hasError)
                     Container(
                       padding: EdgeInsets.only(top: 4.hp),
                       child: Text(
                         state.errorText!,
                         style: const TextStyle(
                           fontFamily: "Poppins",
                           fontWeight: FontWeight.w400,
                           fontSize: 12,
                           color: Colors.red,
                         ),
                       ),
                     ),
                 ],
               ),
             ),
           );
         },
       );

  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!.value;

  @override
  CustomTextField get widget => super.widget as CustomTextField;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }

    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller =
        value == null
            ? RestorableTextEditingController()
            : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _createLocalController(
        widget.initialValue != null
            ? TextEditingValue(text: widget.initialValue!)
            : null,
      );
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
