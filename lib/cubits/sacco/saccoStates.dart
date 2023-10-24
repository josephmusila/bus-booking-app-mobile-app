import 'package:bus/models/routeModel.dart';
import 'package:equatable/equatable.dart';

import '../../models/saccoModel.dart';
import '../../models/tripModel.dart';
import '../../models/vehiclesModel.dart';

abstract class SaccoState extends Equatable {}

class SaccoInitialSate extends SaccoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SaccoLoadingState extends SaccoState {
  String message;

  SaccoLoadingState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class SaccoLoadedState extends SaccoState {
  final List<RouteModel> allSaccoRoutes;
  final List<SaccoModel> saccoList;
  final List<TripModel> alltrips;

  SaccoLoadedState(
      {required this.saccoList,
      required this.alltrips,
      required this.allSaccoRoutes});

  @override
  // TODO: implement props
  List<Object?> get props => [saccoList, alltrips, allSaccoRoutes];
}

class SaccoVehicleLoadedState extends SaccoState {
  final List<VehicleModel> saccoVehicles;

  SaccoVehicleLoadedState({required this.saccoVehicles});

  @override
  // TODO: implement props
  List<Object?> get props => [saccoVehicles];
}

class NoSaccoLoadedSate extends SaccoState {
  String message;

  NoSaccoLoadedSate({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class SaccoLoadingErrorState extends SaccoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VehicleInitialSate extends SaccoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VehicleLoadingState extends SaccoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VehicleLoadedState extends SaccoState {
  final VehicleModel vehicle;

  VehicleLoadedState({required this.vehicle});

  @override
  // TODO: implement props
  List<Object?> get props => [vehicle];
}

class VehicleAddedSate extends SaccoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class VehicleRouteAddedSate extends SaccoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoVehicleLoadedSate extends SaccoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class SelectSaccoState extends SaccoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SelectRouteState extends SaccoState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
