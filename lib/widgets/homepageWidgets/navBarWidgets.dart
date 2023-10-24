import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';

class NavItem extends StatelessWidget {
  String title;
  IconData icon;
  VoidCallback onPressed;

  NavItem({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.whiteColor1,
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.appAccentColor,
        ),
        title: SmallTextWidget(
          color: AppColors.appTextColor1,
          data: title,
        ),
        onTap: onPressed,
      ),
    );
  }
}
