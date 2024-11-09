import 'package:e_commerce_app/common/widgets/shimmer/shimmer_effect.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TCategoryShimmerEffect extends StatelessWidget {
  const TCategoryShimmerEffect({super.key, this.count = 6});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: count,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer effect on Image
              TShimmerEffect(
                width: 55,
                height: 55,
                radius: 55,
              ),

              SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),

              // Shimmer effect on Text
              TShimmerEffect(width: 55, height: 0),
            ],
          );
        },
      ),
    );
    ;
  }
}
