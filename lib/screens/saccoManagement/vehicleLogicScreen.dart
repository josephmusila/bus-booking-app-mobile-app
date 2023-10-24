import 'package:bus/config/colors.dart';
import 'package:bus/cubits/sacco/saccoCubits.dart';
import 'package:bus/cubits/sacco/saccoStates.dart';
import 'package:bus/models/saccoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/routeModel.dart';
import 'addVehicle.dart';
import 'vehicleAddedScreen.dart';
import 'routeAddedWidget.dart';

class VehicleLogicScreen extends StatefulWidget {
  SaccoModel saccoModel;
  List<RouteModel> routes;

  VehicleLogicScreen({required this.saccoModel, required this.routes});

  @override
  State<VehicleLogicScreen> createState() => _VehicleLogicScreenState();
}

class _VehicleLogicScreenState extends State<VehicleLogicScreen> {
  @override
  void initState() {
    BlocProvider.of<SaccoCubits>(context).setVehicleInitialState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: BlocBuilder<SaccoCubits, SaccoState>(builder: (context, state) {
        if (state is VehicleInitialSate) {
          return AddVehicleScreen(
            saccoModel: widget.saccoModel,
          );
        } else if (state is VehicleLoadingState) {
          return Container(
            color: AppColors.whiteColor1,
            height: double.maxFinite,
            width: double.maxFinite,
            child: const Center(
              child: CircularProgressIndicator(
                color: AppColors.appMainColor,
                strokeWidth: 5,
              ),
            ),
          );
        } else if (state is VehicleLoadedState) {
          return VehicleAddSuccess(
            vehicleData: state.vehicle,
          );
        } else if (state is VehicleRouteAddedSate) {
          return const RouteAddedWidget();
        } else if (state is NoVehicleLoadedSate) {
          return Container(
            height: 200,
            color: AppColors.appMainColor,
            width: double.maxFinite,
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
