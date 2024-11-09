import 'package:e_commerce_app/data/repositories/category/category_repository.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
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
          .take(8)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Load selected category data

  /// Get Category or sub-category Products
}
