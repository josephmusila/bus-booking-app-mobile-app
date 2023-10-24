import 'package:bus/config/colors.dart';
import 'package:bus/models/vehiclesModel.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';


class VehicleAddSuccess extends StatelessWidget {
  VehicleModel vehicleData;

  VehicleAddSuccess({
    required this.vehicleData
});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: AppColors.appBgColor,
      child: ListView(
        children: [
          MediumTextWidget(data: vehicleData.registration, color: AppColors.appTextColor1),
          MediumTextWidget(data: vehicleData.capacity, color: AppColors.appTextColor1),
          MediumTextWidget(data: vehicleData.image, color: AppColors.appTextColor1),
        ],
      ),
    );
  }
}
