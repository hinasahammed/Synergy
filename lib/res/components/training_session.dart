import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synergy/res/components/training_session_details.dart';

class TrainingSession extends StatelessWidget {
  const TrainingSession({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection("training_session").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              'No data found!',
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
          );
        } else {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data!.docs.map((training) {
              return InkWell(
                onTap: () {
                  Get.to(
                    () => TrainingSessionDetails(
                      title: training['title'],
                      image: training['imageurl'],
                      desc: training['desc'],
                      workouts: training['workouts'],
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  width: size.width / 1.2,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        training['imageurl'],
                      ),
                      opacity: .4,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width / 2.5,
                        child: Text(
                          training['title'],
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.colorScheme.onBackground,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Divider(
                        color: theme.colorScheme.onBackground,
                      ),
                      Text(
                        training['desc'],
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(.8),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
