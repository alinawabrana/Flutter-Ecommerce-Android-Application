import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  CategoryModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.isFeatured,
      this.parentId = ""});

  String id, image, name, parentId;
  bool isFeatured;

  static CategoryModel empty() =>
      CategoryModel(id: "", image: "", name: "", isFeatured: false);

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  /// Map Json oriented document from Firebase to CategoryModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      // Map JSON Record to the model
      return CategoryModel(
        id: document.id,
        image: data['Image'] ?? '',
        name: data['Name'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        parentId: data['ParentId'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
