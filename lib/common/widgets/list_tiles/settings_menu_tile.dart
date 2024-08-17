import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return ListTile(
      leading: Icon(
        icon,
        color: TColors.primaryColor,
        size: 28,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .apply(color: darkMode ? TColors.white : TColors.black),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
