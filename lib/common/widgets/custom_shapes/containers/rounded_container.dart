import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.radius = TSizes.cardRadiusLg,
    this.child,
    this.showBorder = true,
    this.borderColor = TColors.borderPrimary,
    this.backgroundColor = TColors.white,
  });

  final double? width, height;
  final EdgeInsetsGeometry? padding, margin;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
          border: showBorder ? Border.all(color: borderColor) : null),
      child: child,
    );
  }
}
