import 'package:bootx_app/features/auth/presentation/page/sign_in_page.dart';
import 'package:bootx_app/features/auth/presentation/page/sign_up_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SignInPage.signInRouts:
      return MaterialPageRoute(builder: (context) => const SignInPage());
    case SignUpPage.signupRouts:
      return MaterialPageRoute(builder: (context) => const SignUpPage());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
