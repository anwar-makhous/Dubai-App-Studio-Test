class AppValidation {
  AppValidation._();

  static String? Function(String?) emailValidation = (email) {
    String pattern = AppRegExp.email;
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(email!)) {
      return null;
    } else if (email.isEmpty) {
      return ValidationErrorMessage.emptyField;
    } else {
      return ValidationErrorMessage.invalidEmail;
    }
  };

  static String? Function(String?) passwordValidation = (password) {
    String pattern = AppRegExp.password;
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(password!)) {
      return null;
    } else if (password.isEmpty) {
      return ValidationErrorMessage.emptyField;
    } else {
      return ValidationErrorMessage.invalidPassword;
    }
  };
}

class AppRegExp {
  AppRegExp._();
  static const String email = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String password =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$';
}

class ValidationErrorMessage {
  ValidationErrorMessage._();
  static String invalidEmail = 'invalid email';
  static String invalidPassword =
      'The password is invalid.  Passwords must be 8 characters long, have one uppercase letter, one lowercase letter and one digit';
  static String emptyField = 'this field is required';
}
