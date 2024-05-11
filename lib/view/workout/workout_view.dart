import 'package:flutter/material.dart';

class WorkoutView extends StatelessWidget {
  WorkoutView({super.key});

  final List images = [
    'https://i.pinimg.com/564x/59/f4/80/59f480720ff0fe2bce229e1ff85a7b68.jpg',
    'https://i.pinimg.com/564x/04/4c/17/044c176a0dc2dacdeab9b6e1ff8a66fc.jpg',
    'https://i.pinimg.com/564x/86/a1/e4/86a1e4c58511e037123fd4143f2bdb8d.jpg',
    'https://i.pinimg.com/564x/54/b5/16/54b516b4203ea7aecd99cb7fae1bcea7.jpg',
  ];
  final List title = [
    'Strength',
    'HIIT Cardio',
    'Yoga Stretching',
    'Warmup recovery',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: size.width,
              height: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(images[index]),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  opacity: .2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title[index],
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
