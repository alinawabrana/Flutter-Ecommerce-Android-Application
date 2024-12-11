import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/firebase_storage/firebase_storage_service.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<BrandModel>> getAllBrands() async {
    try {
      final querySnapshot = await _db.collection('Brands').get();
      final brands = querySnapshot.docs
          .map((query) => BrandModel.fromSnapshot(query))
          .toList();
      return brands;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }

  Future<List<BrandModel>> getBrandsForCategory(
      {required String categoryId, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('BrandCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('BrandCategory')
              .where('CategoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();

      // Extract all the brands Id of the categories that are fetched from BrandCategory collection
      List<String> brandId =
          querySnapshot.docs.map((doc) => doc['BrandId'] as String).toList();

      //Use the above BrandIds and fetch the Products related to that

      final brandsQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandId)
          .limit(2)
          .get();

      final brands =
          brandsQuery.docs.map((e) => BrandModel.fromSnapshot(e)).toList();

      return brands;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }

  Future<void> uploadDummyBrandData(List<BrandModel> brands) async {
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(TFirebaseStorageService());

      // Loop through each category
      for (var brand in brands) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(brand.image);

        // Upload Image and Get its URL
        final url =
            await storage.uploadImageData('Brands/Images', file, brand.image);

        // Assign URL to Category.image attribute
        brand.image = url;

        // Store Category in FireStore
        await _db.collection('Brands').doc(brand.id).set(brand.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }
}
