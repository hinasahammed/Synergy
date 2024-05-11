import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:synergy/viewmodel/controller/onboard/onboard_viewmodel.dart';

class OnboardFirst extends StatelessWidget {
  const OnboardFirst({super.key});

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
              "What's your gender?",
              style: theme.textTheme.titleLarge!
                  .copyWith(color: theme.colorScheme.onBackground),
            ),
            const Spacer(),
            Card(
              child: InkWell(
                onTap: () {
                  onboardViewmodel.selectedGender.value == 'Male'
                      ? onboardViewmodel.selectedGender.value = ''
                      : onboardViewmodel.selectedGender.value = 'Male';
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: size.width,
                  height: size.height * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: onboardViewmodel.selectedGender.value == 'Male'
                        ? Border.all(color: theme.colorScheme.primary, width: 3)
                        : null,
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/85/f7/00/85f700611bc46d01d3704055234633ba.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topRight,
                      opacity: .4,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Male",
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
                  onboardViewmodel.selectedGender.value == 'Female'
                      ? onboardViewmodel.selectedGender.value = ''
                      : onboardViewmodel.selectedGender.value = 'Female';
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: size.width,
                  height: size.height * .2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: onboardViewmodel.selectedGender.value == 'Female'
                        ? Border.all(color: theme.colorScheme.primary, width: 3)
                        : null,
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://i.pinimg.com/564x/a7/56/a5/a756a5f750211119e491394adaac7082.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topRight,
                      opacity: .4,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Female",
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
