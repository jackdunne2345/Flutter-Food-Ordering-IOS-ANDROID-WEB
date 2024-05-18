import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/food.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:food_order/widgets/basket_widget.dart';
import 'package:food_order/widgets/menu_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Store',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 159, 4)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Food Store'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<dynamic> _foods;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<dynamic>(
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

            return ChangeNotifierProvider(
              create: (context) => BasketModel(),
              child: Row(
                children: [
                  SizedBox(
                    width: parentBoxConstraints.maxWidth * 0.65,
                    child: LayoutBuilder(
                      builder: (context, constraints) => MenuWidget(
                        foodList: foodList,
                        parentConstraint: constraints,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: parentBoxConstraints.maxWidth * 0.35,
                    child: LayoutBuilder(
                      builder: (context, constraints) => BasketWidget(
                          foodList: foodList, parentConstraint: constraints),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Oh no! Something went wrong');
          }
        },
      ),
    );
  }
}
