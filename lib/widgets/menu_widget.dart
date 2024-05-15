import 'package:flutter/material.dart';
import 'package:food_order/food.dart';

class MenuWidget extends StatelessWidget {
  final FoodList foodList;

  double width;
  double height;

  MenuWidget(
      {Key? key,
      required this.foodList,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / 2,
      child: Center(
        child: ListView.separated(
          itemCount: foodList.food!.length,
          separatorBuilder: (context, index) => SizedBox(height: 2),
          itemBuilder: (context, index) {
            final food = foodList.food?[index];
            return Container(
              color: const Color.fromRGBO(238, 153, 5, 1),
              child: ListTile(
                title: Text(food!.name!),
                subtitle: Row(
                  children: [
                    Column(
                      children: [
                        Text(food.description!),
                      ],
                    ),
                    Column(children: [
                      Row(
                        children: [
                          ElevatedButton(
                            child: Text("+"),
                            onPressed: () => {print(food.name)},
                          ),
                          Text('1'),
                          ElevatedButton(
                            child: Text("-"),
                            onPressed: () => {print(food.name)},
                          ),
                        ],
                      ),
                      Center(
                        child: ElevatedButton(
                          child: Text("Add to Cart"),
                          onPressed: () => {print(food.name)},
                        ),
                      )
                    ])
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
