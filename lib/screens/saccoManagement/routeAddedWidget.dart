import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';

class RouteAddedWidget extends StatelessWidget {
  const RouteAddedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: AppColors.appBgColor,
      child: Center(
        child: Card(
          elevation: 5,
          color: AppColors.whiteColor1,
          child: SizedBox(
            height: 200,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.check_box,
                  size: 60,
                  color: Colors.green,
                ),
                MediumTextWidget(
                    data: "Route Added Successfully",
                    color: AppColors.appTextColor1),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.maxFinite,
                  child: ElevatedButtonWidget(
                      title: "Okay",
                      callBack: () {
                        Navigator.pop(context);
                      },
                      color: AppColors.appPrimaryColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
