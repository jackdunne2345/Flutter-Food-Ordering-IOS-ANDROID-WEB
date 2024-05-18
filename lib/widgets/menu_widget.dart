import 'package:flutter/material.dart';
import 'package:food_order/food.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatefulWidget {
  final FoodList foodList;

  final BoxConstraints parentConstraint;

  const MenuWidget(
      {super.key, required this.foodList, required this.parentConstraint});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BasketModel>(
      builder: (context, value, child) => SizedBox(
        width: widget.parentConstraint.maxWidth,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
            itemCount: widget.foodList.food!.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
            itemBuilder: (context, index) {
              final food = widget.foodList.food?[index];
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
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(food.description!),
                              Text(
                                '€${food.price!.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: ElevatedButton(
                                onPressed: () => {value.add(food.id!)},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: const CircleBorder(),
                                ),
                                child: (value.basket.containsKey(food.id))
                                    ? Text('${value.basket[food.id!]}')
                                    : Icon(Icons.add, size: 15)),
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
      ),
    );
  }
}
