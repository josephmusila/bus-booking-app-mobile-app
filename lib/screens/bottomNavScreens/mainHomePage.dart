import 'package:bus/cubits/searchTrip/tripSearchStates.dart';
import 'package:bus/cubits/searchTrip/searchTripCubits.dart';
import 'package:bus/services/saccoServices.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:bus/widgets/homepageWidgets/customNavDrawer.dart';
import 'package:bus/widgets/homepageWidgets/tripdetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/colors.dart';
import '../../cubits/sacco/saccoCubits.dart';
import '../../cubits/sacco/saccoStates.dart';
import '../../models/routeModel.dart';
import '../../models/saccoModel.dart';
import '../../models/tripModel.dart';
import '../../models/userModel.dart';
import '../../widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import '../../widgets/homepageWidgets/allTripsWidget.dart';
import '../../widgets/homepageWidgets/searchRoutesWidget.dart';

class MainHomePage extends StatefulWidget {
  List<SaccoModel> saccoData;
  List<TripModel> trips;
  List<RouteModel> routes;
  UserModel? user;

  MainHomePage(
      {required this.trips,
      required this.saccoData,
      required this.routes,
      this.user});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  List<TripModel> trips = [];

  List<RouteModel> allVehicleRoutes = [];
  List<String> startPoints = [];
  List<String> destinations = [];
  List<String> allLocations = [];
  String startPoint = "";
  String destination = "";
  int searchedTripsLength = 0;

  void setRoutePoints() {
    for (var element in allVehicleRoutes) {
      allLocations.add(element.start);
      allLocations.add(element.destination);
    }
    allLocations = Set<String>.from(allLocations).toList();
  }

  void excludeFullTrips() {
    widget.trips.forEach((element) {
      bool isEmpty = unBookedSeatsCount(element) == 0;
      if (!isEmpty) {
        trips.add(element);
      }
    });
  }

  int unBookedSeatsCount(TripModel tripData) {
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
  void initState() {
    // allVehicleRoutes = BlocProvider.of<SaccoCubits>(context).allSaccoRoutes;
    excludeFullTrips();
    setRoutePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SaccoCubits>(context);
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: BlocProvider(
        create: (context) => SearchTripCubits(),
        child: AllTripsWidget(
          user: widget.user,
          allTrips: trips,
          allroutes: widget.routes,
        ),
      ),
    );
  }
}
