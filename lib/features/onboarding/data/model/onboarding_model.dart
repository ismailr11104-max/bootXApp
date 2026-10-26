import 'package:bootx_app/core/utils/app_image.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String supTitle;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.supTitle,
  });

  static List<OnboardingModel> itemOnboarding = [
    OnboardingModel(
      image: AppImage.onboardingImag1,
      title: 'Start Journey With Nike',
      supTitle: 'Smart, Gorgeous & Fashionable Collection',
    ),

    OnboardingModel(
      image: AppImage.onboardingImag2,
      title: 'Start Journey With Nike',
      supTitle: 'There Are Many Beautiful And Attractive Plants To Your Room',
    ),
    OnboardingModel(
      image: AppImage.onboardingImag3,
      title: 'Summer Shoes Nike 2026',
      supTitle: 'Amet Minim Lit Nodeseru Saku Nandu sit Alique Dolor',
    ),
  ];
}
