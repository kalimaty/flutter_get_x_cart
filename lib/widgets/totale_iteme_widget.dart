import 'package:flutter/material.dart';
import 'package:flutter_get_x_cart/state/cart_state.dart';

// ignore: must_be_immutable
class TotaleItemWidget extends StatelessWidget {
  String txt = '', value = '';
  bool isSubTotale = false;
  final MyCartController controller;
  TotaleItemWidget({
    Key? key,
    required this.txt,
    required this.value,
    required this.isSubTotale,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          txt,
          style: TextStyle(
              fontSize: isSubTotale ? 20 : 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isSubTotale ? 20 : 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
