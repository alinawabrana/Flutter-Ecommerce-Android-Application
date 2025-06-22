import 'package:cloud_functions/cloud_functions.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._(); // Private constructor
  static final StripeService instance = StripeService._();
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  Future<bool> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(10, 'usd');

      if (paymentIntentClientSecret == null) {
        throw Exception('Failed to create payment intent');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Ali Nawab Rana',
          // Add additional parameters for better UX
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Colors.blue,
            ),
          ),
        ),
      );

      bool successful = await _processPayment();
      return successful;
    } catch (e) {
      print('Payment Error: $e');
      return false;
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      // Call the Firebase Cloud Function
      final HttpsCallable callable =
          _functions.httpsCallable('createPaymentIntent');

      final response = await callable.call({
        'amount': THelperFunctions.calculateAmount(amount),
        'currency': currency.toLowerCase(),
      });

      return response.data['clientSecret'] as String?;
    } catch (e) {
      print('Payment Intent Creation Error: $e');
      rethrow;
    }
  }

  Future<bool> _processPayment() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing your order....', TImages.orderCompleteAnimation);
      await Stripe.instance.presentPaymentSheet();
      print('Payment successful!');
      return true;
    } on StripeException catch (e) {
      print('Stripe Exception: ${e.error.localizedMessage}');
      return false;
    } catch (e) {
      print('Payment Processing Error: $e');
      return false;
    }
  }
}
