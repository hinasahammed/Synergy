import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:synergy/res/components/bottom_bar.dart';
import 'package:synergy/res/utils/utils.dart';
import 'package:synergy/view/onboard/onboard_view.dart';

class LoginViewmodel extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  final box = GetStorage();

  Future login(BuildContext context) async {
    try {
      isLoading.value = true;
      await auth
          .signInWithEmailAndPassword(
        email: emailController.value.text.trim(),
        password: passwordController.value.text,
      )
          .then((value) {
        var alreadyStarted = box.read('alreadyStarted');
        if (alreadyStarted == null || alreadyStarted == false) {
          Get.offAll(
            OnboardView(),
          );
        } else {
          Get.offAll(
            const BottomBar(),
          );
        }

        Utils.showSnackbarToast(
            context, 'Login Successfull', Icons.check_circle);
      });

      isLoading.value = false;
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        if (error.code == 'invalid-email') {
          return Utils.showSnackbarToast(
              context, 'email address is not valid', Icons.error);
        }
        if (error.code == 'user-disabled') {
          return Utils.showSnackbarToast(
              context, 'email has been disabled', Icons.error);
        }
        if (error.code == 'user-not-found') {
          return Utils.showSnackbarToast(context,
              'there is no user corresponding to the given email', Icons.error);
        }
        if (error.code == 'wrong-password') {
          return Utils.showSnackbarToast(
              context, 'password is invalid', Icons.error);
        }
        return Utils.showSnackbarToast(
            context, error.message.toString(), Icons.error);
      }
    }
  }
}
