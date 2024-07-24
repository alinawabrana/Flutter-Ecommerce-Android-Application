// This class will contains all the spacings that will be common in all over the application

import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TSpacingStyle {
  TSpacingStyle._();

  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: TSizes.appBarHeight,
    left: TSizes.defaultSpace,
    right: TSizes.defaultSpace,
    bottom: TSizes.defaultSpace,
  );
}
