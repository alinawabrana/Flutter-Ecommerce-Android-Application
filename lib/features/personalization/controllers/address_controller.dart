import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/data/repositories/address/address_repository.dart';
import 'package:e_commerce_app/features/authentication/controllers/network_manager/network_manager.dart';
import 'package:e_commerce_app/features/personalization/models/address_model.dart';
import 'package:e_commerce_app/features/personalization/screens/address/add_new_address.dart';
import 'package:e_commerce_app/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:e_commerce_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final postalCode = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final controller = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  /// Fetch all the addresses of specific user
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await controller.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: const CircularProgressIndicator(),
      );

      // clear the 'selected' field
      if (selectedAddress.value.id.isNotEmpty) {
        await controller.updateSelectedField(selectedAddress.value.id, false);
      }

      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the 'selected' field to true for the newly selected address
      await controller.updateSelectedField(selectedAddress.value.id, true);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Error in selection', message: e.toString());
    }
  }

  /// Add new Address
  Future<void> addNewAddresses() async {
    try {
      // start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing Address', TImages.docerAnimation);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await controller.addAddress(address);

      // Update Selected Address status
      address.id = id;

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your address has been saved successfully');

      // Refresh Address Data
      refreshData.toggle(); // This will automatically toggle the boolean val

      // Reset fields
      resetFormFields();

      // Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
          title: 'Something went wrong while adding new Address',
          message: e.toString());
    }
  }

  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(TSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(text: 'Select Address'),
            FutureBuilder(
              future: getAllUserAddresses(),
              builder: (_, snapshot) {
                final response = TCloudHelperFunctions.checkMultipleRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                final addresses = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (_, index) => TSingleAddress(
                    address: addresses[index],
                    onTap: () async {
                      await selectAddress(addresses[index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: TSizes.defaultSpace * 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const AddNewAddressScreen()),
                child: const Text('Add new address'),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
