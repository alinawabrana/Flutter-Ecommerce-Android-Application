import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/features/personalization/controllers/change_name/change_name_controller.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use real name for easy verification. This name will appear on several pages',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            /// First Name and Last Name Text Fields
            Form(
              key: controller.changeNameFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        TValidator.validateEmptyText('First Name', value),
                    decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        TValidator.validateEmptyText('Last Name', value),
                    decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.changeUserName(),
                child: const Text(
                  'Save',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
