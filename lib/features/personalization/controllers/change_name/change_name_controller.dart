import 'package:e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce_app/features/personalization/screens/profile/profile.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangeNameController extends GetxController {
  static ChangeNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  GlobalKey<FormState> changeNameFormKey = GlobalKey<FormState>();

  final controller = UserController.instance;
  final userRepository = UserRepository.instance;

  @override
  void onInit() {
    super.onInit();
    initializeName();
  }

  Future<void> initializeName() async {
    firstName.text = controller.user.value.firstName;
    lastName.text = controller.user.value.lastName;
  }

  Future<void> changeUserName() async {
    try {
      // Start Full screen loader
      TFullScreenLoader.openLoadingDialog(
          'Updating your Data....', TImages.docerAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Check Form Validation
      if (!changeNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Update the user data using updateSingleField of UserRepository

      // creating the Map<String, dynamic> type variable
      final name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };

      await userRepository.updateSingleField(name);

      // again updating the first name and last name variables of userController' user to newly updated data saved in firstName and LastName of this controller.
      // This is done because we want to reduce the no of read operation of Firebase to again fetch the information of the user.
      // However the data is updated in the firebase but this controller is only fetching data once.
      // Therefore we need to manually update the data inside it using the firstName and LastName of this controller.
      controller.user.value.firstName = firstName.text.trim();
      controller.user.value.lastName = lastName.text.trim();

      // Stop Loader
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(title: 'Names updated successfully');
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
          title: 'Error updating the names',
          message:
              'Something went wrong while updating the First and Last name of the user');
    }
  }
}
