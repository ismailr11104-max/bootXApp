import 'package:bootx_app/core/utils/app_colors.dart';
import 'package:bootx_app/core/utils/app_image.dart';
import 'package:bootx_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.text = 'Sign in with google',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImage.googleButton, height: 24, width: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: AppTextStyles.medium16.copyWith(
                color: AppColors.textLightPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
