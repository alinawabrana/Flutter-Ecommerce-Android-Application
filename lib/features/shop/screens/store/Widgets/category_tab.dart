import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce_app/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/features/shop/screens/store/Widgets/category_brand.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.category,
    required this.brands,
  });

  final CategoryModel category;
  final List<BrandModel> brands;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              CategoryBrand(
                category: category,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              /// -- Products

              FutureBuilder(
                  future:
                      controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {
                    const loader = TVerticalProductShimmer();

                    final widget =
                        TCloudHelperFunctions.checkMultipleRecordState(
                            snapshot: snapshot, loader: loader);

                    if (widget != null) return widget;

                    final products = snapshot.data!;

                    return Column(
                      children: [
                        TSectionHeading(
                          text: 'You might like',
                          showActionButton: true,
                          onPressed: () => Get.to(
                            AllProducts(
                              title: category.name,
                              futureMethod: controller.getCategoryProducts(
                                  categoryId: category.id, limit: -1),
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TGridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => TProductCardVertical(
                                  product: products[index],
                                )),
                      ],
                    );
                  }),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ],
    );
  }
}
