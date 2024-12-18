import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        itemCount: controller.cartItem.length,
        itemBuilder: (_, index) => Obx(
          () {
            final item = controller.cartItem[index];
            return Column(
              children: [
                TCartItem(
                  cartItem: item,
                ),
                if (showAddRemoveButton)
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                if (showAddRemoveButton)
                  Row(
                    children: [
                      const SizedBox(
                        width: 70,
                      ),

                      /// Add Remove Button with total price
                      TProductQuantityWithAddRemoveButton(
                        quantity: item.quantity,
                        add: () => controller.addOneToCart(item),
                        remove: () => controller.removeOneFromCart(item),
                      ),
                      const Spacer(),
                      TProductPriceText(
                          price:
                              (item.price * item.quantity).toStringAsFixed(1)),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
