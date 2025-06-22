import 'package:e_commerce_app/common/widgets/success_screen/success_screen.dart';
import 'package:e_commerce_app/data/repositories/order/order_repository.dart';
import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/product/checkout_controller.dart';
import 'package:e_commerce_app/features/shop/models/order_model.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';

import 'package:e_commerce_app/utils/services/stripe_payment_service.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = Get.put(CartController());
  final addressController = AddressController.instance;
  final checkoutController = Get.put(CheckoutController());
  final orderRepository = Get.put(OrderRepository());

  /// Fetch Users order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Add method for order processing
  Future<void> processOrder(double totalAmount) async {
    try {

      bool isSuccessFull = await StripeService.instance.makePayment();

      if (isSuccessFull == false) {
        TFullScreenLoader.stopLoading();
        return;
      }

      TFullScreenLoader.openLoadingDialog(
          'Processing your Order', TImages.pencilAnimation);


      // Get user Authentication Id
      final userId = FirebaseAuth.instance.currentUser!.uid;
      if (userId.isEmpty) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Add Details
      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: userId,

        status: OrderStatus.processing.name,

        status: OrderStatus.pending,

        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        address: addressController.selectedAddress.value,
        deliveryDate: DateTime.now(),
        items: cartController.cartItem.toList(),
      );

      await orderRepository.saveOrder(order, userId);

      // Update the cart status
      cartController.clearCart();

      Get.off(
        () => SuccessScreen(
            image: TImages.verifyIllustration,
            title: 'Payment Success',
            subTitle: 'Your Item will be shipped soon',
            onPressed: () => Get.offAll(() => const NavigationMenu())),
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
