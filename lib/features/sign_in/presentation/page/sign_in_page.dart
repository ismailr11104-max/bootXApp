import 'package:bootx_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const String signInRouts = 'sing_in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Ismail', style: AppTextStyles.medium40)),
    );
  }
}
