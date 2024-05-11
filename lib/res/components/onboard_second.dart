import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:synergy/viewmodel/controller/onboard/onboard_viewmodel.dart';

class OnboardSecond extends StatelessWidget {
  const OnboardSecond({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final onboardViewmodel = Get.put(OnboardViewmodel());
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: Column(
          children: [
            const Spacer(),
            Text(
              "What's your goal?",
              style: theme.textTheme.titleLarge!
                  .copyWith(color: theme.colorScheme.onBackground),
            ),
            const Spacer(),
            Card(
              child: InkWell(
                onTap: () {
                  onboardViewmodel.selectedGoal.value == 'gain_plan'
                      ? onboardViewmodel.selectedGoal.value = ''
                      : onboardViewmodel.selectedGoal.value = 'gain_plan';
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: size.width,
                  height: size.height * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: onboardViewmodel.selectedGoal.value == 'gain_plan'
                        ? Border.all(color: theme.colorScheme.primary, width: 3)
                        : null,
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://i.pinimg.com/736x/2d/ff/b0/2dffb015ebd1822736a2617c97b07598.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topRight,
                      opacity: .4,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Gain muscle",
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: theme.colorScheme.onBackground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(10),
            Card(
              child: InkWell(
                onTap: () {
                  onboardViewmodel.selectedGoal.value == 'lose_plan'
                      ? onboardViewmodel.selectedGoal.value = ''
                      : onboardViewmodel.selectedGoal.value = 'lose_plan';
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: size.width,
                  height: size.height * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: onboardViewmodel.selectedGoal.value == 'lose_plan'
                        ? Border.all(color: theme.colorScheme.primary, width: 3)
                        : null,
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://i.pinimg.com/564x/84/e3/87/84e387bfbf130a622dbbac07c093832f.jpg',
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.topRight,
                      opacity: .4,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Lose weight",
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: theme.colorScheme.onBackground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
