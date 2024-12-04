import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          items: [
            'Name',
            'Higher Price',
            'Lower Price' 'Sale',
            'Newest',
            'Popularity'
          ]
              .map((option) =>
                  DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (value) {},
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
        ),

        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        TGridLayout(
            itemCount: 4,
            itemBuilder: (_, index) => TProductCardVertical(
                  product: ProductModel.empty(),
                )),
      ],
    );
  }
}
