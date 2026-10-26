import 'package:bootx_app/features/onboarding/data/model/onboarding_model.dart';
import 'package:bootx_app/features/onboarding/presentation/widget/item_onboarding.dart';
import 'package:flutter/material.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({super.key});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      itemCount: OnboardingModel.itemOnboarding.length,
      itemBuilder: (context, index) {
        return ItemOnboarding(
          item: OnboardingModel.itemOnboarding[index],
          controller: _pageController,
          index: index,
        );
      },
    );
  }
}
