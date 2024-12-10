import 'package:e_commerce_app/data/repositories/products/product_repository.dart';
import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/dummy/dummy_data.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../authentication/controllers/network_manager/network_manager.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    super.onInit();
    fetchProductsModel();
  }

  Future<void> fetchProductsModel() async {
    try {
      // open loading
      isLoading.value = true;

      // Calling get all products function of Product Repository

      final products = await productRepository.getAllProducts();

      // Assign all featuredProducts to RxList
      featuredProducts.assignAll(products
          .where((product) => product.isFeatured == true)
          .take(4)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {
      // Calling get all products function of Product Repository

      final products = await productRepository.getFeaturedProducts();

      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get product price or price variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variation exists, then return simple price or sale price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      // Calculate the smallest and the largest prices among variations
      for (var variation in product.productVariations!) {
        // Determine the price to consider (sale price if available, otherwise simple price)
        double priceToConsider =
            variation.salePrice > 0 ? variation.salePrice : variation.price;

        // Update smalled and largest price
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }

        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  /// Calculate price percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;

    if (originalPrice <= 0.0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    // toStringAsFixed(0) means to return a fixed number (e.g: 1) and not a double type number (e.g: 1.2)
    return percentage.toStringAsFixed(0);
  }

  /// Check Product Stock Status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  /// Permission message
  permissionForUploading() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.defaultSpace),
      title: 'Upload Products',
      middleText: 'Are you sure you want to upload the Dummy Products Data?',
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
          'Uploading Dummy Products Data', TImages.cloudAnimation);

      // check network
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // fetch the dummy categories list
      final products = TDummyData.products;

      // upload dummy data
      await productRepository.uploadDummyData(products);

      // success message
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Dummy Products Uploaded Successfully');

      Navigator.of(Get.overlayContext!).pop();
      fetchProductsModel();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
