import 'package:e_commerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:e_commerce_app/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce_app/features/shop/controllers/product/order_controller.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TOrderListItems extends StatelessWidget {
  const TOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    final darkMode = THelperFunctions.isDarkMode(context);
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (context, snapshot) {
          final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops! No Orders Yet',
            animation: TImages.orderCompleteAnimation,
            showAction: true,
            actionText: 'Let\'s fill it.',
            onActionPressed: () => Get.off(
              () => const NavigationMenu(),
            ),
          );

          final response = TCloudHelperFunctions.checkMultipleRecordState(
              snapshot: snapshot, nothingFound: emptyWidget);
          if (response != null) return response;

          final orders = snapshot.data!;
          return ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            itemCount: orders.length,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              final order = orders[index];
              return TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: darkMode ? TColors.dark : TColors.light,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// - Row 1
                    Row(
                      children: [
                        /// 1 - Icon
                        const Icon(Iconsax.ship),
                        const SizedBox(
                          width: TSizes.spaceBtwItems / 2,
                        ),

                        /// 2 - Status & Date
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.orderStatusText,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(
                                        color: TColors.primaryColor,
                                        fontWeightDelta: 1),
                              ),
                              Text(
                                order.deliveryDate.toString(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),

                        /// 3 - Icon
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Iconsax.arrow_right_34,
                              size: TSizes.iconSm,
                            ))
                      ],
                    ),

                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    /// - Row 2
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              /// 1 - Icon
                              const Icon(Iconsax.tag),
                              const SizedBox(
                                width: TSizes.spaceBtwItems / 2,
                              ),

                              /// 2 - Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      order.id,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              /// 1 - Icon
                              const Icon(Iconsax.calendar),
                              const SizedBox(
                                width: TSizes.spaceBtwItems / 2,
                              ),

                              /// 2 - Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Shipping Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      order.orderDate.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
