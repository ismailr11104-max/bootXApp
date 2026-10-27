import 'package:bootx_app/core/utils/app_colors.dart';
import 'package:bootx_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class AuthHeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.medium28.copyWith(
            color: AppColors.textLightPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.textLightSecondary,
          ),
        ),
      ],
    );
  }
}
