class Validators {
  /// Regular Expressions
  static final RegExp _nameRegExp = RegExp(
    r'^[A-Za-z\s]+$',
  ); // only letters + spaces
  static final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  ); // basic email regex
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
  );
  // 8+ chars, at least one letter, one number, one special char

  /// Name: required, only letters and spaces
  static String? validateName(String name) {
    if (name.trim().isEmpty) {
      return 'Full Name is required';
    }
    if (!_nameRegExp.hasMatch(name.trim())) {
      return 'Name can only contain letters and spaces';
    }
    if (name.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  /// Email: required, must match email format
  static String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return 'Email is required';
    }
    if (!_emailRegExp.hasMatch(email.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Password: required, must be 8+ chars with letters, numbers, special char
  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (!_passwordRegExp.hasMatch(password)) {
      return 'Password must be 8+ chars, include letters, numbers, and special characters';
    }
    return null;
  }

  /// Confirm Password: must match password
  static String? validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (confirmPassword.isEmpty) {
      return 'Confirm Password is required';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
