import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_get_x_cart/model/cart_model.dart';
import 'package:flutter_get_x_cart/model/product_model.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

// ignore: constant_identifier_names, non_constant_identifier_names
const MY_CART_KEY = 'cart';
Future<List<ProductModel>> readJosonDatabase() async {
  final rowData =
      await rootBundle.loadString("assets/data/my_product_json.json");
  final list = json.decode(rowData) as List<dynamic>;

  return list.map((e) => ProductModel.fromJson(e)).toList();
}

bool isExistesInCart(RxList<CartModel> cart, CartModel cartItem) {
  // return cart.contains(cartItem);
  //  return cart.length == 0

  return cart.isEmpty
      ? false
      : cart.any((e) => e.id == cartItem.id)
          ? true
          : false;
}

void saveDatabase(RxList<CartModel> cart) {
  var box = GetStorage();
  box.write(MY_CART_KEY, jsonEncode(cart));
}

void deleteCart() {
  var box = GetStorage();
  box.remove(
    MY_CART_KEY,
  );
}
