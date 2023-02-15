import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_get_x_cart/model/product_model.dart';

// ignore: must_be_immutable
class ProductImage extends StatelessWidget {
  ProductModel? productModel;
  ProductImage({Key? key, this.productModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: productModel!.imageUrl,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => const Icon(Icons.image),
      progressIndicatorBuilder: (context, url, download) => const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
