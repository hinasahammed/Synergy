import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:synergy/res/components/bottom_bar.dart';
import 'package:synergy/res/utils/utils.dart';

class OnboardViewmodel extends GetxController {
  RxString selectedGender = ''.obs;
  RxString selectedGoal = ''.obs;
  RxInt currentPage = 0.obs;
  List pickedDates = [];
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  void isLastPAgeThen(BuildContext context) async {
    final box = GetStorage();
    try {
      isLoading.value = true;
      await firestore.collection("Users").doc(auth.currentUser!.uid).update({
        "gender": selectedGender.value,
        "goal": selectedGoal.value,
        "workoutDates": pickedDates,
      }).then((value) {
        box.write('alreadyStarted', true);
        box.save().then((value) => Get.offAll(const BottomBar()));
      });
      isLoading.value = false;

    } catch (e) {
      isLoading.value = false;
      if (context.mounted) {
        Utils.showSnackbarToast(context, e.toString(), Icons.error);
      }
    }
  }
}
