// import 'dart:math';

import 'package:flutter_get_x_cart/model/cart_model.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class MyCartController extends GetxController {
  var cart = List<CartModel>.empty(growable: true).obs;

  sumCart() {
    //  return cart.length == 0
    return cart.isEmpty
        ? 0
        : cart
            .map((e) => double.parse(e.price) * e.quantity)
            .reduce((previouseValue, element) => previouseValue + element);
  }

  getQuantity() {
    //  return cart.length == 0
    return cart.isEmpty
        ? 0
        : cart
            .map((e) => e.quantity)
            .reduce((previouseValue, element) => previouseValue + element);
  }

  shippingFree() {
    return sumCart() * 0.1;
  }
}
