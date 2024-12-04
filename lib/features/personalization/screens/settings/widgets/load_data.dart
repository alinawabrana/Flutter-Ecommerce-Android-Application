import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/shop/controllers/banner_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product_controller.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoadData extends StatelessWidget {
  const LoadData({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = BannerController.instance;
    final categoryController = CategoryController.instance;
    final productController = ProductController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Upload Data',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TSectionHeading(
                text: 'Main Record',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TSettingsMenuTile(
                icon: Iconsax.category,
                title: 'Upload Categories',
                subTitle: '',
                trailing: const Icon(
                  Iconsax.arrow_up_1,
                  color: TColors.primaryColor,
                ),
                onTap: () => categoryController.permissionForUploading(),
              ),
              const TSettingsMenuTile(
                icon: Iconsax.shop,
                title: 'Upload Brands',
                subTitle: '',
                trailing: Icon(
                  Iconsax.arrow_up_1,
                  color: TColors.primaryColor,
                ),
              ),
              TSettingsMenuTile(
                icon: Iconsax.shopping_cart,
                title: 'Upload Products',
                subTitle: '',
                trailing: const Icon(
                  Iconsax.arrow_up_1,
                  color: TColors.primaryColor,
                ),
                onTap: () => productController.permissionForUploading(),
              ),
              TSettingsMenuTile(
                icon: Iconsax.image,
                title: 'Upload Banners',
                subTitle: '',
                trailing: const Icon(
                  Iconsax.arrow_up_1,
                  color: TColors.primaryColor,
                ),
                onTap: () => bannerController.permissionForUploading(),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                text: 'Relationships',
                showActionButton: false,
              ),
              Text(
                'Make sure you have already uploaded all the content above',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TSettingsMenuTile(
                icon: Iconsax.link,
                title: 'Upload Brands & Categories Relational Data',
                subTitle: '',
                trailing: Icon(
                  Iconsax.arrow_up_1,
                  color: TColors.primaryColor,
                ),
              ),
              const TSettingsMenuTile(
                icon: Iconsax.link,
                title: 'Upload Products & Categories Relational Data',
                subTitle: '',
                trailing: Icon(
                  Iconsax.arrow_up_1,
                  color: TColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
