import 'package:bootx_app/core/utils/app_validator.dart';
import 'package:bootx_app/core/wigets/custom_button.dart';
import 'package:bootx_app/core/wigets/custom_text_from_field.dart';
import 'package:bootx_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bootx_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:bootx_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:bootx_app/features/auth/presentation/page/sign_in_page.dart';
import 'package:bootx_app/features/auth/presentation/widget/auth_footer_widget.dart';
import 'package:bootx_app/features/auth/presentation/widget/auth_header_widget.dart';
import 'package:bootx_app/features/auth/presentation/widget/google_signIn_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
              const AuthHeaderWidget(
                title: 'Create Account',
                subtitle: 'Let’s Create Account Together',
              ),
              const SizedBox(height: 50),
              CustomTextFormField(
                labelText: 'Your Name',
                hintText: 'Alisson Becker',
                validator: AppValidator.validateName,
                keyboardType: TextInputType.name,
                controller: _nameController,
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                labelText: 'Email Address',
                hintText: 'AlissonBecker@gmail.com',
                validator: AppValidator.validateEmail,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 24),
              CustomTextFormField(
                labelText: 'Phone Number',
                hintText: '0599000000',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your phone number';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
                controller: _phoneController,
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
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Account created for ${state.user.name}'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context)
                        .pushReplacementNamed(SignInPage.signInRouts);
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
                    text: isLoading ? 'Creating Account...' : 'Sign Up',
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthBloc>().add(
                                SignUpRequested(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  password: _passwordController.text,
                                ),
                              );
                            }
                          },
                  );
                },
              ),
              const SizedBox(height: 24),
              GoogleSignInButton(onPressed: () {}, text: 'Sign Up with google'),
              const SizedBox(height: 20),
              AuthFooterWidget(
                firstText: 'Already have an account?',
                actionText: 'Sign in',
                onTap: () {
                  Navigator.of(context).pushNamed(SignInPage.signInRouts);
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
