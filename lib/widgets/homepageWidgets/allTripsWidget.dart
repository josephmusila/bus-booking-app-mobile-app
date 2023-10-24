import 'package:bus/cubits/searchTrip/tripSearchStates.dart';
import 'package:bus/widgets/homepageWidgets/searchRoutesWidget.dart';
import 'package:bus/widgets/homepageWidgets/tripdetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/colors.dart';
import '../../cubits/sacco/saccoCubits.dart';
import '../../cubits/sacco/saccoStates.dart';
import '../../cubits/searchTrip/searchTripCubits.dart';
import '../../models/routeModel.dart';
import '../../models/tripModel.dart';
import '../../models/userModel.dart';
import '../../services/saccoServices.dart';
import '../appCustomWidgets/ElevatedButtonWidget.dart';
import '../appCustomWidgets/textWidget.dart';

class AllTripsWidget extends StatefulWidget {
  List<TripModel> allTrips;
  List<RouteModel> allroutes;
  UserModel? user;

  AllTripsWidget({required this.allTrips, required this.allroutes,this.user});

  @override
  State<AllTripsWidget> createState() => _AllTripsWidgetState();
}

class _AllTripsWidgetState extends State<AllTripsWidget> {
  List<TripModel> trips = [];

  List<RouteModel> allVehicleRoutes = [];
  List<String> startPoints = [];
  List<String> destinations = [];
  List<String> allLocations = [];
  String startPoint = "";
  String destination = "";
  int searchedTripsLength = 0;
  var startPointController = TextEditingController();
  var endPointController = TextEditingController();
  final _focusNode=FocusNode();

  void setRoutePoints() {
    for (var element in allVehicleRoutes) {
      allLocations.add(element.start);
      allLocations.add(element.destination);
    }
    allLocations = Set<String>.from(allLocations).toList();
  }

  @override
  void initState() {
    excludeFullTrips();
    allVehicleRoutes = widget.allroutes;
    setRoutePoints();
    searchedTripsLength = trips.length;
    trips.forEach((element) {
      if(element.id == 6 || element.id == 7){
        print(element);
      }
    });
    super.initState();
  }

  void excludeFullTrips() {
    widget.allTrips.forEach((element) {
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
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchTripCubits>(context);
    return Wrap(
      children: [
        BlocBuilder<SearchTripCubits,SearchTripState>(
          builder: (context,state) {
            return Container(
              height: 270,
              // margin: const EdgeInsets.only(top: 100),
              decoration: const BoxDecoration(
                color: AppColors.whiteColor1,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Stack(
                children: [

                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallTextWidget(
                                  data: "From:",
                                  color: AppColors.appTextColor1,
                                ),
                                InputDecorator(
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.location_on_outlined),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 4),
                                      border: OutlineInputBorder(gapPadding: 0),
                                      labelStyle: TextStyle(fontSize: 20)),
                                  child: Autocomplete<String>(
                                    // initialValue: startPoint,

                                    optionsBuilder:
                                        (startPointController) {
                                      if (startPointController.text == '') {
                                        setState(() {
                                          startPoint = startPointController.text;
                                          bloc.searchTrip(
                                              trips, startPoint, destination);
                                        });
                                        return const Iterable<String>.empty();
                                      } else {
                                        setState(() {
                                          startPoint = startPointController.text;
                                          bloc.searchTrip(
                                              trips, startPoint, destination);
                                        });
                                        List<String> matches = <String>[];
                                        matches.addAll(allLocations);

                                        matches.retainWhere((s) {
                                          return s.toLowerCase().contains(
                                              startPointController.text.toLowerCase());
                                        });
                                        return matches;
                                      }
                                    },
                                    onSelected: (String selection) {
                                      startPoint = selection;

                                      bloc.searchTrip(
                                          trips, startPoint, destination);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SmallTextWidget(
                                  data: "To:",
                                  color: AppColors.appTextColor1,
                                ),
                                InputDecorator(
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.location_on_outlined),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 4),
                                      border: OutlineInputBorder(gapPadding: 0),
                                      labelStyle: TextStyle(fontSize: 20)),
                                  child: Autocomplete<String>(
                                    optionsBuilder:
                                        (endPointController) {
                                      if (endPointController.text == '') {
                                        setState(() {
                                          destination = endPointController.text;
                                          bloc.searchTrip(
                                              trips, startPoint, destination);
                                        });
                                        return const Iterable<String>.empty();
                                      } else {
                                        setState(() {
                                          destination = endPointController.text;
                                          bloc.searchTrip(
                                              trips, startPoint, destination);
                                        });
                                        List<String> matches = <String>[];
                                        matches.addAll(allLocations);

                                        matches.retainWhere((s) {
                                          return s.toLowerCase().contains(
                                              endPointController.text.toLowerCase());
                                        });
                                        return matches;
                                      }
                                    },
                                    onSelected: (String selection) {
                                      destination = selection;
                                      bloc.searchTrip(
                                          trips, startPoint, destination);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: ElevatedButtonWidget(
                              title: "Search",
                              callBack: () {
                                bloc.searchTrip(trips, startPoint, destination);
                                // searchTrip(trips, startPoint, destination);
                              },
                              color: AppColors.appMainColor,
                            ),
                          ),
                          const SizedBox(height: 8,),
                          Container(
                            height: 20,
                            width: double.maxFinite,
                            child: Center(
                              child: SmallTextWidget(
                                data: "$searchedTripsLength Trips Found",
                                color: AppColors.appMainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
        BlocBuilder<SearchTripCubits, SearchTripState>(
            builder: (context, state) {
          if (state is SearchTripSuccessState) {
            searchedTripsLength = state.searchedTrips.length;
            return Container(
              height: 500,
              padding: const EdgeInsets.only(bottom: 150),
              child: ListView(
                // direction: Axis.horizontal,
                children: List.generate(
                  state.searchedTrips.length,
                  (index) => TripDetailWidget(
                    tripData: state.searchedTrips[index],
                    user: widget.user as UserModel,
                  ),
                ),
              ),
            );
          } else if (state is SearchTripLoadingState) {
            return MediumTextWidget(
                data: "searching trips", color: AppColors.appTextColor3);
          } else if (state is NoMatchState) {
            searchedTripsLength = 0;
            return Card(
              child: Container(
                margin: const EdgeInsets.all(16),
                height: 150,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height:100,
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallTextWidget(data: "No Trips Matched", color: AppColors.appTextColor1),
                          SmallTextWidget(data: "From: ${startPoint}", color: AppColors.appTextColor1),
                          SmallTextWidget(data: "To ${destination}", color: AppColors.appTextColor1),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      child: ElevatedButtonWidget(
                        color: AppColors.appPrimaryColor,
                        title: "Reload",
                        callBack: () {
                          setState(() {
                            searchedTripsLength=trips.length;
                            bloc.reloadSearchResults();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: 500,
              padding: const EdgeInsets.only(bottom: 150),
              child: ListView(
                // direction: Axis.horizontal,
                children: List.generate(
                  trips.length,
                  (index) => TripDetailWidget(
                    user: widget.user as UserModel,
                    tripData: trips[index],
                  ),
                ),
              ),
            );
          }
        })
      ],
    );
  }

  void searchTrip(List<TripModel> trips, String from, String to) {
    print(from);
    print(to);
    List<TripModel> searchedTrips = [];
    if (from.isEmpty && to.isEmpty) {
      trips = [];
      setState(() {});
    } else {
      trips.forEach((element) {
        if (element.routes.start == from || element.routes.destination == to) {
          searchedTrips.add(element);
        }
      });
      setState(() {
        trips = searchedTrips;
      });
    }
  }
}
