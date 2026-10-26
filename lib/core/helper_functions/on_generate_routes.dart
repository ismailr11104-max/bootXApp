import 'package:bootx_app/features/sign_in/presentation/page/sign_in_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SignInPage.signInRouts:
      return MaterialPageRoute(builder: (context) => const SignInPage());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
