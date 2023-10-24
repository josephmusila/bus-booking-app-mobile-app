
import 'package:bus/cubits/sacco/saccoStates.dart';

import '../../models/tripModel.dart';



class TripInitialSate extends SaccoState{
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

class TripLoadingState extends SaccoState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TripLoadedState extends SaccoState{
  final TripModel tripModel;

  TripLoadedState({required this.tripModel});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class TripVehicleAddedSate extends SaccoState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TripLoadingErrorState extends SaccoState{
  String message;

  TripLoadingErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];


}

//
// class VehicleRouteAddedSate extends SaccoState{
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
// class NoVehicleLoadedSate extends SaccoState{
//   @override
//   // TODO: implement props
//   List<Object?> get props => [];
// }
