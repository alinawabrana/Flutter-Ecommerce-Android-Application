import 'package:e_commerce_app/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:e_commerce_app/features/authentication/screens/login/login.dart';
import 'package:e_commerce_app/utils/constants/image_strings.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/helper_functions.dart';

class ResetPassword extends StatelessWidget {
  final String email;

  const ResetPassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // NOTE: This screen is same as the Success Screen but the difference is that its button is rigid

              /// Image with 60 % of screen width
              Image(
                image: const AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Email display
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              /// Title & SubTitle
              Text(
                TTexts.changeYourPasswordTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Text(
                TTexts.changeYourPasswordSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.offAll(const LoginScreen()),
                      child: const Text(TTexts.done))),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () => ForgetPasswordController.instance
                          .resendPasswordResetEmail(email),
                      child: const Text(TTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
