import 'package:e_commerce_app/common/styles/spacing_styles.dart';
import 'package:e_commerce_app/features/authentication/screens.onboarding/login/widgets/login_form.dart';
import 'package:e_commerce_app/features/authentication/screens.onboarding/login/widgets/login_header.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:e_commerce_app/utils/constants/text_strings.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets.login_signup/form_divider.dart';
import '../../../../common/widgets.login_signup/social_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      // First of all we want to make our login screen to be scrollable for small screen. Therefore we will use  Single Child Scroll View
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // We have divided the login page in 4 portions of Column.
              // The First Portion contains the Logo Title and the SubTitle
              // The second portion contains the Form (E-Mail, Password, Remember me, Sign-In, Create Account)
              // The Third portion contains the divider (---------or sign in with----------)
              // The last portion contains the other methods of sign in (Footer)

              /// (1) Logo, Title, SubTitle
              const TLoginHeader(),

              /// (2) Form (E-Mail, Password, Remember me, Sign-In, Create Account)
              const TLoginForm(),

              /// (3) The Divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// (4) The Other sign in methods (Footer)
              const TSocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
