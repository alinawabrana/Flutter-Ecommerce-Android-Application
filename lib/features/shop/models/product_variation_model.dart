class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.image = '',
    this.description = '',
    this.salePrice = 0.0,
    this.stock = 0,
    this.price = 0.0,
    this.sku = '',
    required this.attributeValues,
  });

  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  Map<String, dynamic> toJson() {
    return {
      'SKU': sku,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProductVariationModel.empty();

    return ProductVariationModel(
      id: data['Id'] ?? '',
      image: data['Image'] ?? '',
      description: data['Description'] ?? '',
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      price: double.parse((data['Price'] ?? 0.0).toString()),
      stock: data['Stock'] ?? 0,
      sku: data['SKU'] ?? '',
      attributeValues: data['AttributeValues'] != null
          ? Map<String, String>.from(data['AttributeValues'])
          : {},
    );
  }
}
