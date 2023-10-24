import 'package:bus/config/colors.dart';
import 'package:bus/models/tripModel.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

import '../../models/userModel.dart';

class BookingDataScreen extends StatelessWidget {
  TripModel tripModel;
  List<Seat> seats;
  UserModel user;

  BookingDataScreen({
    required this.tripModel,
    required this.seats,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 500,
        width: double.maxFinite,
        child: ListView(
          children: [
            Container(
              height: 40,
              width: double.maxFinite,
              color: AppColors.appMainColor,
              child: Center(
                child: SmallTextWidget(
                    data: "Please Confirm Your Ticket Details",
                    color: AppColors.appTextColor2),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 150,
              width: double.maxFinite,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor1,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black26, width: 2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: MediumTextWidget(
                      data: "User Details",
                      color: AppColors.appTextColor3,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Name",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "${user.firstName} ${user.lastName}",
                            color: AppColors.appTextColor1,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Id/Passport Number",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: user.idNumber,
                            color: AppColors.appTextColor1,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Email",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: user.email,
                            color: AppColors.appTextColor1,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Phone Number",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: user.phone,
                            color: AppColors.appTextColor1,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 250,
              width: double.maxFinite,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor1,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black26, width: 2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: MediumTextWidget(
                      data: "Trip Details",
                      color: AppColors.appTextColor3,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Sacco",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: tripModel.sacco.name,
                            color: AppColors.appTextColor1,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Vehicle Registration",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: tripModel.vehicle.registration,
                            color: AppColors.appTextColor1,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Route",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: tripModel.routes.toString(),
                            color: AppColors.appTextColor1,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Seats",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: Wrap(
                            children:List.generate(seats.length, (index) => SmallTextWidget(
                              data: "${seats[index].seatNumber}, ",
                              color: AppColors.appTextColor1,
                            ),)

                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Total Fare ",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Ksh ${seats.length * int.parse(tripModel.routes.fare)}.00",
                            color: AppColors.appTextColor1,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "Departure ",
                            color: AppColors.appTextColor3,
                          )),
                      Expanded(
                          flex: 2,
                          child: SmallTextWidget(
                            data: "11/12/2023 10:30 A.M",
                            color: AppColors.appTextColor1,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
