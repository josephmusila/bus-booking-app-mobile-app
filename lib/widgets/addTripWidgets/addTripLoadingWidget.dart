import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../appCustomWidgets/textWidget.dart';


class AddTripLoadingWidget extends StatelessWidget {
  const AddTripLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Center(
        child: Card(
          elevation: 5,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 200,
            width: double.maxFinite,
            color: AppColors.whiteColor1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircularProgressIndicator(),
                SmallTextWidget(
                    data: "Adding Trip ...",
                    color: AppColors.appTextColor1),
                SmallTextWidget(
                    data: "Creating Seats ...",
                    color: AppColors.appTextColor1),
                SmallTextWidget(
                    data: "Adding Seats to trip",
                    color: AppColors.appTextColor1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
