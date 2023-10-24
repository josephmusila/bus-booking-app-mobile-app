

import 'package:bus/config/colors.dart';
import 'package:bus/cubits/sacco/saccoCubits.dart';
import 'package:bus/cubits/sacco/saccoStates.dart';
import 'package:bus/screens/booking/bookingSuccessScreen.dart';
import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:bus/widgets/bookingWidgets/bookingReceipt.dart';
import 'package:bus/widgets/layoutWidgets/thirtyThreeSeaterLayoutWidget.dart';
import 'package:bus/widgets/layoutWidgets/seatWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/tripModel.dart';
import '../models/userModel.dart';
import '../widgets/layoutWidgets/fourteenSeaterLayoutWidget.dart';
import '../widgets/layoutWidgets/selectedSeatDataWidget.dart';
import '../widgets/appCustomWidgets/textWidget.dart';

class VehicleSeatLayout extends StatefulWidget {
  List<Seat> seats;
  String fare;
  String tripId;
  String vehicleCapacity;
  TripModel trip;
  UserModel? user;

  // BuildContext context;

  VehicleSeatLayout({
    required this.seats,
    required this.fare,
    required this.tripId,
    required this.trip,
    required this.vehicleCapacity,
    this.user
  });

  @override
  State<VehicleSeatLayout> createState() => _VehicleSeatLayoutState();
}

class _VehicleSeatLayoutState extends State<VehicleSeatLayout> {
  String selectedSeat = "";
  List listOfSeats = [];
  List<Widget> customSeats = [];
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  void setSeatsData(BuildContext context) {
    List<Seat> seatsData = widget.seats;

    for (var element in seatsData) {
      customSeats.add(
        SeatWidget(
          seat: element,
          id: element.seatNumber.toString(),
          canBeSelected: true,

          isBooked: element.isBooked,
          // onPressed: BlocProvider.of<SaccoCubits>(context).getSelectedSeat,
        ),
      );
    }
  }

  Widget setSelectedLayout(List<Seat> seats) {
    if (widget.vehicleCapacity == "14") {
      return FourteenSeaterLayoutWidget(
        seats: seats,
      );
    } else if (widget.vehicleCapacity == "33") {
      return ThirtyThreeSeaterLayoutWidget(
        seats: seats,
      );
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setSelectedLayout(widget.seats);
    setSeatsData(context);
    print(widget.user!.phone??"null");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // BlocProvider.of<SaccoCubits>(context).seatStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SaccoCubits>(context);
    return Card(
      key: _globalKey,
      child: Column(
        children: [
          Column(
            children: [
              setSelectedLayout(widget.seats),
              Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor1,
                  borderRadius: BorderRadius.circular(10),
                ),
                // height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SelectedSeatDataWidget(
                      user: widget.user as UserModel,
                      tripData: widget.trip,
                      seats: widget.seats,
                      fare: widget.fare,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
