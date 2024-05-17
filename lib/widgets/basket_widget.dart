import 'package:flutter/material.dart';

class BasketWidget extends StatefulWidget {
  final BoxConstraints parentConstraint;
  const BasketWidget({super.key, required this.parentConstraint});

  @override
  _BasketWidgetState createState() => _BasketWidgetState();
}

class _BasketWidgetState extends State<BasketWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SizedBox(
        width: widget.parentConstraint.maxWidth,
        height: widget.parentConstraint.maxHeight,
      ),
    );
  }
}
