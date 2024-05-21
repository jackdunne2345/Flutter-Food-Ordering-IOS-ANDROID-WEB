import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/food.dart';

import '../models/basket_model.dart';

void showFoodDetailsDialog(
    BuildContext context, Food food, BasketModel basketModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      int _quantity = basketModel.basket[food.id!] ?? 0;
      TextEditingController _controller =
          TextEditingController(text: '$_quantity');

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            content: Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            food.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Flexible(
                              child: Text(
                                'Close',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(food.description!),
                  Text(
                    '€${food.price!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              if (basketModel.basket.containsKey(food.id!))
                IconButton(
                  onPressed: () {
                    setState(() {
                      basketModel.removeAll(food.id!);

                      _quantity = basketModel.basket[food.id!] ?? 0;
                      _controller.text = '$_quantity';
                    });
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                  onChanged: (value) {
                    int newValue = int.tryParse(value) ?? _quantity;
                    basketModel.addQuantity(food.id!, newValue);
                    if (value == '') basketModel.removeAll(food.id!);
                    setState(() {
                      _quantity = newValue;
                    });
                  },
                ),
              ),
              IconButton(
                color: Colors.orange,
                onPressed: () {
                  basketModel.add(food.id!);
                  setState(() {
                    _quantity = basketModel.basket[food.id!]!;
                    _controller.text = '$_quantity';
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          );
        },
      );
    },
  );
}
