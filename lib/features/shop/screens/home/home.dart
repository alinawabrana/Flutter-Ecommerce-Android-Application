import 'package:e_commerce_app/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_app/features/shop/controllers/product/product_controller.dart';
import 'package:e_commerce_app/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce_app/features/shop/screens/home/widget/home_appbar.dart';
import 'package:e_commerce_app/features/shop/screens/home/widget/home_categories.dart';
import 'package:e_commerce_app/features/shop/screens/home/widget/promo_slider.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';

/// TCircularContainer is a separate class that we created to create a container having two half circles stacked at the right side of the screen.
/// After that we wrap the Container with the ClipPath widgets to create three clip Paths: (1) the clip at left bottom (2) A straight line after that (3) the clip at right bottom
/// Also, We didn't use the border radius because the borders are created towards inner direction but we want the clipped in the opposite direction.
///This ClipPath widget is used inside the TCurvedEdgesWidget class.

/// To use the ClipPath widget and to apply clipping, we use clipper property which takes CustomClipper<Path? as an input.
/// For that we will create a separate class, because CustomClipper<Path> carries two functions within it

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// -- AppBar -- Tutorial [Section # 3, video # 3]
                  THomeAppBar(),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// -- SearchBar -- Tutorial [Section # 3, video # 4]
                  TSearchContainer(
                    text: 'Search in Store',
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// -- Categories -- Tutorial [Section # 3, video # 4]
                  Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// -- Headings
                        TSectionHeading(
                          text: 'Popular Categories',
                          textColor: TColors.white,
                          showActionButton: false,
                        ),
                        SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),

                        /// -- Categories
                        THomeCategories()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            ),

            /// Body -- Tutorial [Section # 3 video # 5]
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// -- Promo Slider
                  const TPromoSlider(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  /// -- Headings
                  TSectionHeading(
                    text: 'Popular Products',
                    textColor: darkMode ? TColors.white : TColors.black,
                    onPressed: () => Get.to(
                      () => AllProducts(
                        title: 'Popular Products',
                        futureMethod: controller.fetchAllFeaturedProducts(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  /// -- Popular Products
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return TVerticalProductShimmer(
                          itemCount: controller.featuredProducts.length,
                        );
                      }

                      if (controller.featuredProducts.isEmpty) {
                        return Center(
                          child: Text(
                            'No Data Found!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }

                      return TGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => TProductCardVertical(
                              product: controller.featuredProducts[index]));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
