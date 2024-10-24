import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Send Password Reset Email
  sendPasswordResetEmail() async {
    try {
      // Open Full Screen Loader
      TFullScreenLoader.openLoadingDialog(
          'Processing Your Request...', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Check Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send the Email
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // Stop Full Screen Loader
      TFullScreenLoader.stopLoading();

      // Success Message
      TLoaders.successSnackBar(
          title: 'Email Sent Successfully.',
          message: 'The Password reset email has been sent successfully.');
      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      // Open Full Screen Loader
      TFullScreenLoader.openLoadingDialog(
          'Processing Your Request...', TImages.docerAnimation);

      // Checking Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send Reset Password Email
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // Stop Full Screen Loader
      TFullScreenLoader.stopLoading();

      // Success Message
      TLoaders.successSnackBar(
          title: 'Email Resend Successfully.',
          message: 'The Password reset email has been resend successfully.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
