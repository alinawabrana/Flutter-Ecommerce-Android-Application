import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/shop/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user Information. Please try again in few minutes';
      }

      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs
          .map((order) => OrderModel.fromSnapshot(order))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching orders. Please try again. ${e.toString()}';
    }
  }

  /// Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while saving order Information. Please try again later.';
    }
  }
}
