import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/icons/t_circular_icon.dart';
import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:e_commerce_app/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_app/features/shop/controllers/product/favourite_controller.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/features/shop/screens/home/home.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavoriteController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                    future: controller.favoriteProducts(),
                    builder: (context, snapshot) {
                      const loader = TVerticalProductShimmer();

                      final widget =
                          TCloudHelperFunctions.checkMultipleRecordState(
                        snapshot: snapshot,
                        loader: loader,
                        nothingFound: TAnimationLoaderWidget(
                          text: 'Whoops! WishList is Empty...',
                          animation: TImages.pencilAnimation,
                          showAction: true,
                          actionText: 'Let\'s add some',
                          onActionPressed: () => Get.off(
                            () => const NavigationMenu(),
                          ),
                        ),
                      );

                      if (widget != null) return widget;

                      final products = snapshot.data!;

                      return TGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => TProductCardVertical(
                                product: products[index],
                              ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
