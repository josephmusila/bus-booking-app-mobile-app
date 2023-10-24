import 'package:bus/config/colors.dart';
import 'package:bus/cubits/sacco/saccoCubits.dart';
import 'package:bus/models/vehiclesModel.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/routeModel.dart';
import '../../widgets/appCustomWidgets/ElevatedButtonWidget.dart';

class AddRouteToVehicleScreen extends StatefulWidget {
  VehicleModel singleVehicleModel;
  List<RouteModel> routes;

  AddRouteToVehicleScreen(
      {required this.singleVehicleModel, required this.routes});

  @override
  State<AddRouteToVehicleScreen> createState() =>
      _AddRouteToVehicleScreenState();
}

class _AddRouteToVehicleScreenState extends State<AddRouteToVehicleScreen> {
  List<RouteModel> routes = [];
  var selectedRoute = "";

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<SaccoCubits>(context).getAllSaccoRoutes();
    routes = widget.routes;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MediumTextWidget(
          data: "Add Route to ${widget.singleVehicleModel.registration}",
          color: AppColors.appPrimaryColor,
        ),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: ListView(
          padding: const EdgeInsets.only(top: 10),
          children: [
            Form(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  children: [
                    MediumTextWidget(
                        data: "Select Route", color: AppColors.appTextColor1),
                    const SizedBox(
                      height: 20,
                    ),
                    InputDecorator(
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                        border: OutlineInputBorder(gapPadding: 0),
                        // hintText: "Search..",
                        // labelText: "Select  Route",
                      ),
                      child: Autocomplete<RouteModel>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<RouteModel>.empty();
                          } else {
                            List<RouteModel> matches = <RouteModel>[];
                            matches.addAll(routes);

                            matches.retainWhere((s) {
                              return s.destination.toLowerCase().contains(
                                  textEditingValue.text.toLowerCase());
                            });
                            return matches;
                          }
                        },
                        onSelected: (RouteModel selection) {
                          // saccoName.text = selection.routes;
                          // selectedSacco = selection.id;
                          selectedRoute = selection.id.toString();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButtonWidget(
                      title: "Add",
                      callBack: () async {
                        var res = await BlocProvider.of<SaccoCubits>(context)
                            .addRouteToVehicle(
                                vehicleId:
                                    widget.singleVehicleModel.id.toString(),
                                routeId: selectedRoute);

                        // if(res == 200) {
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(
                        //     SnackBar(
                        //       content:
                        //       Text("Route Added Succesfully to ${widget
                        //           .singleVehicleModel.registration}"),
                        //       backgroundColor: Colors.green,
                        //       dismissDirection:
                        //       DismissDirection.horizontal,
                        //       behavior:
                        //       SnackBarBehavior.floating,
                        //     ),
                        //   );
                        // }
                        // }else{
                        //   ScaffoldMessenger.of(context)
                        //       .showSnackBar(
                        //     SnackBar(
                        //       content:
                        //       Text("An error occured"),
                        //       backgroundColor: Colors.green,
                        //       dismissDirection:
                        //       DismissDirection.horizontal,
                        //       behavior:
                        //       SnackBarBehavior.floating,
                        //     ),
                        //   );
                        // }
                      },
                      color: AppColors.appPrimaryColor,
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
