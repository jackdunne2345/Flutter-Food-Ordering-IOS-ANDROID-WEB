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
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemCount: foodList.food!.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 5,
          ),
          itemBuilder: (context, index) {
            final food = foodList.food?[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: const Color.fromRGBO(238, 153, 5, 1),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 3, 3, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food!.name!,
                              style: const TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            Text(food.description!),
                            Text(
                              '€${food.price!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: const CircleBorder(),
                          ),
                          child: const Icon(Icons.add, size: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
