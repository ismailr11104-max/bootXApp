class AppValidator {
  AppValidator._();

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال الاسم';
    }

    final trimmedValue = value.trim();

    if (trimmedValue.length < 3) {
      return 'يجب أن يتكون الاسم من 3 أحرف على الأقل';
    }

    final nameRegex = RegExp(r"^[\p{L}\s']+$", unicode: true);
    if (!nameRegex.hasMatch(trimmedValue)) {
      return 'يرجى إدخال اسم صحيح يحتوي على أحرف فقط';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }

    final trimmedValue = value.trim();

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(trimmedValue)) {
      return 'يرجى إدخال بريد إلكتروني صحيح (مثال: name@domain.com)';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }

    if (value.length < 8) {
      return 'يجب أن لا تقل كلمة المرور عن 8 خانات';
    }

    return null;
  }
}
