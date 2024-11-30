import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/data/services/firebase_storage/firebase_storage_service.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:e_commerce_app/utils/exceptions/firebase_exceptions.dart';
import 'package:e_commerce_app/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      // Fetching a query snapshot from Category type of collection
      final snapshot = await _db.collection('Categories').get();

      // NOTE THAT: if we don't use .doc then it will return query snapshot and if we use .doc after collection then it will return document snapshot

      // Converting that query snapshot first into document snapshot and then converting that snapshot into a list of categories.

      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Get Sub Categories

  /// Upload Categories to the Cloud Firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Upload all the Categories along with their Images
      final storage = Get.put(TFirebaseStorageService());

      // Loop through each category
      for (var category in categories) {
        // Get ImageData link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload Image and Get its URL
        final url = await storage.uploadImageData(
            'Categories/Images', file, category.image.toString());

        // Assign URL to Category.image attribute
        category.image = url;

        // Store Category in FireStore
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
