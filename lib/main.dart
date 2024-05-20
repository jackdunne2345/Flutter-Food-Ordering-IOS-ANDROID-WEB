import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:food_order/widgets/resturaunt_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BasketModel(), child: const ResturauntWidget());
  }
}
