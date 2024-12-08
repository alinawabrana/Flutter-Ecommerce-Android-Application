import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_app/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/controllers/product/variation_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          /// -- Selected Attributes Pricing & Description
          // Display variation price and stock when some variation is selected.
          if (controller.selectedVariation.value.id.isNotEmpty)
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: darkMode ? TColors.darkerGrey : TColors.grey,
              child: Column(
                children: [
                  /// Title, Price and Stock Status
                  Row(
                    children: [
                      const TSectionHeading(
                        text: 'Variation',
                        showActionButton: false,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const TProductTitleText(
                                title: 'Price',
                                smallSize: true,
                              ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),

                              /// Actual Price

                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  '\$${controller.selectedVariation.value.price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),

                              /// Sale Price
                              TProductPriceText(
                                price: '\$${controller.getVariationPrice()}',
                              ),
                            ],
                          ),

                          /// Stock
                          Row(
                            children: [
                              TProductTitleText(
                                title: controller.variationStockStatus.value,
                                smallSize: true,
                              ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              Text(
                                'In Stock',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// Variation Description
                  const TProductTitleText(
                    title:
                        'This is the Description of the Product and it can go upto max 4 lines.',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),

          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          /// -- Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Colors
                      TSectionHeading(
                        text: attribute.name ?? '',
                        showActionButton: false,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map(
                            (attributeValue) {
                              final isSelected = controller
                                      .selectedAttributes[attribute.name] ==
                                  attributeValue;
                              final available = controller
                                  .getAttributesAvailabilityInVariation(
                                      product.productVariations!,
                                      attribute.name!)
                                  .contains(attributeValue);
                              return TChoiceChip(
                                text: attributeValue,
                                selected: isSelected,
                                onSelected: available
                                    ? (selected) {
                                        if (available && selected) {
                                          controller.onAttributeSelected(
                                              product,
                                              attribute.name ?? '',
                                              attributeValue);
                                        }
                                      }
                                    : null, // This is very imp otherwise the chip will be displayed disabled
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
