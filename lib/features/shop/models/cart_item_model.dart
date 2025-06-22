import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    required this.quantity,
    this.image,
    this.title = '',
    this.price = 0.0,
    this.brandName,
    this.variationId = '',
    this.selectedVariation,
  });

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Quantity': quantity,
      'Title': title,
      'Price': price,
      'Image': image,
      'BrandName': brandName,
      'VariationId': variationId,
      'SelectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> data) {
    if (data.isEmpty) return CartItemModel.empty();

    return CartItemModel(
      productId: data['ProductId'] ?? '',
      quantity: data['Quantity'] ?? 0,
      title: data['Title'] ?? '',
      price: data['Price']?.toDouble() ?? 0.0,
      image: data['Image'] ?? '',
      brandName: data['BrandName'] ?? '',
      variationId: data['VariationId'] ?? '',
      selectedVariation: data['SelectedVariation'] != null
          ? Map<String, String>.from(data['SelectedVariation'])
          : null,
    );
  }

  factory CartItemModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    if (data.isEmpty) return CartItemModel.empty();

    return CartItemModel(
      productId: data['ProductId'] ?? '',
      quantity: data['Quantity'] ?? 0,
      title: data['Title'] ?? '',
      price: data['Price']?.toDouble() ?? 0.0,
      image: data['Image'] ?? '',
      brandName: data['BrandName'] ?? '',
      variationId: data['VariationId'] ?? '',
      selectedVariation: data['SelectedVariation'] != null
          ? Map<String, String>.from(data['SelectedVariation'])
          : null,
    );
  }
}
