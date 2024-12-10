import 'package:e_commerce_app/data/dummy/dummy_data.dart';
import 'package:e_commerce_app/data/repositories/brands/brand_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final isLoading = false.obs;

  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    super.onInit();
    fetchAllBrands();
  }

  Future<void> fetchAllBrands() async {
    try {
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
          allBrands.where((brands) => brands.isFeatured == true).toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    try {
      final products =
          await brandRepository.getProductsForBrands(brandId: brandId);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  permissionForUploading() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.defaultSpace),
      title: 'Upload Brands',
      middleText: 'Are you sure you want to upload dummy Brands data?',
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel')),
      confirm: ElevatedButton(
        onPressed: () => uploadDummyData(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            side: const BorderSide(color: Colors.green)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Confirm'),
        ),
      ),
    );
  }

  Future<void> uploadDummyData() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Uploading Dummy Brands Data', TImages.cloudAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final brands = TDummyData.brands;

      await brandRepository.uploadDummyBrandData(brands);

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Dummy Brands Data Uploaded successfully!');

      Navigator.of(Get.overlayContext!).pop();
      fetchAllBrands();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
