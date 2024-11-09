import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/features/personalization/controllers/user_controller.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Re-Authenticate User',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: controller.reAuthLoginFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: (value) => TValidator.validateEmail(value),
                    decoration: const InputDecoration(
                      labelText: TTexts.email,
                      prefixIcon: Icon(Iconsax.direct_right),
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Obx(
                    () => TextFormField(
                      controller: controller.verifyPassword,
                      validator: (value) =>
                          TValidator.validateEmptyText('Password', value),
                      obscureText: !controller.showPassword.value,
                      decoration: InputDecoration(
                          labelText: TTexts.password,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                              onPressed: () => controller.showPassword.value =
                                  !controller.showPassword.value,
                              icon: Icon(controller.showPassword.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.reAuthenticateEmailAndPassword(),
                child: const Text(
                  'Verify',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
