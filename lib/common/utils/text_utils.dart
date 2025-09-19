import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mp;
import 'package:flutter/services.dart';

enum TextSizeType { width, height }

class TextUtils {
  static Map<String, String> splitName(String fullname) {
    final temp = fullname.split(" ");
    String fname = "";
    String lname = "";

    if (temp.length > 1) {
      fname = temp.first;
      lname = temp.sublist(1).join(" ");
    } else {
      fname = temp.first;
    }

    return {'firstname': fname, 'lastname': lname};
  }

  static bool validateEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  static String get generateGreet {
    final int hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  static double getRequiredTextSize({
    required String mytext,
    required TextStyle style,
    required double maxWidth,
    TextAlign textAlign = TextAlign.left,
    required BuildContext context,
    TextSizeType sizeType = TextSizeType.height,
  }) {
    final textHeightBehaviour = DefaultTextStyle.of(context).textHeightBehavior;
    const textWidthBasis = TextWidthBasis.parent;
    final span = TextSpan(text: mytext, style: style);
    final tp = TextPainter(
      textAlign: textAlign,
      text: span,
      textDirection: mp.TextDirection.ltr,
      textHeightBehavior: textHeightBehaviour,
      textWidthBasis: textWidthBasis,
    );
    tp.layout(maxWidth: maxWidth);
    if (sizeType == TextSizeType.height) {
      return tp.size.height;
    } else {
      return tp.size.width;
    }
  }

  static List<TextInputFormatter> get textOnlyFormater => [
    FilteringTextInputFormatter(RegExp(r'[a-zA-Z ]'), allow: true),
  ];

  static List<TextInputFormatter> get numberOnlyFormater => [
    FilteringTextInputFormatter.digitsOnly,
  ];

  static List<TextInputFormatter> get decimalInputFormater => [
    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
  ];

  static String filterSpecialCharacterExceptPlus(String val) {
    return val
        .replaceAll(RegExp('[^+0-9]'), "")
        .trim()
        .replaceAll("+977", "")
        .replaceAll("977", "")
        .trim();
  }
}

extension Capitalize on String {
  String capitalize({bool allWords = true}) {
    if (isEmpty) {
      return this;
    }
    if (allWords) {
      final List<String> words = split(' ');
      final List<String> capitalized = <String>[];
      for (var w in words) {
        capitalized.add(w.capitalize(allWords: false));
      }
      return capitalized.join(' ');
    } else {
      return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
    }
  }

  String nameShortcut() {
    final List<String> items =
        split(" ").map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (items.isEmpty) {
      return "";
    } else if (items.length == 1) {
      return items[0];
    } else {
      return "${items.first[0]}${items.last[0]}";
    }
  }
}

String formatFreightType(String freightType) {
  return freightType
      .split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}

String formatFileNameFromUrl(String url) {
  final fileName = url.split('/').last;

  final nameWithoutExtension = fileName
      .split(RegExp(r'[_-]'))
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  return nameWithoutExtension;
}

String formatPrice(String amount) {
  final parsedAmount = double.tryParse(amount);
  if (parsedAmount == null) return '\$0.00';
  return '\$${parsedAmount.toStringAsFixed(2)}';
}
