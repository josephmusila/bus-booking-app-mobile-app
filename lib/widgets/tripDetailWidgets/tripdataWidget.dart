import 'package:bus/models/tripModel.dart';
import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../appCustomWidgets/textWidget.dart';

class TripDataWidget extends StatelessWidget {
  TripModel trip;

  TripDataWidget({required this.trip});

  int getEmptySeats() {
    int bookedSeat = 0;

    for (var element in trip.seats) {
      if (element.isBooked) {
        bookedSeat++;
      }
    }
    int emptySeats = int.parse(trip.vehicle.capacity) - bookedSeat;
    return emptySeats;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 300,
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
        color: AppColors.whiteColor1,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: SmallTextWidget(
                data: trip.routes.toString(),
                color: AppColors.appTextColor1,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Container(
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(4),
                      color: AppColors.whiteColor1,
                    border: Border.all(
                      color: Colors.black12
                    )
                  ),

                ),
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmallTextWidget(
                          data: trip.sacco.name,
                          color: AppColors.appTextColor1),
                      SmallTextWidget(
                          data: trip.vehicle.registration,
                          color: AppColors.appTextColor1),
                      SmallTextWidget(
                          data: "${trip.vehicle.capacity} Seater",
                          color: AppColors.appTextColor1),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 5,
            right: 5,
            child: SizedBox(
              height: 90,
              width: double.maxFinite,
              // color: AppColors.appComplementaryColor2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallTextWidget(
                      data: "Pick Up Point: ${trip.pickuppoint}",
                      color: AppColors.appTextColor1),
                  SmallTextWidget(
                      data: "Departure Time: ${DateTime.now()}",
                      color: AppColors.appTextColor1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
