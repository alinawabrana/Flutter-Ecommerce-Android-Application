import 'package:e_commerce_app/features/authentication/screens/login/login.dart';
import 'package:e_commerce_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();

  /// Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to show Relevant Screen
  screenRedirect() async {
    // Local Storage

    if (kDebugMode) {
      print('=================== GET STORAGE ====================');
      print(deviceStorage.read('IsFirstTime'));
    }
    // deviceStorage.remove('IsFirstTime');
    deviceStorage.writeIfNull('IsFirstTime', true);

    deviceStorage.read('IsFirstTime') != true
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const OnBoardingScreen());
  }

/* ----------------------------------- Email & Password sign-in -------------------------------------*/

  /// [EmailAuthentication] - SignIn

  /// [EmailAuthentication] - REGISTER

  /// [ReAuthentication] - ReAuthenticate User

  /// [EmailVerification] - MAIL VERIFICATION

  /// [EmailVerification] - FORGET PASSWORD

/* ----------------------------------- Federated identity & social sign-in -------------------------------------*/

  /// [GoogleAuthentication] - GOOGLE

  /// [FacebookAuthentication] - FACEBOOK

/* ----------------------------------- ./emd Federated identity & social sign-in -------------------------------------*/

  /// [LogoutUser] - Valid for any authentication

  /// [DELETE USER] - Remove user Auth and FireStore Account
}
