import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/images/t_rounded_image.dart';
import 'package:e_commerce_app/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:e_commerce_app/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          category.name,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Banner
              const TRoundedImage(
                width: double.infinity,
                imageUrl: TImages.promoBanner1,
                applyImageRadius: true,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Sub Categories
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {
                  const loader = THorizontalProductShimmer();
                  final widget = TCloudHelperFunctions.checkMultipleRecordState(
                      snapshot: snapshot, loader: loader);

                  if (widget != null) return widget;

                  final subCategories = snapshot.data!;

                  return ListView.builder(
                    itemCount: subCategories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final subCategory = subCategories[index];
                      return FutureBuilder(
                        future: controller.getCategoryProducts(
                            categoryId: subCategory.id),
                        builder: (context, snapshot) {
                          final widget =
                              TCloudHelperFunctions.checkMultipleRecordState(
                                  snapshot: snapshot, loader: loader);
                          if (widget != null) return widget;

                          final product = snapshot.data!;
                          return Column(
                            children: [
                              /// Headings
                              TSectionHeading(
                                text: subCategory.name,
                                onPressed: () => Get.to(
                                  () => AllProducts(
                                    title: subCategory.name,
                                    futureMethod:
                                        controller.getCategoryProducts(
                                            categoryId: subCategory.id,
                                            limit: -1),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: TSizes.spaceBtwItems / 2,
                              ),

                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  itemCount: product.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                          width: TSizes.spaceBtwItems),
                                  itemBuilder: (context, index) =>
                                      TProductCardHorizontal(
                                    product: product[index],
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: TSizes.spaceBtwSections,
                              )
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
