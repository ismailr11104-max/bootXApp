import 'package:bootx_app/core/services/shared_preferences/shared_pref_manger.dart';
import 'package:bootx_app/core/utils/app_validator.dart';
import 'package:bootx_app/core/wigets/custom_button.dart';
import 'package:bootx_app/core/wigets/custom_text_from_field.dart';
import 'package:bootx_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bootx_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:bootx_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:bootx_app/features/auth/presentation/page/sign_up_page.dart';
import 'package:bootx_app/features/auth/presentation/widget/auth_footer_widget.dart';
import 'package:bootx_app/features/auth/presentation/widget/auth_header_widget.dart';
import 'package:bootx_app/features/auth/presentation/widget/google_signIn_button.dart';
import 'package:bootx_app/features/home/presentation/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const AuthHeaderWidget(
                title: 'Hello Again!',
                subtitle: 'Welcome Back You’ve Been Missed!',
              ),
              const SizedBox(height: 50),
              CustomTextFormField(
                labelText: 'Email Address',
                hintText: 'AlissonBecker@gmail.com',
                validator: AppValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                labelText: 'Password',
                isPassword: true,
                hintText: 'Enter your password',
                validator: AppValidator.validatePassword,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
              ),
              const SizedBox(height: 24),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    PrefManger.SharedPrefManger().setBool('isSignIn', true);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Welcome back, ${state.user.name}!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context)
                        .pushReplacementNamed(HomePage.homeRouts);
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AuthLoading;

                  return CustomButton(
                    text: isLoading ? 'Signing In...' : 'Sign In',
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthBloc>().add(
                                SignInRequested(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          },
                  );
                },
              ),
              const SizedBox(height: 24),
              GoogleSignInButton(onPressed: () {}),
              const SizedBox(height: 40),
              AuthFooterWidget(
                firstText: 'Don’t have an account?',
                actionText: 'Sign Up ',
                onTap: () {
                  Navigator.of(context).pushNamed(SignUpPage.signupRouts);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
