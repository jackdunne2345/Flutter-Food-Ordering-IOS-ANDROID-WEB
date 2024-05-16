import 'package:flutter/material.dart';
import 'package:food_order/food.dart';

class MenuWidget extends StatelessWidget {
  final FoodList foodList;

  final BoxConstraints parentConstraint;

  const MenuWidget(
      {super.key, required this.foodList, required this.parentConstraint});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: parentConstraint.maxWidth,
      child: Center(
        child: ListView.separated(
          itemCount: foodList.food!.length,
          separatorBuilder: (context, index) => SizedBox(
              height: parentConstraint.maxHeight /
                  (parentConstraint.maxHeight - 1)),
          itemBuilder: (context, index) {
            final food = foodList.food?[index];
            return Container(
              color: const Color.fromRGBO(238, 153, 5, 1),
              child: ListTile(
                title: Text(food!.name!),
                subtitle: Text(food.description!),
                trailing: LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth / 3,
                      child: Container(
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () => {}, child: const Text('+')),
                            SizedBox(width: constraints.maxWidth * 0.004),
                            ElevatedButton(
                                onPressed: () => {}, child: const Text('-')),
                          ],
                        ),
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
