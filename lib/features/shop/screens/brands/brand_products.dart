import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/brands/brand_card.dart';
import 'package:e_commerce_app/common/widgets/products/sortable/sortable_products.dart';
import 'package:e_commerce_app/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:e_commerce_app/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(brand.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brands Details
              TBrandCard(
                showBorder: true,
                brand: brand,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              FutureBuilder(
                  future: controller.getBrandProducts(brandId: brand.id),
                  builder: (context, snapshot) {
                    const loader = TVerticalProductShimmer();
                    final widget =
                        TCloudHelperFunctions.checkMultipleRecordState(
                            snapshot: snapshot, loader: loader);

                    if (widget != null) return widget;

                    final products = snapshot.data!;

                    return TSortableProducts(
                      products: products,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
