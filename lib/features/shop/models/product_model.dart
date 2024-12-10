import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/features/shop/models/product_attribute_model.dart';
import 'package:e_commerce_app/features/shop/models/product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  BrandModel? brand;
  String thumbnail;
  bool? isFeatured;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.date,
    this.brand,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
      id: '', title: '', stock: 0, price: 0.0, thumbnail: '', productType: '');

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Thumbnail': thumbnail,
      'ProductType': productType,
      'SKU': sku,
      'Brand': brand!.toJson() ?? {},
      'Images': images ?? [],
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Description': description,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson())
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson())
          : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    if (data.isEmpty) return ProductModel.empty();

    return ProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      productType: data['ProductType'] ?? '',
      sku: data['SKU'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      isFeatured: data['IsFeatured'] ?? false,
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList()
          : [],
    );
  }

  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    if (data.isEmpty) return ProductModel.empty();

    return ProductModel(
      id: document.id,
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      productType: data['ProductType'] ?? '',
      sku: data['SKU'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      isFeatured: data['IsFeatured'] ?? false,
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
              .map((e) => ProductAttributeModel.fromJson(e))
              .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
              .map((e) => ProductVariationModel.fromJson(e))
              .toList()
          : [],
    );
  }
}
