class AppValidation {
  AppValidation._();

  static String? Function(String?) nameValidation = (name) {
    String pattern = AppRegExp.name;
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(name!)) {
      return null;
    } else if (name.isEmpty) {
      return ValidationErrorMessage.emptyField;
    } else {
      return ValidationErrorMessage.invalidName;
    }
  };

  static String? Function(String?) phoneNumberValidation = (phoneNumber) {
    String pattern = AppRegExp.phoneNumber;
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(phoneNumber!)) {
      return null;
    } else if (phoneNumber.isEmpty) {
      return ValidationErrorMessage.emptyField;
    } else {
      return ValidationErrorMessage.invalidPhoneNumber;
    }
  };
}

class AppRegExp {
  AppRegExp._();
  static const String name = r"^.{1,20}$";
  static const String phoneNumber = r"^[0-9]{9}$";
}

class ValidationErrorMessage {
  ValidationErrorMessage._();
  static String invalidName = "invalid name, max length is 20";
  static String invalidPhoneNumber =
      "phone number needs to be 9 digits, no need to add country code.";
  static String emptyField = 'this field is required';
}
