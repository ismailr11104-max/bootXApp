import 'package:bootx_app/core/services/shared_preferences/shared_pref_manger.dart';
import 'package:bootx_app/core/utils/app_colors.dart';
import 'package:bootx_app/core/utils/app_image.dart';
import 'package:bootx_app/core/utils/app_text_styles.dart';
import 'package:bootx_app/features/onboarding/data/model/onboarding_model.dart';
import 'package:bootx_app/features/sign_in/presentation/page/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemOnboarding extends StatelessWidget {
  const ItemOnboarding({
    super.key,
    required this.item,
    required this.controller,
    required this.index,
  });

  final OnboardingModel item;
  final PageController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    final itemsList = OnboardingModel.itemOnboarding;

    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 40,
          child: SvgPicture.asset(AppImage.ellipse, fit: BoxFit.cover),
        ),

        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Image.asset(item.image, fit: BoxFit.contain),
                ),
                const SizedBox(height: 20),
                Text(
                  item.title,
                  textAlign: TextAlign.left,
                  style: AppTextStyles.medium40,
                ),
                const SizedBox(height: 12),
                Text(
                  item.supTitle,
                  textAlign: TextAlign.left,
                  style: AppTextStyles.medium20,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: controller,
                      count: itemsList.length,
                      axisDirection: Axis.horizontal,
                      effect: ExpandingDotsEffect(
                        spacing: 8.0,
                        radius: 16.0,
                        dotWidth: 8,
                        dotHeight: 5,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1.5,
                        dotColor: AppColors.lightBlue,
                        activeDotColor: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.lightBlue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          if (index == itemsList.length - 1) {
                            PrefManger.SharedPrefManger().setBool(
                              'isOnboarding',
                              true,
                            );
                            Navigator.of(context)
                                .pushNamed(SignInPage.signInRouts);
                          } else {
                            controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(
                          index == itemsList.length - 1
                              ? 'Get Started'
                              : 'Next',
                          style: AppTextStyles.medium18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
