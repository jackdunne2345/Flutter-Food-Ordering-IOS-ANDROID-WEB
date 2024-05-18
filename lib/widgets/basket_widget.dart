import 'package:flutter/material.dart';
import 'package:food_order/food.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:provider/provider.dart';

class BasketWidget extends StatelessWidget {
  final BoxConstraints parentConstraint;
  final FoodList foodList;
  const BasketWidget(
      {super.key, required this.parentConstraint, required this.foodList});

  double _calculateTotal(Map<int, int> basket) {
    double total = 0;
    basket.forEach(
      (key, value) {
        total += foodList.findFoodById(key)!.price! * value;
      },
    );
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasketModel>(
      builder: (context, value, child) => SizedBox(
        width: parentConstraint.maxWidth,
        height: parentConstraint.maxHeight,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: parentConstraint.maxWidth,
                height: parentConstraint.maxHeight * 0.1,
                child: Container(
                  color: Colors.blue,
                  child: const Center(
                      child: Text(
                    "Basket",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  color: Colors.green,
                  constraints: BoxConstraints(
                      maxHeight: parentConstraint.maxHeight * 0.6),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: value.toList().length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemBuilder: (context, index) {
                      final int key = value.toList()[index].key;
                      final Food food = foodList.findFoodById(key)!;
                      final int quantity = value.basket[key]!;

                      return Container(
                        color: Colors.yellow,
                        child: SizedBox(
                          height: 100,
                          child: LayoutBuilder(builder: (context, constraint) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: constraint.maxWidth / 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            '${index + 1}. ${food.name!}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.purple,
                                  child: SizedBox(
                                    height: constraint.maxHeight,
                                    width: constraint.maxWidth / 2,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Text(
                                              '€${(food.price! * quantity).toStringAsFixed(2)}'),
                                        ),
                                        Positioned(
                                          bottom: 2,
                                          right: 0,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Row(
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      {value.remove(key)},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: const CircleBorder(),
                                                  ),
                                                  child: const Icon(
                                                      Icons.remove,
                                                      size: 15),
                                                ),
                                                Text('$quantity'),
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      {value.add(key)},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: const CircleBorder(),
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                  child: const Icon(Icons.add,
                                                      size: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: parentConstraint.maxWidth,
                height: parentConstraint.maxHeight * 0.3,
                child: Container(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Row(children: [
                        Text("Subtotal"),
                        Text(
                            "€${_calculateTotal(value.basket).toStringAsFixed(2)}")
                      ]),
                      Row(children: [Text("Delivery fee"), Text("€2.50")]),
                      Row(children: [Text("Service charge"), Text("€0.50")]),
                      Row(children: [
                        Text("Total"),
                        Text(
                            "€${(_calculateTotal(value.basket) + 3).toStringAsFixed(2)}")
                      ]),
                      ElevatedButton(
                          onPressed: () => {},
                          child: Text(
                              "Checkout (€${(_calculateTotal(value.basket) + 3).toStringAsFixed(2)})"))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
