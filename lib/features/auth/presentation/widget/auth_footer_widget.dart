import 'package:bootx_app/core/utils/app_colors.dart';
import 'package:bootx_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthFooterWidget extends StatelessWidget {
  final String firstText;
  final String actionText;
  final VoidCallback onTap;

  const AuthFooterWidget({
    super.key,
    required this.firstText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text.rich(
        TextSpan(
          text: '$firstText ',
          style: AppTextStyles.medium14.copyWith(
            color: AppColors.textLightSecondary,
          ),
          children: [
            TextSpan(
              text: actionText,
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.textLightPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
