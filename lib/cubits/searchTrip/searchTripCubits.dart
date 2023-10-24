import 'package:bus/cubits/searchTrip/tripSearchStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/tripModel.dart';

class SearchTripCubits extends Cubit<SearchTripState> {


  SearchTripCubits() : super(SearchTripInitialState());

  void searchTrip(List<TripModel> trips, [String? from, String? to]) {
    emit(SearchTripLoadingState(message: "searching"));
    List<TripModel> searchedTrips = [];

    if (from != ""  && to != "") {
      trips.forEach((element) {
        if (element.routes.start.toLowerCase().contains(from?.toLowerCase() as Pattern) &&
            element.routes.destination.toLowerCase().contains(to?.toLowerCase() as Pattern)) {
          searchedTrips.add(element);
          emit(SearchTripSuccessState(searchedTrips: searchedTrips));
        }else{
          emit(NoMatchState(message: "No route matched From: $from To: $to" ));
        }
      });
    }else if(from != "" && to == ""){

      trips.forEach((element) {
        if(element.routes.start.toLowerCase().contains(from?.toLowerCase() as Pattern)){
          searchedTrips.add(element);
          emit(SearchTripSuccessState(searchedTrips: searchedTrips));
        }else{
          emit(NoMatchState(message: "No route matched $from"));
        }
      });
    }else if(to != "" && from == ""){
      trips.forEach((element) {
        if(element.routes.destination.toLowerCase().contains(to?.toLowerCase() as Pattern)){
          searchedTrips.add(element);
          emit(SearchTripSuccessState(searchedTrips: searchedTrips));
        }
        else{
          emit(NoMatchState(message: "No route matched $to"));
        }
      });
    }else if(from == "" && to == ""){
      searchedTrips=trips;
      emit(SearchTripSuccessState(searchedTrips: searchedTrips));
    }

    if (searchedTrips.isEmpty) {
      emit(NoMatchState(message: "No trips Matched\nStarting Point: $from\nTo:$to"));
    } else {
      emit(SearchTripSuccessState(searchedTrips: searchedTrips));
    }
  }

  void reloadSearchResults() {
    emit(SearchTripInitialState());
  }
}
