import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/food.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:food_order/widgets/basket_widget.dart';
import 'package:food_order/widgets/check_out_widget.dart';
import 'package:food_order/widgets/menu_widget.dart';
import 'package:provider/provider.dart';

class ResturauntWidget extends StatefulWidget {
  const ResturauntWidget({Key? key}) : super(key: key);

  @override
  _ResturauntWidgetState createState() => _ResturauntWidgetState();
}

class _ResturauntWidgetState extends State<ResturauntWidget>
    with TickerProviderStateMixin {
  late Future<dynamic> _foods;
  bool _showBasket = false;

  void _toggleBasket() {
    setState(() {
      _showBasket = !_showBasket;
      print(_showBasket);
    });
  }

  @override
  void initState() {
    super.initState();
    _foods = readJson('food');
  }

  Future<dynamic> readJson(String path) async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/$path.json');
      final dynamic jsonData = json.decode(jsonString);
      return FoodList.fromJson(jsonData);
    } catch (error) {
      return '$error';
    }
  }

  Widget build(BuildContext context) {
    return Consumer<BasketModel>(
        builder: (context, value, child) => FutureBuilder<dynamic>(
              future: _foods,
              builder: (context, snapshot) {
                final parentBoxConstraints = BoxConstraints.tightFor(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                );
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.data is String) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data is FoodList) {
                  final foodList = snapshot.data!;

                  return Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 640) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text("Food Store"),
                            ),
                            body: Row(
                              children: [
                                SizedBox(
                                    width: parentBoxConstraints.maxWidth * 0.65,
                                    child: value.checkOut
                                        ? CheckOutWidget()
                                        : MenuWidget(
                                            foodList: foodList,
                                          )),
                                SizedBox(
                                  width: parentBoxConstraints.maxWidth * 0.35,
                                  child: BasketWidget(foodList: foodList),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text("Food Store"),
                              actions: [
                                IconButton(
                                  icon: const Icon(Icons.shopping_basket),
                                  onPressed: _toggleBasket,
                                ),
                              ],
                            ),
                            body: Stack(
                              children: [
                                value.checkOut
                                    ? CheckOutWidget()
                                    : MenuWidget(
                                        foodList: foodList,
                                      ),
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 200),
                                  child: _showBasket
                                      ? Center(
                                          child: ScaleTransition(
                                              scale: CurvedAnimation(
                                                parent: AnimationController(
                                                  vsync: this,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                )..forward(),
                                                curve: Curves.easeOutBack,
                                              ),
                                              child: Container(
                                                color: const Color.fromARGB(
                                                    200, 164, 162, 162),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10), // Adjust the radius as needed
                                                        border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              128, 124, 124),
                                                          width: 10,
                                                        ),
                                                      ),
                                                      child: BasketWidget(
                                                        foodList: foodList,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          //
                                          )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  );
                } else {
                  return const Text('Oh no! Something went wrong');
                }
              },
            ));
  }
}
