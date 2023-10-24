import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/colors.dart';
import '../../cubits/sacco/saccoCubits.dart';
import '../../models/routeModel.dart';
import '../../models/saccoModel.dart';
import '../../models/vehiclesModel.dart';
import '../../screens/appAdmin/addRouteToVehicleScreen.dart';
import '../../services/saccoServices.dart';
import '../appCustomWidgets/ElevatedButtonWidget.dart';
import '../appCustomWidgets/inputFieldWidget.dart';
import '../appCustomWidgets/textWidget.dart';

class AddNewTripWidget extends StatefulWidget {
  List<VehicleModel> saccoVehicles;
  SaccoModel sacco;

  AddNewTripWidget({required this.sacco, required this.saccoVehicles});

  @override
  State<AddNewTripWidget> createState() => _AddNewTripWidgetState();
}

class _AddNewTripWidgetState extends State<AddNewTripWidget> {
  late VehicleModel selectedVehicle;
  TextEditingController pickUpPointController = TextEditingController();
// List<VehicleModel> saccoVehicles = [];
// SelectedLayout selectedLayout = SelectedLayout.None;
// late VehicleModel selectedVehicle;
  List<RouteModel> saccoRoutes = [];
  bool saccoHasRoutes = true;
  late RouteModel selectedRoute;

  List<RouteModel> addVehicleRoutes() {
    saccoRoutes.addAll(widget.sacco.routes);
    if (widget.sacco.routes.isEmpty) {
      saccoHasRoutes = false;
    } else {
      saccoHasRoutes = true;
    }
    return saccoRoutes;
  }

  @override
  void initState() {
    // TODO: implement initState
    addVehicleRoutes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      width: double.maxFinite,
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          InputDecorator(
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                border: OutlineInputBorder(gapPadding: 0),
                hintText: "Search..",
                labelStyle: TextStyle(fontSize: 20),
                labelText: "Vehicle Registration"),
            child: Autocomplete<VehicleModel>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return widget.saccoVehicles;
                } else {
                  List<VehicleModel> matches = <VehicleModel>[];
                  matches.addAll(widget.saccoVehicles);

                  matches.retainWhere((s) {
                    return s.registration
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                  return matches;
                }
              },
              onSelected: (VehicleModel selection) {
                selectedVehicle = selection;
                // saccoName.text = selection.name;
                // selectedSacco=selection;
                // selectedSacco = selection.id;
                // print('You just selected ${selection.routes}');

                // setState(() {
                //   addVehicleRoutes();
                // });
                //

                // setSaccoRoutes();
                // setState(() {
                //   isSaccoSelected=false;
                // });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          saccoHasRoutes
              ? Column(
                  children: [
                    InputDecorator(
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                          border: OutlineInputBorder(gapPadding: 0),
                          hintText: "Search..",
                          labelStyle: TextStyle(fontSize: 20),
                          labelText: "Route"),
                      child: Autocomplete<RouteModel>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return saccoRoutes;
                          } else {
                            List<RouteModel> matches = <RouteModel>[];
                            matches.addAll(saccoRoutes);

                            matches.retainWhere((s) {
                              return s.start.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase()) ||
                                  s.destination.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase());
                            });
                            return matches;
                          }
                        },
                        onSelected: (RouteModel selection) {
                          // saccoName.text = selection.name;
                          // selectedSacco=selection;
                          // selectedSacco = selection.id;
                          selectedRoute = selection;

                          // setState(() {
                          //   isSaccoSelected=true;
                          // });
                          // setSaccoRoutes();
                          // setState(() {
                          //   isSaccoSelected=false;
                          // });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputFieldWidget(
                      validator: (value) {},
                      controller: pickUpPointController,
                      labelText: "PickUp Point",
                      hint: "Pickup point  A",
                    ),
                  ],
                )
              : SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SmallTextWidget(
                          data:
                              "Selected Vehicle ${selectedVehicle.registration} has no routes",
                          color: AppColors.appPrimaryColor),
                      ElevatedButtonWidget(
                          title: "Add Route",
                          callBack: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) => SaccoCubits(
                                        saccoServices: SaccoServices()),
                                    child: AddRouteToVehicleScreen(
                                        singleVehicleModel: selectedVehicle,
                                        routes: widget.sacco.routes),
                                  );
                                },
                              ),
                            );

                            // BlocProvider.of<SaccoCubits>(context)
                            //     .saccoVehicles;
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (context) {
                            //   return AddRouteToVehicleScreen(
                            //       singleVehicleModel: selectedVehicle,
                            //       routes: widget.sacco.routes);
                            // }));
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            //   return AddRouteToVehicleScreen(
                            //       singleVehicleModel: selectedVehicle,
                            //       routes: widget.sacco.routes);
                            // }));
                          },
                          color: AppColors.appMainColor)
                    ],
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: double.maxFinite,
            child: ElevatedButtonWidget(
              title: "Add Trip",
              color: AppColors.appMainColor,
              callBack: () {
                BlocProvider.of<SaccoCubits>(context).addTrip(
                    routeId: selectedRoute.id.toString(),
                    pickUpPoint: pickUpPointController.text,
                    numberofSeats: int.parse(selectedVehicle.capacity),
                    saccoId: widget.sacco.id.toString(),
                    vehicleId: selectedVehicle.id.toString());
              },
            ),
          )
        ],
      ),
    );
  }
}
