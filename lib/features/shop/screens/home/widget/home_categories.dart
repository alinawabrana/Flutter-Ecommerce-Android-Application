import 'package:e_commerce_app/common/widgets/shimmer/category_shimmer_effect.dart';
import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/screens/sub_category/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());

    return Obx(
      () {
        if (controller.isLoading.value) return const TCategoryShimmerEffect();

        if (controller.featuredCategories.isEmpty) {
          return Center(
            child: Text(
              'No data Found!',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.white),
            ),
          );
        }

        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = controller.featuredCategories[index];
              return TVerticalImageText(
                title: category.name,
                image: category.image,
                onTap: () => Get.to(() => SubCategoryScreen(
                      category: category,
                    )),
              );
            },
          ),
        );
      },
    );
  }
}
