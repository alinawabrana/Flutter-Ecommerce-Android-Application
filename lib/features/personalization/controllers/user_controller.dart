import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/authentication/screens/login/login.dart';
import 'package:e_commerce_app/features/personalization/models/user_model.dart';
import 'package:e_commerce_app/features/personalization/screens/reAuthLogin/re_auth_login_form.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());

  // Creating Rx<UserModel> type of variable for a single read operation throughout the application
  // Also the below user is used everywhere where we need the data of current user like Name, Email etc
  final user = UserModel.empty().obs;

  // controllers for new First and Last name
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final profileLoading = false.obs;
  GlobalKey<FormState> changeNameFormKey = GlobalKey<FormState>();

  // Re Authenticate controllers
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthLoginFormKey = GlobalKey<FormState>();
  final showPassword = false.obs;

  final imageUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  /// Function to saveUserData to Fire Store
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First update Rx user and then check if user data is already stored. If not then store new data.

      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

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
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data not Saved!',
          message:
              'Something went wrong while saving your information. Please re-save your information.');
    }
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
      TLoaders.warningSnackBar(
          title: 'Data not Fetched!',
          message:
              'Something went wrong while fetching the user data from the FireStore. Please try again');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.defaultSpace),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete the account permanently?. This action is irreversible and all of your data will be removed permanently.',
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
      confirm: ElevatedButton(
        onPressed: () => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
          child: Text('Delete'),
        ),
      ),
    );
  }

  Future<void> deleteUserAccount() async {
    try {
      // Start the Loader
      TFullScreenLoader.openLoadingDialog(
          'Deleting your account...', TImages.docerAnimation);

      // Checking the internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      final auth = AuthenticationRepository.instance;
      final provider = FirebaseAuth.instance.currentUser?.providerData
          .map((e) => e.providerId)
          .first;
      if (provider!.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Error deleting Account.',
          message:
              'An error has occurred while deleting the account. Please try again.');
    }
  }

  Future<void> reAuthenticateEmailAndPassword() async {
    try {
      // Open full screen Loader
      TFullScreenLoader.openLoadingDialog(
          'Re-Authenticating & Deleting your account...',
          TImages.docerAnimation);

      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Validating te Re Authenticate Form
      if (!reAuthLoginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final auth = AuthenticationRepository.instance;
      // Calling Re-Authenticate of Authentication Repository
      await auth.reAuthenticateWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());

      // Calling deleteAccount of Auth Repo
      await auth.deleteAccount();

      TFullScreenLoader.stopLoading();
      Get.offAll(const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Error deleting Account.',
          message:
              'An error has occurred while deleting the account. Please try again.');
    }
  }

  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageURL = await UserRepository.instance
            .uploadImage('Users/Images/Profile', image);

        // update the user data
        Map<String, dynamic> json = {'ProfilePicture': imageURL};
        await UserRepository.instance.updateSingleField(json);

        // updating the Rx user
        user.value.profilePicture = imageURL;

        TLoaders.successSnackBar(
            title: 'Congratulations!!!',
            message: 'Your Profile Image has been updated.');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Oh Snap!!!', message: 'Something went wrong. $e');
    } finally {
      imageUploading.value = false;
    }
  }
}
