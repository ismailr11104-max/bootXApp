import 'package:bootx_app/core/services/service_locator/setup_service_locator.dart';
import 'package:bootx_app/core/utils/app_image.dart';
import 'package:bootx_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bootx_app/features/auth/presentation/widget/Sign_up_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const String signupRouts = 'sing_up';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppImage.backButton,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SignUpBody(),
      ),
    );
  }
}
