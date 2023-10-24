import 'package:bus/config/colors.dart';
import 'package:bus/models/tripModel.dart';
import 'package:bus/screens/booking/BookingScreen.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/userModel.dart';
import '../../screens/booking/bookingLogicScreen.dart';
import '../../cubits/sacco/saccoCubits.dart';
import '../../services/saccoServices.dart';

class TripDetailWidget extends StatelessWidget {
  TripModel tripData;
  UserModel user;

  TripDetailWidget({required this.tripData, required this.user});

  int unBookedSeatsCount() {
    int emptyseats = 0;
    var bookedSeats = 0;

    tripData.seats.forEach((element) {
      if (element.isBooked) {
        bookedSeats += 1;
      }
    });
    emptyseats = tripData.seats.length - bookedSeats;
    return emptyseats;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if(user == null){
        //   ScaffoldMessenger.of(context)
        //       .showSnackBar(
        //     const SnackBar(
        //       content:
        //       Text("Login To Proceed"),
        //       backgroundColor: Colors.green,
        //       dismissDirection:
        //       DismissDirection.horizontal,
        //       behavior:
        //       SnackBarBehavior.floating,
        //     ),
        //   );
        // }else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => SaccoCubits(saccoServices: SaccoServices()),
            child: TripDetails(
              user: user,
              trip: tripData,
            ),
          );
        }));
        // }
      },
      focusColor: AppColors.appBgColor,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        // padding: const EdgeInsets.all(5),
        height: 170,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor1,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 65,
              left: -20,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.appBgColor,
                    borderRadius: BorderRadius.circular(40)),
                // child: SmallTextWidget(data: tripData.id.toString(),color: AppColors.appMainColor),
              ),
            ),
            Positioned(
              top: 65,
              right: -20,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.appBgColor,
                    borderRadius: BorderRadius.circular(40)),
              ),
            ),
            Positioned(
              top: 85,
              left: 20,
              right: 20,
              child: Container(
                height: 1,
                width: double.maxFinite,
                color: Colors.black,
                child: Row(
                  children: List.generate(
                    20,
                    (index) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        height: 1,
                        color: AppColors.whiteColor1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 4,
              child: Container(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallTextWidget(
                            data: tripData.sacco.name,
                            color: AppColors.appTextColor1),
                        SmallTextWidget(
                            data: "Ksh ${tripData.id}",
                            // data: "Ksh ${tripData.routes.fare}",
                            color: AppColors.appMainColor),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallTextWidget(
                            data: "${tripData.vehicle.capacity} Seater",
                            color: AppColors.appTextColor1),
                        SmallTextWidget(
                            data: "${unBookedSeatsCount()} Seats Remaining",
                            color: unBookedSeatsCount() == 0
                                ? AppColors.appMainColor
                                : AppColors.appPrimaryColor),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 4,
              child: Container(
                height: 70,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallTextWidget(
                            data: tripData.routes.start,
                            color: AppColors.appTextColor1),
                        SmallTextWidget(
                            data: "---------->",
                            color: AppColors.appTextColor1),
                        SmallTextWidget(
                            data: tripData.routes.destination,
                            color: AppColors.appTextColor1)
                      ],
                    ),
                    SmallTextWidget(
                      data:
                          "Departure Time: ${DateTime.now().toString().substring(0, 16)} hrs",
                      color: AppColors.appTextColor1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
