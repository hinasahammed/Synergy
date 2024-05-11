import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:synergy/res/components/bottom_bar.dart';
import 'package:synergy/view/login/login_view.dart';
import 'package:synergy/view/onboard/onboard_view.dart';
import 'package:synergy/view/splash/splash_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff725ac1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashView();
          }
          if (snapshot.data == null) {
            return LoginView();
          } else {
            final box = GetStorage();
            var alreadyStarted = box.read('alreadyStarted');
            if (alreadyStarted == null || !alreadyStarted) {
              return OnboardView();
            } else {
              return const BottomBar();
            }
          }
        },
      ),
    );
  }
}
