import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:synergy/view/home/home_view.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List pages = [
    const HomeView(),
    const HomeView(),
    const HomeView(),
    const HomeView(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        child: GNav(
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          rippleColor: theme.colorScheme.primary.withOpacity(.5),
          hoverColor: theme.colorScheme.primary.withOpacity(.5),
          color: theme.colorScheme.primary,
          activeColor: theme.colorScheme.onPrimary,
          tabBackgroundColor: theme.colorScheme.primary,
          backgroundColor: theme.colorScheme.background,
          gap: 7,
          iconSize: 24,
          padding: const EdgeInsets.all(12),
          tabs: const [
            GButton(
              icon: Icons.calendar_month,
              text: 'My plan',
            ),
            GButton(
              icon: Icons.fitness_center,
              text: 'Workouts',
            ),
            GButton(
              icon: Icons.restaurant,
              text: 'Food',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
