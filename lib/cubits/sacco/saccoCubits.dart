import 'dart:async';

import 'package:bus/cubits/sacco/saccoStates.dart';
import 'package:bus/cubits/searchTrip/tripSearchStates.dart';
import 'package:bus/cubits/sacco/tripStates.dart';
import 'package:bus/services/saccoServices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/routeModel.dart';
import '../../models/saccoModel.dart';
import '../../models/tripModel.dart';
import '../../models/vehiclesModel.dart';

class SaccoCubits extends Cubit<SaccoState> {
  SaccoServices saccoServices;

  SaccoCubits({required this.saccoServices}) : super(SaccoInitialSate());

  late List<SaccoModel> saccoList;
  List<VehicleModel> saccoVehicles = [];
  List<RouteModel> saccoRoutes = [];
  late VehicleModel singleVehicleModel;
  late List<RouteModel> allSaccoRoutes;
  List<RouteModel> singleSaccoRoutes = [];
  late List<TripModel> allTrips;
  late List<TripModel> tripForSelectedSacco;

  final StreamController<List<Seat>> seatStreamController =
      StreamController<List<Seat>>.broadcast();
  Stream<List<Seat>> get seatStream => seatStreamController.stream;

  final StreamController<double> totalFareController =
      StreamController<double>.broadcast();
  Stream<double> get totalFare => totalFareController.stream;

  // seats variables
  late Seat selectedSeat;
  List<Seat> listOfSeats = [];
  List<Seat> selectedSeats = [];

  List<Seat> myseats = [];

  late List<TripModel> trips;

  void loadMainPageData() async {
    emit(SaccoLoadingState(message: "Loading Data"));
    saccoList = await getAllSacco();
    allTrips = await getAllTrips();
    allSaccoRoutes = getAllSaccoRoutes();

    if (saccoList != null && allTrips != null && allSaccoRoutes != null) {
      trips=allTrips;
      emit(SaccoLoadedState(
          allSaccoRoutes: allSaccoRoutes,
          alltrips: allTrips,
          saccoList: saccoList));
    } else {
      emit(SaccoLoadingErrorState());
    }
  }

  void checkLoadedData() {
    print("Sacco Lis lenght is ${saccoList.length}");
    print("Trip Lis lenght is ${allTrips.length}");
    print("routes Lis lenght is ${allSaccoRoutes.length}");
  }

  Future<List<SaccoModel>> getAllSacco() async {
    saccoList = await saccoServices.getAllSaccoList();
    return saccoList;
  }

  void getSaccoVehicles(String id) async {
    emit(VehicleLoadingState());
    saccoVehicles = await saccoServices.getAllVehicles(id);
    if (saccoVehicles.isNotEmpty) {
      emit(SaccoVehicleLoadedState(saccoVehicles: saccoVehicles));
    } else {
      emit(NoVehicleLoadedSate());
    }
  }

  List<RouteModel> getAllSaccoRoutes() {
    List<RouteModel> allSaccoRoutes = [];
    for (var element in saccoList) {
      allSaccoRoutes.addAll(element.routes);
    }

    return allSaccoRoutes;
  }

  List<RouteModel> getSingleSaccoRoutes(int saccoId) {
    getAllSacco();
    for (var element in saccoList) {
      if (element.id == saccoId) {
        singleSaccoRoutes.addAll(element.routes);
      }
    }

    return singleSaccoRoutes;
  }
  // void getAllSaccoRoutes

  //vehicle Cubits

  void setVehicleInitialState() {
    emit(VehicleInitialSate());
  }

  void addVehicle(
      {required String sacco,
      required String registration,
      required String image,
      required String capacity}) async {
    emit(VehicleLoadingState());
    singleVehicleModel = await saccoServices.addVehicle(
      sacco: sacco,
      registration: registration,
      image: image,
      capacity: capacity,
    );
    if (singleVehicleModel != null) {
      emit(VehicleLoadedState(vehicle: singleVehicleModel));
    } else {
      emit(NoVehicleLoadedSate());
    }
  }

  addRouteToVehicle({required String vehicleId, required routeId}) async {
    emit(VehicleLoadingState());
    var res = await saccoServices.addRouteToVehicle(
        vehicleId: vehicleId, routeId: routeId);
    if (res == 200 || res == 201) {
      emit(VehicleLoadedState(vehicle: singleVehicleModel));
      emit(VehicleRouteAddedSate());
      // Future.delayed(const Duration(seconds: 2),(){
      // emit(VehicleLoadedState(vehicle: singleVehicleModel));
      // });

      // getAllSacco();
    } else {
      emit(NoVehicleLoadedSate());
    }

    return res;
    // print(res);
  }

// add trip cubits

  void addTrip({
    required String routeId,
    required String vehicleId,
    required String saccoId,
    required String pickUpPoint,
    required int numberofSeats,
  }) async {
    // emit(TripInitialSate());
    emit(TripLoadingState());
    try {
      var response = await saccoServices.addTrip(
          vehicleId: vehicleId,
          saccoId: saccoId,
          pickUpPoint: pickUpPoint,
          vehicleCapacity: numberofSeats,
          routeId: routeId);

      if (response.id != null) {
        emit(TripLoadedState(tripModel: response));
      } else {
        emit(TripLoadingErrorState(message: "some error occurred"));
      }
    } on Exception catch (e) {
      emit(TripLoadingErrorState(message: e.toString()));
      // TODO
    }
  }

//   get all trips

  Future<List<TripModel>> getAllTrips() async {
    allTrips = await saccoServices.getAllTrips();
    return allTrips;
  }

  void getTripForSelectedSacco(int Id) {
    allTrips.forEach((element) {
      if (element.id == Id) {
        tripForSelectedSacco.add(element);
      }
    });
  }

// getting selected Seat

  void getSelectedSeat(Seat seat) {
    selectedSeat = seat;
    listOfSeats.contains(seat)
        ? listOfSeats.remove(seat)
        : listOfSeats.add(seat);
    Set<Seat> seats = Set<Seat>.from(listOfSeats);
    List<Seat> uniqueSeats = seats.toList();
    listOfSeats = uniqueSeats;
    seatStreamController.sink.add(listOfSeats);

    // setSeats(listOfSeats);
  }

//   filtering trips

  List<TripModel> excludeFullTrips(List<TripModel> allTrips) {
    List<TripModel> trips = [];
    allTrips.forEach((element) {
      bool isEmpty = unBookedSeatsCount(element) == 0;
      if (!isEmpty) {
        trips.add(element);
      }
    });

    return trips;
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

//   naivgation cubits

  void goBackToHomeScreen() {
    emit(SaccoLoadedState(
        saccoList: saccoList,
        alltrips: allTrips,
        allSaccoRoutes: allSaccoRoutes));
  }
}
