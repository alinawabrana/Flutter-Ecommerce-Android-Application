import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/images/t_circular_image.dart';
import 'package:e_commerce_app/common/widgets/texts/product_price_text.dart';
import 'package:e_commerce_app/common/widgets/texts/product_title_text.dart';
import 'package:e_commerce_app/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.calculateSalePercentage(product.price, product.salePrice) ??
            0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondaryColor.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.sm),
              child: Text(
                '$salePercentage%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),

            /// Price
            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              Text(
                '\$${product.salePrice}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),

            if (product.productType == ProductType.single.toString() &&
                product.salePrice > 0)
              const SizedBox(width: TSizes.spaceBtwItems),

            TProductPriceText(
              price: controller.getProductPrice(product),
              isLarge: true,
            )
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwSections / 1.5),

        /// Title
        TProductTitleText(title: product.title),
        const SizedBox(height: TSizes.spaceBtwSections / 1.5),

        /// Stock Status
        Row(
          children: [
            const TProductTitleText(title: 'Status'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwSections / 1.5),

        /// Brand
        Row(
          children: [
            TCircularImage(
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              overlayColor: darkMode ? TColors.white : TColors.black,
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            TBrandTitleWithVerifiedIcon(
              title: product.brand != null ? product.brand!.name : '',
              brandTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
