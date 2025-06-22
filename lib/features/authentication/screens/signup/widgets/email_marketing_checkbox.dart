import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/signup/signup_controller.dart';

class EmailMarketingCheckbox extends StatelessWidget {
  const EmailMarketingCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    final controller = SignupController.instance;

    return Row(
      children: [
        /// CheckBox
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(
              () => Checkbox(
                  value: controller.emailMarketing.value,
                  onChanged: (_) {
                    controller.emailMarketing.value =
                        !controller.emailMarketing.value;
                  }),
            )),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        /// Agree To Text
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: '${TTexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: '${TTexts.emailMarketing} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? TColors.white : TColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor:
                        dark ? TColors.white : TColors.primaryColor),
              ),
            ],
          ),
        ),
      ],
    );
    ;
  }
}
