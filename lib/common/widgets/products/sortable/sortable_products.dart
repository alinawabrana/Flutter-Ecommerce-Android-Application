import 'package:e_commerce_app/features/shop/controllers/product/all_products_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assignProducts(products);
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          value: controller.selectedSortOption.value,
          onChanged: (value) => controller.sortProducts(value!),
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
        ),

        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        Obx(
          () => TGridLayout(
              itemCount: controller.product.length,
              itemBuilder: (_, index) => TProductCardVertical(
                    product: controller.product[index],
                  )),
        ),
      ],
    );
  }
}
