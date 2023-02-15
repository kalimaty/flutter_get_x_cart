import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_get_x_cart/model/cart_model.dart';
import 'package:flutter_get_x_cart/model/product_model.dart';
import 'package:flutter_get_x_cart/state/cart_state.dart';
import 'package:flutter_get_x_cart/utils/utils.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class ProductInfo extends StatelessWidget {
  ProductModel? productModel;
  ProductInfo({Key? key, this.productModel}) : super(key: key);
  final controller = Get.put(MyCartController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // padding: const EdgeInsets.all(16),
        // color: Colors.orange.shade100,
        decoration: BoxDecoration(
          color: Colors.yellow.shade200,
          border: Border.all(
            color: Colors.pinkAccent,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              productModel!.name,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                // backgroundColor: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: double.parse(productModel!.oldPrice) == 0
                            ? ''
                            : '\$${productModel!.oldPrice}',
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const TextSpan(),
                      TextSpan(
                        text: ' \$${productModel!.price}',
                        style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),

                //////
                InkWell(
                  child: const Icon(
                    Icons.add_shopping_cart_rounded,
                    color: Colors.black,
                    size: 25,
                  ),
                  onTap: () async {
                    var cartItem = CartModel(
                      id: productModel!.id,
                      name: productModel!.name,
                      oldPrice: productModel!.oldPrice,
                      price: productModel!.price,
                      imageUrl: productModel!.imageUrl,
                      category: productModel!.category,
                      quantity: 1,
                    );
                    if (isExistesInCart(controller.cart, cartItem)) {
                      // var indexUpdate = controller.cart
                      //     .indexWhere((e) => e.id == productModel!.id);
                      var productUpdate = controller.cart.firstWhere(
                          (element) => element.id == productModel!.id);

                      productUpdate.quantity += 1;
                      saveDatabase(controller.cart);
                      // controller.cart.insert(indexUpdate, productUpdate);
                      controller.cart.refresh();
                    } else {
                      controller.cart.add(cartItem);
                      var jsonDbEncoded = jsonEncode(controller.cart);
                      await box.write(MY_CART_KEY, jsonDbEncoded);
                      // saveDatabase(controller.cart);
                      // saveDatabase(controller.cart);
                      controller.cart.refresh();
                    }
                    // saveDatabase(controller.cart);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
