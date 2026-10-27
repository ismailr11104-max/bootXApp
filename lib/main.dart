import 'package:bootx_app/core/helper_functions/on_generate_routes.dart';
import 'package:bootx_app/core/services/service_locator/setup_service_locator.dart';
import 'package:bootx_app/core/services/shared_preferences/shared_pref_manger.dart';
import 'package:bootx_app/core/utils/app_colors.dart';
import 'package:bootx_app/features/onboarding/presentation/page/onboarding_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await PrefManger.SharedPrefManger().init();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (BuildContext context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: onGenerateRoutes,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xffF8F9FA),
        fontFamily: 'DM Mono',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      home: OnboardingPage(),
    );
  }
}
