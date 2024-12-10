import 'package:e_commerce_app/data/dummy/dummy_data.dart';
import 'package:e_commerce_app/data/repositories/banners/banner_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/shop/models/banner_model.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  /// Variables
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  final bannerRepo = Get.put(BannerRepository());

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  /// Update Page navigational Dots
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  /// Fetch Banners
  Future<void> fetchBanners() async {
    try {
      // Shoe Loader while loading banners
      isLoading.value = true;

      // Fetch Banners
      final banners = await bannerRepo.fetchBanners();

      // Assign Banners
      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  permissionForUploading() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.defaultSpace),
        title: 'Upload Banners',
        middleText: 'Are you sure you want to upload the dummy banners data?',
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')),
        confirm: ElevatedButton(
          onPressed: () => uploadDummyBanners(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              side: const BorderSide(color: Colors.green)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Confirm'),
          ),
        ));
  }

  // Upload Banners
  Future<void> uploadDummyBanners() async {
    try {
      // Opening full screen dialog
      TFullScreenLoader.openLoadingDialog(
          'Uploading All the Dummy Banners Data', TImages.cloudAnimation);

      // Checking the Network Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // list of dummy banners
      final banners = TDummyData.banners;

      // Upload data
      await bannerRepo.uploadBanners(banners);

      // success message
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Banners Uploaded Successfully');

      Navigator.of(Get.overlayContext!).pop();

      fetchBanners();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
