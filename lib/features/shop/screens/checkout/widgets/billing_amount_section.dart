import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () {
        final subTotal = controller.totalCartPrice.value;
        return Column(
          children: [
            /// SubTotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SubTotal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '\$$subTotal',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),

            /// Shipping Fees
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping Fees',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '\$${TPricingCalculator.calculateShippingCost(subTotal, 'US')}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),

            /// Tax Fees
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tax Fees',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '\$${TPricingCalculator.calculateTax(subTotal, 'US')}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),

            /// Order Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Total',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '\$${TPricingCalculator.calculateTotalPrice(subTotal, 'US')}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
          ],
        );
      },
    );
  }
}
