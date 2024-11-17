import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerModel {
  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  String imageUrl, targetScreen;
  bool active;

  static BannerModel empty() =>
      BannerModel(imageUrl: '', targetScreen: '', active: false);

  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'Active': active
    };
  }

  factory BannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() != null) {
      final data = snapshot.data() as Map<String, dynamic>;

      return BannerModel(
        imageUrl: data['ImageUrl'] ?? '',
        targetScreen: data['TargetScreen'] ?? '',
        active: data['Active'] ?? false,
      );
    } else {
      return BannerModel.empty();
    }
  }
}
