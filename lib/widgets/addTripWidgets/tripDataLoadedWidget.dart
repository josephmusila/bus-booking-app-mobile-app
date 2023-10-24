import 'package:bus/models/tripModel.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../appCustomWidgets/textWidget.dart';

class TripDataLoadedWidget extends StatelessWidget {
  TripModel tripData;

  TripDataLoadedWidget({
    required this.tripData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 300,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: AppColors.whiteColor1,
                border: Border.all(
                  color: Colors.black26,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MediumTextWidget(
                    data: "Trip Added Successfully",
                    color: AppColors.appPrimaryColor),
                const SizedBox(
                  height: 20,
                ),
                SmallTextWidget(
                    data: "Sacco: ${tripData.sacco.name}",
                    color: AppColors.appTextColor1),
                SmallTextWidget(
                    data: "Route: ${tripData.routes.toString()}",
                    color: AppColors.appTextColor1),
                SmallTextWidget(
                    data: "Fare: Ksh ${tripData.routes.fare}",
                    color: AppColors.appTextColor1),
                SmallTextWidget(
                    data: "Vehicle Capacity:  ${tripData.seats.length}",
                    color: AppColors.appTextColor1),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButtonWidget(
                        title: "Okay",
                        callBack: () {
                          Navigator.pop(context);
                        },
                        color: AppColors.appPrimaryColor))
              ],
            ),
          ),
        ));
  }
}
