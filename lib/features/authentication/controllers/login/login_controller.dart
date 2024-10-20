import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/network_manager/network_manager.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final rememberMe = false.obs;
  final showPassword = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final localStorage = GetStorage();

  @override
  void onInit() {
    email.text = localStorage.read('Remember-Email') ?? '';
    password.text = localStorage.read('Remember-Password') ?? '';
    super.onInit();
  }

  void emailAndPasswordSignIn() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'We are processing your Information', TImages.docerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write('Remember-Email', email.text.trim());
        localStorage.write('Remember-Password', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance
          .signInWithEmailAndPassword(email.text.trim(), password.text.trim());

      TFullScreenLoader.stopLoading();

      TLoaders.successSnackBar(title: 'Signed In Successfully');

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
