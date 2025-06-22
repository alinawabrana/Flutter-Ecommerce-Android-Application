import 'package:e_commerce_app/common/widgets/texts/section_heading.dart';
import 'package:e_commerce_app/features/personalization/controllers/address_controller.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TBillingAddressSection extends StatelessWidget {
  const TBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionHeading(
          text: 'Shipping Address',
          buttonTTitle: 'Change',
          onPressed: () {
            controller.selectNewAddressPopup(context);
          },
        ),
        controller.selectedAddress.value.id.isNotEmpty
            ? Column(
                children: [
                  Text(
                    controller.selectedAddress.value.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Text(
                        controller.selectedAddress.value.phoneNumber,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_history,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Expanded(
                        child: Text(
                          controller.selectedAddress.value.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                ],
              )
            : Text(
                'Select Address',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ],
    );
  }
}
