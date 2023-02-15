import 'package:flutter/material.dart';
import 'package:flutter_get_x_cart/model/product_model.dart';
import 'package:flutter_get_x_cart/widgets/product_image.dart';
import 'package:flutter_get_x_cart/widgets/product_info.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  ProductModel? productModel;
  ProductCard({Key? key, this.productModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProductImage(
            productModel: productModel,
          ),
          const SizedBox(
            height: 5,
          ),
          ProductInfo(
            productModel: productModel,
          ),
        ],
      ),
    );
  }
}
