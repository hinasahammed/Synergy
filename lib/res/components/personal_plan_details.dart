import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:synergy/res/components/custom_button.dart';

class PersonalPlanDetails extends StatelessWidget {
  const PersonalPlanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                  'https://i.pinimg.com/564x/eb/fc/f5/ebfcf5cecd0fd1849589a66dc9de9a89.jpg'),
              fit: BoxFit.cover,
              opacity: .6,
              alignment: Alignment.topCenter,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                theme.colorScheme.primary,
                theme.colorScheme.primary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('gain_plan').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.colorScheme.primary,
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong!'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No data found'),
                );
              } else {
                return Column(
                  children: snapshot.data!.docs.map((workout) {
                    return Column(
                      children: [
                        const Gap(10),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme.colorScheme.primaryContainer,
                          ),
                          child: Text(
                            'Your personal plan',
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Text(
                          workout['type'],
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const Gap(10),
                        SizedBox(
                          height: 130,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: workout['result'].length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Text(
                                  "🔹${workout['result'][index]}",
                                  style: theme.textTheme.titleMedium!.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const Gap(5),
                        SizedBox(
                          height: 700,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: workout['fullWorkouts'].length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: size.width,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        workout['fullWorkouts'][index]
                                            ['week${index + 1}']['imageurl'],
                                      ),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                      opacity: .2,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        workout['fullWorkouts'][index]
                                            ['week${index + 1}']['title'],
                                        style: theme.textTheme.titleLarge!
                                            .copyWith(
                                          color: theme
                                              .colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                      Text(
                                        workout['fullWorkouts'][index]
                                            ['week${index + 1}']['duration'],
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: theme
                                              .colorScheme.onPrimaryContainer
                                              .withOpacity(.9),
                                        ),
                                      ),
                                      Text(
                                        workout['fullWorkouts'][index]
                                            ['week${index + 1}']['desc'],
                                        style: theme.textTheme.labelLarge!
                                            .copyWith(
                                          color: theme
                                              .colorScheme.onPrimaryContainer
                                              .withOpacity(.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: size.width,
                          child: CustomButton(
                            btnTitle: 'Start plan',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }
            },
          )),
        ),
      ),
    );
  }
}
