import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synergy/viewmodel/controller/onboard/onboard_viewmodel.dart';

class OnboardThird extends StatelessWidget {
  const OnboardThird({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onboardViewmodel = Get.put(OnboardViewmodel());
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      child: Column(
        children: [
          const Spacer(),
          Text(
            'Pick training days',
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
          Text(
            'Great, Based on your data,we recommend 5 workouts per weak.',
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.onBackground,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SelectWeekDays(
            fontSize: 12,
            daysBorderColor: theme.colorScheme.primary,
            daysFillColor: theme.colorScheme.primary,
            selectedDayTextColor: theme.colorScheme.onPrimary,
            days: [
              DayInWeek('Mon', dayKey: 'Mon'),
              DayInWeek('Tue', dayKey: 'Tue'),
              DayInWeek('Wed', dayKey: 'Wed'),
              DayInWeek('Thu', dayKey: 'Thu'),
              DayInWeek('Fri', dayKey: 'Fri'),
              DayInWeek('Sat', dayKey: 'Sat'),
              DayInWeek('Sun', dayKey: 'Sun'),
            ],
            unSelectedDayTextColor: theme.colorScheme.onBackground,
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            onSelect: (values) {
              onboardViewmodel.pickedDates.clear();
              onboardViewmodel.pickedDates.addAll(values);
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
