import 'package:bootx_app/core/services/shared_preferences/shared_pref_manger.dart';
import 'package:bootx_app/core/utils/app_image.dart';
import 'package:bootx_app/features/auth/presentation/page/sign_in_page.dart';
import 'package:bootx_app/features/home/presentation/page/home_page.dart';
import 'package:bootx_app/features/onboarding/presentation/page/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    executeNavigation();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SvgPicture.asset(AppImage.splashImage),
    );
  }

  void executeNavigation() {
    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;
      final bool onboardingCompleted =
          PrefManger.SharedPrefManger().getBool("onboarding_completed") ??
          false;
      final bool isSignIn =
          PrefManger.SharedPrefManger().getBool("isSignIn") ?? false;
      if (!onboardingCompleted) {
        Navigator.of(context)
            .pushReplacementNamed(OnboardingPage.onboardingRouts);
      } else if (!isSignIn) {
        Navigator.of(context).pushReplacementNamed(SignInPage.signInRouts);
      } else {
        Navigator.of(context).pushReplacementNamed(HomePage.homeRouts);
      }
    });
  }
}
