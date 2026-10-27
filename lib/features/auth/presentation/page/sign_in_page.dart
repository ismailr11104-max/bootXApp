import 'package:bootx_app/core/services/service_locator/setup_service_locator.dart';
import 'package:bootx_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bootx_app/features/auth/presentation/widget/sign_in_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const String signInRouts = 'sing_in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<AuthBloc>(),
        child: SignInBody(),
      ),
    );
  }
}
