import 'package:bus/config/colors.dart';
import 'package:bus/models/tripModel.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';

class BookingReceipt extends StatelessWidget {
  TripModel tripData;
  List<Seat> seats;

  BookingReceipt({required this.tripData, required this.seats});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 300,
      color: AppColors.whiteColor1,
      child: Stack(
        children: [
          
          Positioned(
            child: Container(
              height: 30,
              width: double.maxFinite,
              child: Center(
                child: MediumTextWidget(
                  color: AppColors.appTextColor1,
                  data: "Receipt",
                ),
              ),
            ),
          ),
          Positioned(
            top: 48,
            left: 8,
            right: 8,
            child: Container(
              // height: 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MediumTextWidget(
                          data: tripData.sacco.name,
                          color: AppColors.appMainColor),
                      SmallTextWidget(
                          data: "Serial No:${tripData.id}",
                          color: AppColors.appTextColor1)
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallTextWidget(
                            data: tripData.routes.toString(),
                            color: Colors.black),
                        SmallTextWidget(
                            data: DateTime.now().toString().substring(0, 10),
                            color: Colors.black87),
                        SmallTextWidget(
                            data: tripData.vehicle.registration,
                            color: Colors.black)
                      ],
                    ),
                  ),
                  const Divider(
                    color: AppColors.appTextColor3,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                    // height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallTextWidget(
                                    data: "Name",
                                    color: AppColors.appTextColor3),
                                SmallTextWidget(
                                    data: seats[0].customer.firstName,
                                    color: Colors.black),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallTextWidget(
                                    data: "Id Number",
                                    color: AppColors.appTextColor3),
                                SmallTextWidget(
                                    data: "12345678", color: Colors.black),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallTextWidget(
                                    data: "Seats",
                                    color: AppColors.appTextColor3),
                                SmallTextWidget(
                                    data: seats.length.toString(),
                                    color: Colors.black),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallTextWidget(
                                    data: "Type",
                                    color: AppColors.appTextColor3),
                                SmallTextWidget(
                                    data: "Normal", color: Colors.black),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallTextWidget(
                                    data: "Seat Number",
                                    color: AppColors.appTextColor1),
                                Row(
                                  children: List.generate(
                                    seats.length,
                                    (index) => SmallTextWidget(
                                      data:
                                          "${seats[index].seatNumber.toString()}, ",
                                      color: AppColors.appMainColor,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 350,
            left: -20,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColors.appBgColor,
                  borderRadius: BorderRadius.circular(40)),
            ),
          ),
          Positioned(
            top: 350,
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
            top: 370,
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
          // Positioned(child: )
        ],
      ),
    );
  }
}
