import 'package:e_commerce_app/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class THorizontalProductShimmer extends StatelessWidget {
  const THorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
          itemBuilder: (_, __) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Image
                  TShimmerEffect(width: 120, height: 120),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),

                  /// Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      TShimmerEffect(width: 165, height: 14),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                      TShimmerEffect(width: 20, height: 14),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                    ],
                  ),
                ],
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
          itemCount: itemCount),
    );
  }
}
