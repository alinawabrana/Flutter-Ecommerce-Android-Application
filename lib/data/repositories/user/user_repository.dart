import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/personalization/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save the user data to FireStore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code);
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code);
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  Future<void> updateUserDetails(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).update(user.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code);
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> data) async {
    try {
      await _db
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update(data);
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code);
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code);
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final imageURL = ref.getDownloadURL();
      return imageURL;
    } on FirebaseException catch (e) {
      throw FirebaseException(plugin: e.code);
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code);
    } catch (e) {
      throw "Something went wrong. Please try again.";
    }
  }
}
