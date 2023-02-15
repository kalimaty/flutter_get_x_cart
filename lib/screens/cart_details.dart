import 'package:flutter/material.dart';
import 'package:flutter_get_x_cart/state/cart_state.dart';
import 'package:flutter_get_x_cart/utils/utils.dart';
import 'package:flutter_get_x_cart/widgets/cart_item_info.dart';
import 'package:flutter_get_x_cart/widgets/change_quantity_widget.dart';
import 'package:flutter_get_x_cart/widgets/product_image.dart';
import 'package:flutter_get_x_cart/widgets/total_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// ignore: must_be_immutable
class CartDetailsScreen extends StatelessWidget {
  final box = GetStorage();
  MyCartController controller = Get.find();

  CartDetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Detail'),
        actions: [
          InkWell(
            child: const Icon(Icons.clear),
            onTap: () {
              // List<CartModel>.empty(growable: true).obs;
              controller.cart.clear();
              deleteCart();
            },
          )
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cart.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    child: Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ProductImage(
                                productModel: controller.cart[index], // الصورة
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: CartItemInfo(
                                cartModel: controller.cart[index],
                              ),
                            ),
                            Center(
                              child: ChangeQuantityWidget(
                                  controller: controller, index: index),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actionPane: const SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Delete',
                        icon: Icons.delete,
                        color: Colors.red,
                        onTap: () {
                          controller.cart.removeAt(index);
                          saveDatabase(controller.cart);
                        },
                      )
                    ],
                  );
                },
              ),
            ),
            TotaleWidget(controller: controller),
          ],
        ),
      ),
    );
  }
}
