import 'package:bus/cubits/booking/bookingCubits.dart';
import 'package:bus/cubits/sacco/saccoCubits.dart';
import 'package:bus/screens/booking/paymentScreen.dart';
import 'package:bus/services/bookingServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/colors.dart';
import '../../cubits/authentication/authCubits.dart';
import '../../models/tripModel.dart';
import '../../models/userModel.dart';
import '../../services/authservices.dart';
import '../../services/saccoServices.dart';
import '../appCustomWidgets/ElevatedButtonWidget.dart';
import '../appCustomWidgets/textWidget.dart';

class SelectedSeatDataWidget extends StatelessWidget {
  TripModel tripData;
  List<Seat> seats;
  String fare;
  UserModel user;

  SelectedSeatDataWidget(
      {required this.tripData, required this.seats, required this.fare,required this.user,});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SaccoCubits>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.appBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder<List<Seat>>(
        stream: bloc.seatStream,
        initialData: bloc.selectedSeats,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              snapshot.data!.isEmpty
                  ? MediumTextWidget(
                      data: 'No Seat Selected', color: AppColors.appTextColor1)
                  : MediumTextWidget(
                      data:
                          "${snapshot.data!.length} ${snapshot.data!.length == 1 ? "Seat" : "Seats"} X $fare = Ksh ${(snapshot.data!.length) * (int.parse(fare))}",
                      color: AppColors.appTextColor1,
                    ),
              const Divider(
                thickness: 2,
              ),
              snapshot.data!.isEmpty
                  ? Container()
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.maxFinite,
                      child: ElevatedButtonWidget(
                        callBack: () {
                          // bloc.bookSeat(tripId: tripId);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  // lazy:false,
                                  create: (context) => BookingCubits(
                                    bookingServices: BookingServices(),
                                  ),
                                ),
                                BlocProvider(
                                  // lazy:false,
                                  create: (context) => AuthCubits(
                                    authServices: AuthServices(),
                                  ),
                                ),
                              ],
                              child: BookingPaymentScreen(
                                user: user,
                                  tripData: tripData,
                                  seats: snapshot.data as List<Seat>),
                            );
                          }));
                        },
                        title: 'Next',
                        color: AppColors.appMainColor,
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}
