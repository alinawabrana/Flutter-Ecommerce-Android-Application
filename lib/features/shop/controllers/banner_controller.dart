import 'package:e_commerce_app/data/repositories/banners/banner_repository.dart';
import 'package:e_commerce_app/features/shop/models/banner_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{
  static BannerController get instance => Get.find();

  /// Variables
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;


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
  Future<void> fetchBanners() async{
    try{
      // Shoe Loader while loading banners
      isLoading.value = true;

      // Fetch Banners
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      // Assign Banners
      this.banners.assignAll(banners);
    }catch(e){
      TLoaders.errorSnackBar(title: 'Oh Snap!',message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}