import 'package:bus/config/colors.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

class VehicleCardWidget extends StatelessWidget {
  const VehicleCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.whiteColor1,
          border: Border.all(color: AppColors.appAccentColor)),
      margin: const EdgeInsets.all(4),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              color: AppColors.appComplementaryColor2,
            ),
          ),
          Positioned(
            bottom: 0,
            top: 150,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              color: AppColors.appTextColor3.withOpacity(0.5),
              child: MediumTextWidget(data: "KCB 794T",color: AppColors.appTextColor2,),
            ),
          )
        ],
      ),
    );
  }
}
