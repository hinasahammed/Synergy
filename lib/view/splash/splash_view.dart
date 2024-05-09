import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:synergy/view/home/home_view.dart';
import 'package:synergy/view/login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  void nextSession() {
    Timer(const Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Get.offAll(() => LoginView());
      } else {
        Get.offAll(() => const HomeView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Synergy',
              style: theme.textTheme.headlineLarge!.copyWith(),
            ),
            const Gap(50),
            CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
