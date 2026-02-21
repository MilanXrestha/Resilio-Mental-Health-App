/// Validation utility class for form fields
class Validators {
  Validators._();

  /// Validates email address
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  /// Validates password with minimum requirements
  static String? validatePassword(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    // Check for at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    
    return null;
  }

  /// Validates simple password (less strict)
  static String? validateSimplePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    
    return null;
  }

  /// Validates confirm password matches
  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  /// Validates name field
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    
    // Check for valid characters (letters, spaces, hyphens, apostrophes)
    final nameRegex = RegExp(r"^[a-zA-Z\s\-'']+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return '$fieldName contains invalid characters';
    }
    
    return null;
  }

  /// Validates full name (first and last name)
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    
    final trimmedValue = value.trim();
    
    if (trimmedValue.length < 3) {
      return 'Full name must be at least 3 characters';
    }
    
    // Check for at least two words (first and last name)
    final nameParts = trimmedValue.split(RegExp(r'\s+'));
    if (nameParts.length < 2) {
      return 'Please enter your first and last name';
    }
    
    return validateName(value, fieldName: 'Name');
  }

  /// Validates phone number
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.length < 10) {
      return 'Please enter a valid phone number';
    }
    
    if (digitsOnly.length > 15) {
      return 'Phone number is too long';
    }
    
    return null;
  }

  /// Validates that field is not empty
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validates minimum length
  static String? validateMinLength(String? value, int minLength, {String fieldName = 'Field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    if (value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    
    return null;
  }

  /// Validates maximum length
  static String? validateMaxLength(String? value, int maxLength, {String fieldName = 'Field'}) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }
    return null;
  }

  /// Validates URL
  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'URL is required';
    }
    
    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    
    if (!urlRegex.hasMatch(value.trim())) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  /// Combines multiple validators
  static String? combine(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
