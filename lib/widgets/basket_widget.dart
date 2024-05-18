import 'package:flutter/material.dart';
import 'package:food_order/food.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:provider/provider.dart';

class BasketWidget extends StatefulWidget {
  final BoxConstraints parentConstraint;
  final FoodList foodList;
  const BasketWidget(
      {super.key, required this.parentConstraint, required this.foodList});

  @override
  _BasketWidgetState createState() => _BasketWidgetState();
}

class _BasketWidgetState extends State<BasketWidget> {
  double _calculateTotal(Map<int, int> basket) {
    double total = 0;
    basket.forEach(
      (key, value) {
        total += widget.foodList.findFoodById(key)!.price! * value;
      },
    );
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasketModel>(
      builder: (context, value, child) => SizedBox(
        width: widget.parentConstraint.maxWidth,
        height: widget.parentConstraint.maxHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: widget.parentConstraint.maxWidth,
              height: widget.parentConstraint.maxHeight * 0.1,
              child: Container(
                color: Colors.blue,
                child: const Text("Basket"),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.green,
                constraints: BoxConstraints(
                    maxHeight: widget.parentConstraint.maxHeight * 0.75),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: value.toList().length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                  itemBuilder: (context, index) {
                    final int key = value.toList()[index].key;
                    final Food food = widget.foodList.findFoodById(key)!;
                    final int quantity = value.toList()[index].value;

                    print("this is the total ${(quantity * food.price!)}");
                    return Container(
                      color: Colors.yellow,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('${index + 1}'),
                              Text(food!.name!),
                              Text(
                                  '€${(food.price! * quantity).toStringAsFixed(2)}')
                            ],
                          ),
                          Text(food!.description!),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => {value.remove(key)},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: const CircleBorder(),
                                ),
                                child: const Icon(Icons.remove, size: 15),
                              ),
                              Text('$quantity'),
                              ElevatedButton(
                                onPressed: () => {value.add(key)},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: const CircleBorder(),
                                ),
                                child: const Icon(Icons.add, size: 15),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: widget.parentConstraint.maxWidth,
              height: widget.parentConstraint.maxHeight * 0.15,
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
    );
  }
}
