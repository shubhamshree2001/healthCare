import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';

class ValidationUtil {
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp fullNameValidatorRegExp = RegExp(r'^[a-z A-Z,.\-]+$');
  static final RegExp passwordValidatorRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  static final RegExp for8letters = RegExp(r'/^(?=.*\d).{8,}$/');

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email address is required';
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      return 'Please enter your e-mail address';
    } else {
      return null;
    }
  }

  static String? validateFullName(String value) {
    if (value.isEmpty || !fullNameValidatorRegExp.hasMatch(value)) {
      return 'Please enter full name';
    } else {
      return null;
    }
  }

  static String? validateOrganixzationName(String value) {
    if (value.isEmpty || !fullNameValidatorRegExp.hasMatch(value)) {
      return 'Please enter Organization name';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password may be incorrect, please check.';
    } else {
      return null;
    }
  }

  static String? validateMobileNo(String value) {
    if (value.isEmpty || value.length < 7) {
      return 'Please enter a valid phone number';
    } else {
      return null;
    }
  }

  static String? validateCorporateAccessCode(String value) {
    if (value.isEmpty) {
      return 'Please enter access code';
    } else {
      return null;
    }
  }

  static String? validateGiftCouponCode(String value) {
    if (value.isEmpty) {
      return 'Please enter Coupon code';
    } else {
      return null;
    }
  }

  static bool? isValidatePassword(String value) {
    if (value.isEmpty || !passwordValidatorRegExp.hasMatch(value)) {
      //!passwordValidatorRegExp.hasMatch(value)
      return false;
    } else {
      return true;
    }
  }

  static String? validateCoupon(String value) {
    if (value.isEmpty) {
      return 'Please Enter Promo Code';
    } else {
      return null;
    }
  }
}

class TherapyRecipientFormValidation {
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required*';
    } else {
      return null;
    }
  }

  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email address is required*';
    } else if (!ValidationUtil.emailValidatorRegExp.hasMatch(value)) {
      return 'Email address is invalid*';
    } else if (LocalStorage.getEmail() == value) {
      return 'Email should be different from Logged In User*';
    } else {
      return null;
    }
  }

  static String? validateConfirmEmail(
      {required String email, required String confirmEmail}) {
    if (confirmEmail.isEmpty) {
      return 'Confirm Email is required*';
    } else if (confirmEmail != email) {
      return 'Email not matched*';
    } else {
      return null;
    }
  }

  static String? validateMobile(value) {
    if (value.isEmpty) {
      return 'Number is required*';
    } else {
      return null;
    }
  }
}

class BookingTherapyValidation {
  static String? validateDob(String value) {
    if (value.isEmpty) {
      return 'Date of Birth is Required*';
    } else {
      return null;
    }
  }

  static String? validateGuardianName(String value) {
    if (value.isEmpty) {
      return 'Guardian Name is required if you are under 18*';
    } else {
      return null;
    }
  }

  static String? validateGuardianEmail(String value) {
    if (value.isEmpty) {
      return 'Guardian Email is required if you are under 18*';
    } else if (!ValidationUtil.emailValidatorRegExp.hasMatch(value)) {
      return 'Email is invalid*';
    } else {
      return null;
    }
  }

  static String? validateGuardianPhone(String value) {
    if (value.isEmpty) {
      return 'Guardian Phone is required if you are under 18*';
    } else {
      return null;
    }
  }
}
