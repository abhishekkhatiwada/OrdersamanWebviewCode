import 'package:ordersaman/common/utils/text_utils.dart';

class FormValidator {
  static String? validateEmail(String? val, [bool supportEmpty = false]) {
    if (supportEmpty && (val == null || val.isEmpty)) {
      return null;
    } else if (val == null) {
      return 'Email field cannot be empty';
    } else if (val.isEmpty) {
      return 'Email field cannot be empty';
    } else if (TextUtils.validateEmail(val)) {
      return null;
    } else {
      return 'Please enter valid email';
    }
  }

  static String? validatePassword(String? val, {String? label}) {
    final RegExp regex = RegExp(
      r"^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!]).*$",
    );
    if (val == null) {
      return 'Password field cannot be empty';
    } else if (val.isEmpty) {
      return 'Password field cannot be empty';
    } else if (regex.hasMatch(val)) {
      return null;
    } else {
      return 'Invalid Password';
    }
  }

  static String? validateConfirmPassword(
    String? val,
    String? newPassword, {
    String? label,
  }) {
    final RegExp regex = RegExp(
      r"^.*(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!]).*$",
    );
    if (val == null) {
      return 'Password field cannot be empty';
    } else if (val.isEmpty) {
      return 'Password field cannot be empty';
    } else if (regex.hasMatch(val)) {
      if (val == newPassword) {
        return null;
      } else {
        return 'Confirm Password does not match';
      }
    } else {
      return 'Invalid Password';
    }
  }

  static String? validateName(String? val) {
    if (val == null) {
      return 'Name field cannot be empty';
    } else if (val.isEmpty) {
      return 'Name field cannot be empty';
    } else {
      return null;
    }
  }

  static String? validateLandlineNumber(String? val) {
    final RegExp regExp = RegExp(r'([0-9]{8})');
    if (val == null) {
      return "Landline field cannot be empty";
    } else if (val.isEmpty) {
      return "Landline field cannot be empty";
    } else if (val.length != 10 && !regExp.hasMatch(val)) {
      return "Please enter valid landline number";
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    final RegExp regExp = RegExp(r'^[2-9]\d{2}-?\d{3}-?\d{4}$');

    if (val == null) {
      return 'Phone number field cannot be empty';
    } else if (val.isEmpty) {
      return 'Phone number field cannot be empty';
    } else if (!regExp.hasMatch(val)) {
      return 'Enter a valid phone number';
    } else {
      return null;
    }
  }

  static String? validateFieldNotEmpty(String? val, String fieldName) {
    if (val == null) {
      return 'Enter your $fieldName';
    } else if (val.isEmpty) {
      return 'Enter your $fieldName';
    } else {
      return null;
    }
  }

  static String? selectFieldNotEmpty(String? val, String fieldName) {
    if (val == null) {
      return 'Please select $fieldName';
    } else if (val.isEmpty) {
      return 'Please select $fieldName';
    } else {
      return null;
    }
  }

  static String? validateDateOfBirth(String? val) {
    if (val == null || val == "") {
      return "Date of birth field cannot be empty";
    } else if (val.isEmpty) {
      final DateTime dateTime = DateTime.parse(val);
      final maxDate = DateTime.now().year - 21;
      if (dateTime.year < maxDate) {
        return "Date of birth field cannot be empty";
      } else {
        return "Date of birth must be at least 21 years old";
      }
    } else {
      return null;
    }
  }

  static String? validateAmount(
    String val, {
    int minAmount = 10,
    int maxAmount = 2000000,
  }) {
    if (val.isEmpty) {
      return "Amount field cannot be empty";
    } else {
      double? amount = double.tryParse(val);
      if (amount == null) {
        return "Invalid amount";
      } else if (amount >= minAmount && amount <= maxAmount) {
        return null;
      } else {
        return "Amount must be between $minAmount and $maxAmount";
      }
    }
  }

  static String? validateNumberLength(String? val, int requiredLength) {
    if (val == null) {
      return "Field cannot be empty";
    } else if (val.isEmpty) {
      return "Field cannot be empty";
    } else if (val.length < requiredLength) {
      return "Must be $requiredLength digits long";
    } else {
      return null;
    }
  }
}
