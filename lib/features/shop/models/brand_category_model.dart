import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  String brandId;
  String categoryId;

  BrandCategoryModel({required this.brandId, required this.categoryId});

  static BrandCategoryModel empty() =>
      BrandCategoryModel(brandId: '', categoryId: '');

  Map<String, dynamic> toJson() {
    return {
      'BrandId': brandId,
      'CategoryId': categoryId,
    };
  }

  factory BrandCategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    if (data.isEmpty) return BrandCategoryModel.empty();

    return BrandCategoryModel(
      brandId: data['BrandId'] ?? '',
      categoryId: data['CategoryId'] ?? '',
    );
  }
}
