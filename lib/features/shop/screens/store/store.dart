import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/screens/brands/all_brands.dart';
import 'package:e_commerce_app/features/shop/screens/brands/brand_products.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/tabbar.dart';
import '../../../../common/widgets/brands/brand_card.dart';
import 'Widgets/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final categories = CategoryController.instance.featuredCategories;
    final brands = Get.put(BrandController());
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              onPressed: () {},
            ),
          ],
        ),

        /// As in the same screen we want the vertical scroll and inside that we have a horizontal scroll therefore we will use NestedScrollView Widget
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: darkMode ? TColors.black : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      /// -- Search Bar
                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      const TSearchContainer(
                        text: 'Search in Store',
                        showBackground: false,
                        showBorder: true,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),

                      /// -- Featured Brands
                      TSectionHeading(
                        text: 'Featured Brand',
                        onPressed: () => Get.to(() => AllBrandsScreen(
                              brands: brands.allBrands,
                            )),
                      ),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 1.5,
                      ),

                      Obx(
                        () => TGridLayout(
                          mainAxisExtent: 80,
                          itemCount: brands.featuredBrands.length,
                          itemBuilder: (_, index) {
                            return TBrandCard(
                              onTap: () => Get.to(() => BrandProducts(
                                    brand: brands.featuredBrands[index],
                                  )),
                              showBorder: false,
                              brand: brands.featuredBrands[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                /// Tabs
                bottom: TTabBar(
                  tabs: categories
                      .map(
                        (category) => Tab(
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
              children: categories
                  .map((category) => TCategoryTab(
                        category: category,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
