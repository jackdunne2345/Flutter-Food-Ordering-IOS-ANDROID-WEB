import 'package:flutter/material.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class CheckOutWidget extends StatefulWidget {
  @override
  _CheckOutWidgetState createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  void _showDialog(String firstName, String lastName) {
    String generateRandomString(int length) {
      const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
      final random = Random();
      return String.fromCharCodes(Iterable.generate(
        length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ));
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Flexible(
                  child:
                      Text('Your food is on the way $firstName $lastName!'))),
          content: Flexible(
              child: Text('Your order number is ${generateRandomString(10)}.')),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BasketModel>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Check Out'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                value.setCheckOut();
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                    validator: (textValue) {
                      if (textValue == null || textValue.isEmpty) {
                        return 'Please enter your first name';
                      } else if (value.basket.isEmpty) {
                        return 'The basket is empty';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _surnameController,
                    decoration: const InputDecoration(labelText: 'Surname'),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        if ((_formKey.currentState?.validate() ?? false) &&
                            value.basket.isNotEmpty) {
                          _showDialog(_firstNameController.text,
                              _surnameController.text);
                          value.setCheckOut();
                          value.empty();
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
