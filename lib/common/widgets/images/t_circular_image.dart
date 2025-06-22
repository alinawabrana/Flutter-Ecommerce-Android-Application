import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../shimmer/shimmer_effect.dart';

class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.padding = TSizes.sm,
    this.height = 56,
    this.onPressed,
    this.borderRadius = 100,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding, borderRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor ?? (darkMode ? TColors.black : TColors.white),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: isNetworkImage
                ? CachedNetworkImage(
                    fit: fit,
                    imageUrl: image,
                    color: overlayColor,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const TShimmerEffect(width: 55, height: 55),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image(
                    fit: fit,
                    image: AssetImage(image),
                    color: overlayColor,
                  ),
          ),
        ),
      ),
    );
  }
}
