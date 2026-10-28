import 'package:bootx_app/features/onboarding/presentation/widget/page_view.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const onboardingRouts = 'onboarding_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PageViewWidget());
  }
}
