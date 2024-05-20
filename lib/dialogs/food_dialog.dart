import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/food.dart';
import 'package:food_order/models/basket_model.dart';

void showFoodDetailsDialog(
    BuildContext context, Food food, BasketModel basketModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  food.name!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
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
        actions: [
          IconButton(
              onPressed: () => {},
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              )),
          SizedBox(
            width: 20,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                labelText: '${basketModel.basket[food.id] ?? 0}',
              ),
            ),
          ),
        ],
      );
    },
  );
}
