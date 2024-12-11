import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  String productId;
  String categoryId;

  ProductCategoryModel({required this.categoryId, required this.productId});

  static ProductCategoryModel empty() =>
      ProductCategoryModel(categoryId: '', productId: '');

  Map<String, dynamic> toJson() {
    return {
      'CategoryId': categoryId,
      'ProductId': productId,
    };
  }

  factory ProductCategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    if (data.isEmpty) return ProductCategoryModel.empty();

    return ProductCategoryModel(
      categoryId: data['CategoryId'] ?? '',
      productId: data['ProductId'] ?? '',
    );
  }
}
