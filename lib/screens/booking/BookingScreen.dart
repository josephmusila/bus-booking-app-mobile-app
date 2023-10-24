import 'package:bus/config/colors.dart';
import 'package:bus/layouts/vehicleSeatLayout.dart';
import 'package:bus/models/tripModel.dart';
import 'package:bus/screens/mainScreen.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/sacco/saccoStates.dart';
import '../../models/userModel.dart';
import '../../services/saccoServices.dart';
import '../../widgets/tripDetailWidgets/seatLayoutKeys.dart';
import '../../widgets/tripDetailWidgets/tripdataWidget.dart';
import '../../cubits/sacco/saccoCubits.dart';

class TripDetails extends StatefulWidget {
  TripModel trip;
  UserModel? user;
  TripDetails({
    required this.trip,
    this.user,
  });

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  bool showVehicleDetails = false;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    print("User from booking screen is ${widget.user}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SaccoCubits>(context);
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // bloc.goBackToHomeScreen();
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            //   return BlocProvider(
            //     create: (context) => SaccoCubits(
            //       saccoServices: SaccoServices(),
            //     ),
            //     child: MainScreen(),
            //   );
            // }));
          },
        ),
        title: MediumTextWidget(
          data: "Booking",
          color: AppColors.appTextColor1,
        ),
      ),
      backgroundColor: AppColors.appBgColor,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            //
            InkWell(
              splashColor: AppColors.appMainColor,
              onTap: () {
                setState(() {
                  showVehicleDetails = !showVehicleDetails;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: double.maxFinite,
                color: AppColors.whiteColor1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallTextWidget(
                        data: "See Trip Details",
                        color: AppColors.appTextColor1),
                    const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 40,
                    )
                  ],
                ),
              ),
            ),

            showVehicleDetails
                ? TripDataWidget(trip: widget.trip)
                : Container(),

            const Divider(
              height: 2,
              color: AppColors.appMainColor,
            ),
            const SeatLayoutKeysWidget(),
            Container(
              width: 300,
              // padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocProvider(
                      create: (context) =>
                          SaccoCubits(saccoServices: SaccoServices()),
                      child: VehicleSeatLayout(
                        user: widget.user,
                        trip: widget.trip,
                        vehicleCapacity: widget.trip.vehicle.capacity,
                        seats: widget.trip.seats,
                        fare: widget.trip.routes.fare,
                        tripId: widget.trip.id.toString(),
                      )
                      //   : ThirtyThreeSeaterLayout(
                      // tripId: widget.trip.id.toString(),
                      //       seats: widget.trip.seats,
                      //       fare: widget.trip.routes.fare,
                      //     ),
                      )

                  // FourteenSeaterLayout(id: "14"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
