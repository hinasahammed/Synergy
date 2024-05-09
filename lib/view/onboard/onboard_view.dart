import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:synergy/res/components/onboard_first.dart';
import 'package:synergy/res/components/onboard_second.dart';

class OnboardView extends StatelessWidget {
  OnboardView({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                children: [
                  const OnboardFirst(),
                  const OnboardSecond(),
                  Container(
                    color: Colors.green,
                  ),
                  Container(
                    color: Colors.deepOrange,
                  ),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 4,
              effect: ExpandingDotsEffect(
                activeDotColor: theme.colorScheme.primary,
                dotColor: theme.colorScheme.primary.withOpacity(.5),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
