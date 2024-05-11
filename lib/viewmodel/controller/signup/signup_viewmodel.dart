import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:synergy/res/utils/utils.dart';
import 'package:synergy/view/login/login_view.dart';

class SignupViewmodel extends GetxController {
  final userNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;

  Future signup(BuildContext context) async {
    isLoading.value = true;
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: emailController.value.text.trim(),
        password: confirmPasswordController.value.text,
      )
          .then((value) {
        storeData(context).then((value) {
          Get.to(LoginView());
          Utils.showSnackbarToast(
            context,
            'Account created successfully, Now try to login!',
            Icons.check_circle,
          );
        });
      }).whenComplete(() => isLoading.value = false);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        switch (e.code) {
          case "invalid-email":
            //Thrown if the email address is not valid.
            Utils.showSnackbarToast(
                context, 'email address is not valid', Icons.error);
          case "user-disabled":
            //Thrown if the user corresponding to the given email has been disabled.
            Utils.showSnackbarToast(context, 'user-disabled', Icons.error);
          case "user-not-found":
            //Thrown if there is no user corresponding to the given email.
            Utils.showSnackbarToast(context, 'user not found', Icons.error);
          case "wrong-password":
            Utils.showSnackbarToast(context, 'Wrong password', Icons.error);
          //Thrown if the password is invalid for the given email, or the account corresponding to the email does not have a password set.
          default:
            Utils.showSnackbarToast(
                context, 'An undefined Error happened.', Icons.error);
        }
      }
    }
  }

  Future storeData(BuildContext context) async {
    try {
      await firestore.collection("Users").doc(auth.currentUser!.uid).set({
        "username": userNameController.value.text,
        "email": emailController.value.text,
      });
    } catch (e) {
      if (context.mounted) {
        Utils.showSnackbarToast(context, e.toString(), Icons.error);
      }
    }
  }
}
