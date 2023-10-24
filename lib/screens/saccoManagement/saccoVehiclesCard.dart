import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';

class SaccoVehiclesCard extends StatelessWidget {
  String title;
  IconData icon;
  String buttonText;
  VoidCallback onpressed;

  SaccoVehiclesCard(
      {required this.title,
      required this.icon,
      required this.buttonText,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        shadowColor: AppColors.appPrimaryColor,
        color: AppColors.whiteColor1,
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SmallTextWidget(data: title, color: AppColors.appTextColor1),
              Icon(
                icon,
                size: 50,
                color: AppColors.appPrimaryColor,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.appMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.white, width: 1)),
                onPressed: onpressed,
                child: SmallTextWidget(
                  data: buttonText,
                  color: AppColors.appTextColor2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
