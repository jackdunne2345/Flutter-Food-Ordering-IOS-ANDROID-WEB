import 'package:flutter/material.dart';
import 'package:food_order/models/basket_model.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Consumer<BasketModel>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Check Out'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
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
                    decoration: InputDecoration(labelText: 'First Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _surnameController,
                    decoration: InputDecoration(labelText: 'Surname'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => {},
                    child: Text('Submit'),
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
