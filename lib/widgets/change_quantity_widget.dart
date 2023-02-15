import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';

import 'package:flutter_get_x_cart/state/cart_state.dart';
import 'package:flutter_get_x_cart/utils/utils.dart';

class ChangeQuantityWidget extends StatelessWidget {
  final int index;
  final MyCartController controller;
  // ignore: use_key_in_widget_constructors
  const ChangeQuantityWidget({required this.controller, required this.index});
  // ignore: use_key_in_widget_constructors

  @override
  Widget build(BuildContext context) {
    return ElegantNumberButton(
        initialValue: controller.cart[index].quantity,
        minValue: 0,
        maxValue: 99,
        color: Colors.white38,
        onChanged: (value) async {
          controller.cart[index].quantity = value.toInt();
          saveDatabase(controller.cart);
          controller.cart.refresh();
        },
        decimalPlaces: 1);
  }
}
