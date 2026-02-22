// Used with input fields for validation on inputs

import 'package:flutter/cupertino.dart';

class FormValidators {
  static String? emailValidator(String? value) {
    final emailReg = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (value!.isEmpty || value == '') {
      return 'Please Enter Email';
    }

    if (!emailReg.hasMatch(value)) {
      return "Please Enter a Valid Email";
    }

    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty || value == '') {
      return 'Please Enter Password';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  static String? nameValidator(String? value) {
    final nameReg = RegExp(r'^[a-zA-Z\s]{2,20}$');
    if (value!.isEmpty || value == '') {
      return 'Please Enter Name';
    }

    if (!nameReg.hasMatch(value)) {
      return 'Enter Proper Name';
    }

    return null;
  }

  static String? classValidator(String? value) {
    if (value == null) {
      return 'Please Select Class';
    }

    return null;
  }

  static String? confirmPasswordValidator(
    String? value,
    TextEditingController newPassword,
  ) {
    if (value != newPassword.text) {
      return 'Password Do Not Match';
    }

    return null;
  }
}
