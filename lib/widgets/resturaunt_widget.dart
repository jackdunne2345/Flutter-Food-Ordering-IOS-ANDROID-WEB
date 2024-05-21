import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/food.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:food_order/widgets/basket_widget.dart';
import 'package:food_order/widgets/check_out_widget.dart';
import 'package:food_order/widgets/menu_widget.dart';
import 'package:provider/provider.dart';

class ResturauntWidget extends StatefulWidget {
  const ResturauntWidget({super.key});

  @override
  _ResturauntWidgetState createState() => _ResturauntWidgetState();
}

class _ResturauntWidgetState extends State<ResturauntWidget>
    with TickerProviderStateMixin {
  late Future<dynamic> _foods;
  late bool _showBasket;
  @override
  void initState() {
    super.initState();
    _foods = readJson('food');
    _showBasket = false;
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _foods,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.data is String) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data is FoodList) {
          final foodList = snapshot.data!;

          return LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = false;

              if (kIsWeb) {
                isMobile = constraints.maxWidth < 640;
              } else {
                isMobile = constraints.maxWidth < 640 ||
                    Platform.isAndroid ||
                    Platform.isIOS;
              }

              return Scaffold(
                  appBar: AppBar(
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Image.asset(
                            'assets/img/logo.png',
                            height: 40.0,
                          ),
                        ),
                        const Text(
                          "Grubs Up",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    actions: [
                      if (isMobile)
                        IconButton(
                          icon: const Icon(Icons.shopping_basket),
                          onPressed: () => {
                            setState(() {
                              _showBasket = !_showBasket;
                            }),
                          },
                          color: Colors.orange,
                        ),
                    ],
                  ),
                  body: LayoutBuilder(builder: (context, constrants) {
                    if (isMobile) {
                      return Stack(
                        children: [
                          Consumer<BasketModel>(
                            builder: (context, value, child) => Container(
                              child: value.checkOut
                                  ? CheckOutWidget()
                                  : MenuWidget(
                                      foodList: foodList,
                                    ),
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            switchInCurve: Curves.easeOutBack,
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: _showBasket
                                ? Container(
                                    color: const Color.fromARGB(
                                        200, 164, 162, 162),
                                    child: Center(
                                      key: UniqueKey(),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxHeight: constraints.maxHeight,
                                              minHeight:
                                                  constraints.maxHeight * 0.3,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 128, 124, 124),
                                                width: 2,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: PopScope(
                                              canPop: false,
                                              onPopInvoked: (pop) => {
                                                setState(() {
                                                  _showBasket = !_showBasket;
                                                }),
                                              },
                                              child: BasketWidget(
                                                foodList: foodList,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      );
                    } else {
                      setState(() {
                        _showBasket = false;
                      });
                      return Row(
                        children: [
                          Consumer<BasketModel>(
                            builder: (context, value, child) => SizedBox(
                                width: constrants.maxWidth * 0.65,
                                child: value.checkOut
                                    ? CheckOutWidget()
                                    : MenuWidget(
                                        foodList: foodList,
                                      )),
                          ),
                          Container(
                              width: constrants.maxWidth * 0.35,
                              alignment: Alignment.topCenter,
                              child: BasketWidget(foodList: foodList)),
                        ],
                      );
                    }
                  }));
            },
          );
        } else {
          return const Text('Oh no! Something went wrong');
        }
      },
    );
  }
}
