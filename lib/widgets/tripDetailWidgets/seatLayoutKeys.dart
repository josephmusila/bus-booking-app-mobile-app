import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../appCustomWidgets/textWidget.dart';

class SeatLayoutKeysWidget extends StatelessWidget {
  const SeatLayoutKeysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
          color: AppColors.whiteColor1
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  color: AppColors.bookedSeatColor,
                ),
                SmallTextWidget(data: "Booked", color: AppColors.appTextColor1)
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  color: AppColors.selectedSeatColor,
                ),
                SmallTextWidget(data: "Selected", color: AppColors.appTextColor1)
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  color: AppColors.selectableSeatColor,
                ),
                SmallTextWidget(data: "Empty", color: AppColors.appTextColor1)
              ],
            ),
          )

        ],
      ),
    );
  }
}
