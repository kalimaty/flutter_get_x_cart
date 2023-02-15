import 'package:flutter/material.dart';
import 'package:flutter_get_x_cart/state/cart_state.dart';
import 'package:intl/intl.dart';

import 'totale_iteme_widget.dart';

class TotaleWidget extends StatelessWidget {
  final MyCartController controller;
  TotaleWidget({Key? key, required this.controller}) : super(key: key);
  final formatCurrency = NumberFormat.simpleCurrency();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TotaleItemWidget(
              txt: 'Totale',
              value: formatCurrency.format(controller.sumCart()),
              controller: controller,
              isSubTotale: false,
            ),
            const Divider(
              thickness: 1,
            ),
            TotaleItemWidget(
              txt: 'DiliveryCharg',
              value: formatCurrency.format(controller.shippingFree()),
              controller: controller,
              isSubTotale: false,
            ),
            const Divider(
              thickness: 1,
            ),
            TotaleItemWidget(
              txt: 'Sub Total',
              value: formatCurrency
                  .format(controller.shippingFree() + controller.sumCart()),
              controller: controller,
              isSubTotale: true,
            )
          ],
        ),
      ),
    );
  }
}
