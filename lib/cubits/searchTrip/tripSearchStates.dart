

import 'package:bus/cubits/sacco/saccoStates.dart';
import 'package:equatable/equatable.dart';

import '../../models/tripModel.dart';

abstract class SearchTripState extends Equatable{}

class SearchTripInitialState extends SearchTripState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class SearchTripLoadingState extends SearchTripState{
  String message;

  SearchTripLoadingState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}

class SearchTripSuccessState extends SearchTripState{
  List<TripModel> searchedTrips;

  SearchTripSuccessState({required this.searchedTrips});
  @override
  // TODO: implement props
  List<Object?> get props => [searchedTrips];

}

class NoMatchState extends SearchTripState{
  String message;

  NoMatchState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}