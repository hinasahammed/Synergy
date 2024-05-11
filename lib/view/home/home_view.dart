import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:synergy/res/components/personal_plan_details.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Synergy'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null || !snapshot.hasData) {
              return const Text('No data found');
            }
            var goal = snapshot.data!.data()!['goal'];
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a fitness plan!',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const Gap(10),
                  StreamBuilder(
                    stream:
                        FirebaseFirestore.instance.collection(goal).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong!'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No data found'),
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            Get.to(const PersonalPlanDetails());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            width: size.width,
                            height: 300,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: theme.colorScheme.primary),
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://i.pinimg.com/564x/eb/fc/f5/ebfcf5cecd0fd1849589a66dc9de9a89.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: snapshot.data!.docs.map((workout) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: theme.colorScheme.primary,
                                      ),
                                      child: Text(
                                        workout['weeks'],
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                    const Gap(10),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            theme.colorScheme.primaryContainer,
                                      ),
                                      child: Text(
                                        'Your personal plan',
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: theme
                                              .colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                    const Gap(10),
                                    Text(
                                      workout['type'],
                                      style:
                                          theme.textTheme.titleLarge!.copyWith(
                                        color: theme
                                            .colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const Gap(10),
                  const Divider(),
                  Text(
                    'Gain muscle',
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    'Focus on gain muscle tone & strength with plans coposed mostly of low-repetition strength training',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(.8),
                    ),
                  ),
                  const Gap(10),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("home_gainplan")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong!'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No data found'),
                        );
                      } else {
                        return SizedBox(
                          height: 100,
                          child: Column(
                            children: snapshot.data!.docs.map((gain) {
                              return SizedBox(
                                height:
                                    100, // Specify a fixed height for the container
                                child: ListView.separated(
                                  itemCount: gain['workouts'].length,
                                  separatorBuilder: (context, index) =>
                                      const Gap(10),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      alignment: Alignment.centerLeft,
                                      width: size.width * 0.5,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              gain['imageurl'][index]),
                                          fit: BoxFit.cover,
                                          opacity: 0.6,
                                        ),
                                      ),
                                      child: Text(
                                        gain['workouts'][index],
                                        style: theme.textTheme.titleLarge!
                                            .copyWith(
                                          color: theme.colorScheme.onBackground,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }
                    },
                  ),
                  const Gap(10),
                  const Divider(),
                  Text(
                    'Lose weight',
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    "You need to get your heart rate up to burn calories, and that what's this plan are for",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(.8),
                    ),
                  ),
                  const Gap(10),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("home_losePlan")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: theme.colorScheme.primary,
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong!'));
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No data found'),
                        );
                      } else {
                        return SizedBox(
                          height: 100,
                          child: Column(
                            children: snapshot.data!.docs.map((lose) {
                              return SizedBox(
                                height:
                                    100, // Specify a fixed height for the container
                                child: ListView.separated(
                                  itemCount: lose['workouts'].length,
                                  separatorBuilder: (context, index) =>
                                      const Gap(10),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      alignment: Alignment.centerLeft,
                                      width: size.width * 0.5,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              lose['imageurl'][index]),
                                          fit: BoxFit.cover,
                                          opacity: 0.6,
                                        ),
                                      ),
                                      child: Text(
                                        lose['workouts'][index],
                                        style: theme.textTheme.titleLarge!
                                            .copyWith(
                                          color: theme.colorScheme.onBackground,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }
}
