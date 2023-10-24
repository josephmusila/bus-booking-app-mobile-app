import 'package:bus/widgets/appCustomWidgets/ElevatedButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/colors.dart';
import '../../cubits/sacco/saccoCubits.dart';
import '../../models/routeModel.dart';
import '../../models/tripModel.dart';
import '../appCustomWidgets/textWidget.dart';

class SearchRouteScreen extends StatefulWidget {
  List<RouteModel> allRoutes;
  List<TripModel> alltrips;

  SearchRouteScreen({required this.allRoutes,required this.alltrips});

  @override
  State<SearchRouteScreen> createState() => _SearchRouteScreenState();
}

class _SearchRouteScreenState extends State<SearchRouteScreen> {
  List<RouteModel> allVehicleRoutes = [];
  List<String> startPoints = [];
  List<String> destinations = [];
  String startPoint="";
  String destination="";

  void setRoutePoints() {
    for (var element in allVehicleRoutes) {
      startPoints.add(element.start);
      destinations.add(element.destination);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    allVehicleRoutes = widget.allRoutes;
    setRoutePoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc=BlocProvider.of<SaccoCubits>(context);
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
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                      border: OutlineInputBorder(gapPadding: 0),
                      labelStyle: TextStyle(fontSize: 20)),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return startPoints;
                      } else {
                        List<String> matches = <String>[];
                        matches.addAll(startPoints);

                        matches.retainWhere((s) {
                          return s
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                        return matches;
                      }
                    },
                    onSelected: (String selection) {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                      });

                      startPoint=selection;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallTextWidget(
                  data: "To:",
                  color: AppColors.appTextColor1,
                ),
                InputDecorator(
                  decoration:  const InputDecoration(
                    prefixIcon: Icon(Icons.location_on_outlined),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                      border: OutlineInputBorder(gapPadding: 0),
                      labelStyle: TextStyle(fontSize: 20)),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return destinations;
                      } else {
                        List<String> matches = <String>[];
                        matches.addAll(destinations);

                        matches.retainWhere((s) {
                          return s
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                        return matches;
                      }
                    },
                    onSelected: (String selection) {
                      setState(() {
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                      destination=selection;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 42,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5)
            ),
            child: ElevatedButtonWidget(
              title: "Search",
              callBack: () {
                // bloc.searchTrip(widget.alltrips,startPoint,destination);
                // bloc.
              },
              color: AppColors.appMainColor,
            ),
          ),
        ],
      ),
    );
  }
}
