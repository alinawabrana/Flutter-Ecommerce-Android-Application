import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/features/shop/controllers/home_controller.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          // To create the custom list depending upon the items included in banners variable we uses the .map property
          items: banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
          options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index)),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < banners.length; i++)
                TCircularContainer(
                  width: 20,
                  height: 6,
                  margin: const EdgeInsets.only(right: 10),
                  // In order to show on which slider page we are currently on we will use the currentIndex value and compare it with index of for loop.
                  // The color of that dot/TCircularContainer will be primary whose for loop index matches the currentIndex
                  backgroundColor: (controller.carousalCurrentIndex.value == i)
                      ? TColors.primaryColor
                      : TColors.grey,
                ),
            ],
          ),
        )
      ],
    );
  }
}
