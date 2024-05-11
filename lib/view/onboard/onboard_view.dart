import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:synergy/res/components/custom_button.dart';
import 'package:synergy/res/components/onboard_first.dart';
import 'package:synergy/res/components/onboard_second.dart';
import 'package:synergy/res/components/onboard_third.dart';
import 'package:synergy/viewmodel/controller/onboard/onboard_viewmodel.dart';

class OnboardView extends StatelessWidget {
  OnboardView({super.key});
  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onboardViewmodel = Get.put(OnboardViewmodel());
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    onboardViewmodel.currentPage.value = value;
                  },
                  controller: _controller,
                  children: const [
                    OnboardFirst(),
                    OnboardSecond(),
                    OnboardThird(),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  isLoading: onboardViewmodel.isLoading.value,
                  btnTitle: onboardViewmodel.currentPage.value == 2
                      ? 'Get started'
                      : 'Continue',
                  onPressed: () {
                    onboardViewmodel.currentPage.value == 2
                        ? onboardViewmodel.isLastPAgeThen(context)
                        : _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                  },
                ),
              ),
              const Gap(20),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: theme.colorScheme.primary,
                  dotColor: theme.colorScheme.primary.withOpacity(.5),
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
