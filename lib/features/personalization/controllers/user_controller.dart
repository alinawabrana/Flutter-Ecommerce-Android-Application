import 'package:e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:e_commerce_app/features/personalization/models/user_model.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  /// Function to saveUserData to Fire Store
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username =
            UserModel.generateUsername(userCredentials.user!.displayName ?? '');

        final newUser = UserModel(
            id: userCredentials.user!.uid ?? '',
            email: userCredentials.user!.email ?? '',
            username: username,
            firstName: nameParts.length > 1
                ? nameParts.sublist(1, nameParts.length - 1).join(' ')
                : nameParts[0],
            lastName: nameParts[nameParts.length],
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '');

        // Save user data
        await userRepository.saveUserRecord(newUser);
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data not Saved!',
          message:
              'Something went wrong while saving your information. Please re-save your information.');
    }
  }
}
