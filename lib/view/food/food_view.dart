import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FoodView extends StatelessWidget {
  FoodView({super.key});

  final List food = [
    {
      "name": "vegan chocolate balls",
      "imageurl":
          "https://i.pinimg.com/564x/da/56/97/da5697ce930162a394e931fc2ca8d8a8.jpg",
      "time": "10",
      "energy": "534",
    },
    {
      "name": "soy vegan stuffed pepper",
      "imageurl":
          "https://i.pinimg.com/564x/52/c2/5e/52c25effe8784fa3fa0b7ff651e0d3b2.jpg",
      "time": "30",
      "energy": "513",
    },
    {
      "name": "curried chickpeas with brown rice",
      "imageurl":
          "https://i.pinimg.com/564x/94/3a/8c/943a8c80696cf039ea79de5d1b74d7ba.jpg",
      "time": "25",
      "energy": "767",
    },
    {
      "name": "sorrano ham pizza",
      "imageurl":
          "https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/speedy-serrano-ham-mozzarella-pizza-e28a4570.jpg",
      "time": "80",
      "energy": "1090",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(food[index]['imageurl']),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          opacity: .2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            food[index]['name'],
                            style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "🕓${food[index]['time']}",
                                style: theme.textTheme.labelLarge!.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                              Text(
                                "🔥${food[index]['energy']}",
                                style: theme.textTheme.labelLarge!.copyWith(
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              'Top categories',
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
            const Gap(10),
            SizedBox(
              height: 330,
              child: GridView.builder(
                itemCount: 9,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 100,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.fastfood_rounded),
                          Text(
                            'data',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
