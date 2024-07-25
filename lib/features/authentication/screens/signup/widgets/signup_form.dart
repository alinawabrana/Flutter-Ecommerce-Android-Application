import 'package:e_commerce_app/features/authentication/screens/signup/widgets/terms_condition_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TSignUpForm extends StatelessWidget {
  const TSignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Form(
      child: Column(
        children: [
          /// First Name, Last Name
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.firstName),
                ),
              ),
              const SizedBox(
                width: TSizes.defaultSpace,
              ),
              Flexible(
                child: TextFormField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: TTexts.lastName),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwUInputFields,
          ),

          /// Username
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.user_edit),
                labelText: TTexts.username),
          ),
          const SizedBox(
            height: TSizes.spaceBtwUInputFields,
          ),

          /// Email
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct), labelText: TTexts.email),
          ),
          const SizedBox(
            height: TSizes.spaceBtwUInputFields,
          ),

          /// Phone Number
          TextFormField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.call), labelText: TTexts.phoneNo),
          ),
          const SizedBox(
            height: TSizes.spaceBtwUInputFields,
          ),

          /// Password
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash)),
          ),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),

          /// Terms and Condition CheckBox
          const TTermsAndConditionCheckbox(),
          const SizedBox(
            height: TSizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {}, child: const Text(TTexts.createAccount)),
          )
        ],
      ),
    );
  }
}
