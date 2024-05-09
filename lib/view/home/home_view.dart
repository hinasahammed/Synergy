import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:synergy/res/components/training_session.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synergy'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Training program',
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const Gap(10),
            const SizedBox(
              height: 170,
              child: TrainingSession(),
            ),
            const Gap(10),
            Text(
              'Weekend program',
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const Gap(10),
            const SizedBox(
              height: 170,
              child: TrainingSession(),
            ),
          ],
        ),
      ),
    );
  }
}
