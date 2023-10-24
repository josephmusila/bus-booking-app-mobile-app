import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';

class OutlinedButtonWidget extends StatelessWidget {
  String buttonText;
  VoidCallback onpressed;

  OutlinedButtonWidget({required this.buttonText, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: AppColors.appMainColor, width: 1)),

      onPressed: onpressed,
      child: SmallTextWidget(
        data: buttonText,
        color: AppColors.appTextColor1,
      ),
    );
  }
}
