import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:synergy/res/utils/utils.dart';
import 'package:synergy/view/login/login_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Text('No data found');
                }
                var name = snapshot.data!.data()!['username'];
                return Text(
                  'Hi,\n${name ?? ' '}',
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                );
              },
            ),
            const Gap(10),
            Card(
              child: ListTile(
                onTap: () {
                  Utils.showDialog(
                    context,
                    () async {
                      final box = GetStorage();
                      box.remove('alreadyStarted');
                      await FirebaseAuth.instance
                          .signOut()
                          .then((value) => Get.offAll(LoginView()));
                    },
                    DialogType.question,
                    'Logout',
                    'Are you want to logout?',
                  );
                },
                title: const Text('Logout'),
                trailing: const Icon(Icons.arrow_right),
              ),
            )
          ],
        ),
      ),
    );
  }
}
