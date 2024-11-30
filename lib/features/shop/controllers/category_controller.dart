import 'package:e_commerce_app/data/dummy/dummy_data.dart';
import 'package:e_commerce_app/data/repositories/category/category_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final categoryRepository = Get.put(CategoryRepository());

  final isLoading = false.obs;

  // creating RxList type of variable having List of Category Model
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchCategories();
  }

  /// -- Load category data
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // fetch categories from data source
      final categories = await categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);

      // filter featured categories (Only 8)

      featuredCategories.assignAll(categories
          .where((category) =>
              category.isFeatured == true && category.parentId.isEmpty)
          .take(5)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Load selected category data

  /// Permission message
  permissionForUploading() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.defaultSpace),
      title: 'Upload Categories',
      middleText: 'Are you sure you want to upload the Dummy Categories Data?',
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel')),
      confirm: ElevatedButton(
        onPressed: () => uploadDummyCategories(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            side: const BorderSide(color: Colors.green)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Confirm')),
      ),
    );
  }

  /// Get Category or sub-category Products
  Future<void> uploadDummyCategories() async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Uploading Dummy Categories Data', TImages.docerAnimation);

      // check network
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // fetch the dummy categories list
      final categories = TDummyData.categories;

      // upload dummy data
      await categoryRepository.uploadDummyData(categories);

      // success message
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Dummy Categories Uploaded Successfully');

      Navigator.of(Get.overlayContext!).pop();
      fetchCategories();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
