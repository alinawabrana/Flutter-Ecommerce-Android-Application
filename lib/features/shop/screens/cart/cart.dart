import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/screens/cart/widgets/cart_item.dart';
import 'package:e_commerce_app/features/shop/screens/checkout/checkout.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),

      /// Check Out Button
      bottomNavigationBar: Obx(
        () => controller.cartItem.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const CheckoutScreen()),
                    child: Obx(
                        () => Text('Checkout \$${controller.totalCartPrice}'))),
              ),
      ),
      body: Obx(
        () {
          final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops! Cart is Empty',
            animation: TImages.cartAnimation,
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const NavigationMenu()),
          );

          // If cart item is empty then display empty animation else display cart items
          if (controller.cartItem.isEmpty) {
            return emptyWidget;
          } else {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: TCartItems(),
              ),
            );
          }
        },
      ),
    );
  }
}
