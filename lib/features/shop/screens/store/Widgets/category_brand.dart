import 'package:e_commerce_app/common/widgets/brands/brand_showcase.dart';
import 'package:e_commerce_app/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:e_commerce_app/common/widgets/shimmer/list_tile_shimmer.dart';
import 'package:e_commerce_app/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';

class CategoryBrand extends StatelessWidget {
  const CategoryBrand({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandsForCategory(category.id),
        builder: (context, snapshot) {
          const loader = Column(
            children: [
              TListTileShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TBoxesShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              )
            ],
          );

          final widget = TCloudHelperFunctions.checkMultipleRecordState(
              snapshot: snapshot, loader: loader);

          if (widget != null) return widget;

          final brands = snapshot.data!;

          return ListView.builder(
              itemCount: brands.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final brand = brands[index];

                return FutureBuilder(
                    future: controller.getBrandProducts(
                        brandId: brand.id, limit: 3),
                    builder: (context, snapshot) {
                      final widget =
                          TCloudHelperFunctions.checkMultipleRecordState(
                              snapshot: snapshot, loader: loader);

                      if (widget != null) return widget;

                      final product = snapshot.data!;

                      return TBrandShowcase(
                        images: product.map((e) => e.thumbnail).toList(),
                        brand: brand,
                      );
                    });
              });
        });
  }
}
