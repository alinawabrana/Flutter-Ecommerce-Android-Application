import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  /// --- Get all Images form Product and Variations
  List<String> getAllProductImages(ProductModel product) {
    // Set<String> variable only saves unique strings in it. All the duplicate Strings will be discarded.
    // This is done so that we can only see an image once in a slider
    Set<String> images = {};

    // save the thumbnail image to images and selectedImage variable
    images.add(product.thumbnail);

    selectedProductImage.value = product.thumbnail;

    // Check if product.images != null and save the product.images to images
    if (product.images != null && product.images!.isNotEmpty) {
      images.addAll(product.images!);
    }

    // Check if variations are available of the product and save its variation images to images
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
          product.productVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }

  /// -- Show image popup
  void showEnlargeImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: TSizes.defaultSpace * 2,
                  horizontal: TSizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: image),
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),
            Align(alignment: Alignment.center,
            child: SizedBox(
              width: 150,
              child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
            ),),
          ],
        ),
      ),
    );
  }
}
