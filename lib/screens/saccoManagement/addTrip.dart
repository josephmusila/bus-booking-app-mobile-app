import 'package:bus/config/colors.dart';
import 'package:bus/cubits/sacco/tripStates.dart';
import 'package:bus/widgets/appCustomWidgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/sacco/saccoCubits.dart';
import '../../cubits/sacco/saccoStates.dart';
import '../../models/saccoModel.dart';
import '../../models/vehiclesModel.dart';
import '../../widgets/addTripWidgets/addNewTripWidget.dart';
import '../../widgets/addTripWidgets/addTripLoadingWidget.dart';
import '../../widgets/addTripWidgets/tripDataLoadedWidget.dart';


enum SelectedLayout {
  None,
  FourteenSeater,
  ThirtySixSeater,
}

class AddtripScreen extends StatefulWidget {
  List<VehicleModel> vehicles;
  SaccoModel sacco;

  AddtripScreen({required this.vehicles, required this.sacco});

  @override
  State<AddtripScreen> createState() => _AddtripScreenState();
}

class _AddtripScreenState extends State<AddtripScreen> {
  List<VehicleModel> saccoVehicles = [];
  SelectedLayout selectedLayout = SelectedLayout.None;
  late VehicleModel selectedVehicle;
  List<Routes> vehicleRoutes = [];
  bool vehicleHasRoutes = true;
  TextEditingController pickUpPointController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    saccoVehicles = widget.vehicles;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      appBar: AppBar(
        title:
            MediumTextWidget(data: "New Trip", color: AppColors.appMainColor),
      ),
      body: SafeArea(
        child: BlocBuilder<SaccoCubits, SaccoState>(builder: (context, state) {
          if (state is TripLoadingState) {
            return const AddTripLoadingWidget();
          } else if (state is TripLoadedState) {
            return TripDataLoadedWidget(tripData: state.tripModel,);
          } else {
            return AddNewTripWidget(sacco: widget.sacco,saccoVehicles: saccoVehicles,);
          }
        }),
      ),
    );
  }
}
