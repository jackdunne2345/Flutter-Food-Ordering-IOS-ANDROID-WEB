import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_order/food.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:provider/provider.dart';

class BasketWidget extends StatelessWidget {
  final FoodList foodList;
  const BasketWidget({super.key, required this.foodList});

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
      builder: (context, value, child) =>
          LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: 50,
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: const Center(
                    child: Text(
                  "Basket",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight * 0.75, minHeight: 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: value.toList().length,
                    separatorBuilder: (context, index) => const Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    itemBuilder: (context, index) {
                      final int key = value.toList()[index].key;
                      final Food food = foodList.findFoodById(key)!;
                      final int quantity = value.basket[key]!;

                      return SizedBox(
                        height: 100,
                        child: LayoutBuilder(builder: (context, constraint) {
                          return Row(
                            children: [
                              SizedBox(
                                width: constraint.maxWidth / 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${index + 1}. ${food.name!}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 20),
                                            ),
                                            IconButton(
                                              onPressed: () =>
                                                  {value.removeAll(food.id!)},
                                              icon: const Icon(
                                                  Icons.delete_outline),
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
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
                                      bottom: 5,
                                      right: 5,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    {value.remove(key)},
                                                style: ElevatedButton.styleFrom(
                                                    shape: const CircleBorder(),
                                                    padding: EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.orange),
                                                child: const Icon(
                                                  Icons.remove,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              height: 20,
                                              child: Center(
                                                child: Text(
                                                  '$quantity',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: ElevatedButton(
                                                onPressed: () =>
                                                    {value.add(key)},
                                                style: ElevatedButton.styleFrom(
                                                    shape: const CircleBorder(),
                                                    padding: EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.orange),
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      );
                    },
                  ),
                ),
              ),
            ),
            if (value.basket.isNotEmpty)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  width: constraints.maxWidth,
                  height: 150,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 2, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Subtotal"),
                                    Text("Delivery fee"),
                                    Text("Service charge"),
                                    Text("Total"),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          "€${_calculateTotal(value.basket).toStringAsFixed(2)}"),
                                      const Text("€2.50"),
                                      const Text("€0.50"),
                                      Text(
                                          "€${(_calculateTotal(value.basket) + 3).toStringAsFixed(2)}")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (!value.checkOut)
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all<Color>(
                                            Colors.orange)),
                                onPressed: () => {
                                      value.setCheckOut(),
                                    },
                                child: Text(
                                  "Checkout (€${(_calculateTotal(value.basket) + 3).toStringAsFixed(2)})",
                                  style: const TextStyle(color: Colors.white),
                                )),
                          ),
                        )
                    ],
                  ),
                ),
              )
            else
              Container(
                  width: constraints.maxWidth,
                  height: 150,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Center(
                      child: Column(
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.orange,
                            size: 100,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                        child: Text(
                          "Your basket is empty!",
                          style: TextStyle(fontSize: 20, color: Colors.orange),
                        ),
                      )
                    ],
                  )))
          ],
        );
      }),
    );
  }
}
