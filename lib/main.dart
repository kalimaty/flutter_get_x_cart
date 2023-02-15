import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_get_x_cart/model/cart_model.dart';
import 'package:flutter_get_x_cart/model/product_model.dart';
import 'package:flutter_get_x_cart/screens/cart_details.dart';
import 'package:flutter_get_x_cart/state/cart_state.dart';
import 'package:flutter_get_x_cart/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'widgets/product_card.dart';

void main() async {
  await GetStorage.init();
  runApp(const GetMaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = Get.put(MyCartController());

  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // String cartSave = '';
      // cartSave = box.read(MY_CART_KEY) ?? '';
      String cartSave = box.read(MY_CART_KEY) ?? '';
      if (cartSave.isNotEmpty) {
        final listCart = jsonDecode(cartSave) as List<dynamic>;
        final listCartParsed =
            listCart.map((e) => CartModel.fromJson(e)).toList();
        // if (listCartParsed.length > 0) controller.cart.value = listCartParsed;

        if (listCartParsed.isNotEmpty) {
          controller.cart.value = listCartParsed;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[800],
          body: FutureBuilder(
              future: readJosonDatabase(),
              builder: (context, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var listProduct = snapShot.data as List<ProductModel>;
                  return Padding(
                    padding: const EdgeInsets.all(
                      8,
                    ),
                    //  child: listProduct.length == 0
                    child: listProduct.isEmpty
                        ? const Center(
                            child: Text('No Item'),
                          )
                        : ListView.builder(
                            itemCount: listProduct.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                  productModel: listProduct[index]);
                            }),
                  );
                }
              }),
          floatingActionButton: Obx(
            () => Badge(
              // padding: EdgeInsets.all(8),
              position: const BadgePosition(top: 0, end: 1),
              animationDuration: const Duration(
                milliseconds: 200,
              ),
              animationType: BadgeAnimationType.scale,
              showBadge: true,
              badgeColor: Colors.pink,
              badgeContent: Text(
                /*controller.getQuantity() > 9
                    ? '9+'
                    :*/
                '${controller.getQuantity()}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),

              child: FloatingActionButton(
                backgroundColor: Colors.green.shade500,
                onPressed: () {
                  Get.to(CartDetailsScreen());
                },
                child: const Icon(
                  Icons.shopping_cart,
                ),
              ),
            ),
          )),
    );
  }
}
