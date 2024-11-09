import 'package:e_commerce_app/features/personalization/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../images/t_circular_image.dart';
import '../shimmer/shimmer_effect.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final networkImage = controller.user.value.profilePicture;
    final image = networkImage.isNotEmpty ? networkImage : TImages.user;
    return ListTile(
      leading: TCircularImage(
        image: image,
        width: 50,
        height: 50,
        padding: 0,
        isNetworkImage: networkImage.isNotEmpty,
      ),
      title: controller.profileLoading.value
          ? const TShimmerEffect(width: 80, height: 15)
          : Text(controller.user.value.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: TColors.white)),
      subtitle: Text(controller.user.value.email,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: TColors.white)),
      trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: TColors.white)),
    );
  }
}
