import 'package:e_commerce_app/data/dummy/dummy_data.dart';
import 'package:e_commerce_app/data/repositories/category/category_repository.dart';
import 'package:e_commerce_app/data/repositories/products/product_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final categoryRepository = Get.put(CategoryRepository());
  final productRepository = ProductRepository.instance;

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
          .take(8)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories =
          await categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get Category or sub-category Products
  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    try {
      final products = await productRepository.getProductsForCategory(
          categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

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

  Future<void> uploadDummyCategories() async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Uploading Dummy Categories Data', TImages.cloudAnimation);

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

  /// Permission message
  permissionForUploadingRelationalData() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.defaultSpace),
      title: 'Upload Categories and Products Relational Data',
      middleText:
          'Are you sure you want to upload the Dummy Categories and Products Relational Data?',
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel')),
      confirm: ElevatedButton(
        onPressed: () => uploadDummyCategoriesAndProductRelation(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            side: const BorderSide(color: Colors.green)),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Confirm')),
      ),
    );
  }

  Future<void> uploadDummyCategoriesAndProductRelation() async {
    try {
      // Start Loader
      TFullScreenLoader.openLoadingDialog(
          'Uploading Dummy Categories and Products Relational Data',
          TImages.cloudAnimation);

      // check network
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // fetch the dummy categories list
      final productCategories = TDummyData.productCategory;

      // upload dummy data
      await productRepository
          .uploadDummyRelationalCategoryData(productCategories);

      // success message
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title:
              'Dummy Categories and Products Relational Data Uploaded Successfully');

      Navigator.of(Get.overlayContext!).pop();
      fetchCategories();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
