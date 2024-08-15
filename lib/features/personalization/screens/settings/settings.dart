import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:e_commerce_app/common/widgets/images/t_circular_image.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  TAppBar(
                    title: Text('Account',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .apply(color: TColors.white)),
                  ),
                  ListTile(
                    leading: const TCircularImage(
                        image: TImages.user, width: 50, height: 50, padding: 0),
                    title: Text('Ali Nawab Rana',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: TColors.white)),
                    subtitle: Text('support@alinawabrana.com',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: TColors.white)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.edit, color: TColors.white)),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TSectionHeading(
                    text: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingsMenuTile(
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    icon: Iconsax.safe_home,
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    icon: Iconsax.shopping_cart,
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    title: 'My Orders',
                    subTitle: 'In-Progress and Completed Orders',
                    icon: Iconsax.bag_tick,
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                    icon: Iconsax.bank,
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    title: 'My Coupons',
                    subTitle: 'List of all the discounted Coupons',
                    icon: Iconsax.discount_shape,
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    title: 'Notification',
                    subTitle: 'Set any kind of Notification message',
                    icon: Iconsax.notification,
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    title: 'Account Privacy',
                    subTitle: 'Manage data usage and connected accounts',
                    icon: Iconsax.security_card,
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const TSectionHeading(
                    text: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingsMenuTile(
                    title: 'Load Data',
                    subTitle: 'Upload Data to your Cloud Firebase',
                    icon: Iconsax.document_upload,
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on location',
                    icon: Iconsax.location,
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    icon: Iconsax.security_user,
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  TSettingsMenuTile(
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    icon: Iconsax.image,
                    trailing: Switch(value: true, onChanged: (value) {}),
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
