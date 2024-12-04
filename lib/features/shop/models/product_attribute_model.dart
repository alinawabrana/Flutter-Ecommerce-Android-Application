class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({
    this.name,
    this.values,
  });

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: data['Values'] != null ? List<String>.from(data['Values']) : [],
    );
  }
}
