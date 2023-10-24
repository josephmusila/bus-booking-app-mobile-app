// To parse this JSON data, do
//
//     final tripModel = tripModelFromJson(jsonString);

import 'package:bus/models/routeModel.dart';
import 'package:bus/models/saccoModel.dart';
import 'package:bus/models/userModel.dart';
import 'package:bus/models/vehiclesModel.dart';
import 'dart:convert';

List<TripModel> tripModelFromJson(String str) => List<TripModel>.from(json.decode(str).map((x) => TripModel.fromJson(x)));
String tripModelToJson(List<TripModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

TripModel singleTripModelFromJson(String str) => TripModel.fromJson(json.decode(str));
String singleTripModelToJson(TripModel data) => json.encode(data.toJson());

List<Seat> seatModelFromJson(String str)=>List<Seat>.from(json.decode(str).map((x)=>Seat.fromJson(x)));






class TripModel {
  final int id;
  final VehicleModel vehicle;
  final RouteModel routes;
  final SaccoModel sacco;
  final List<Seat> seats;
  final DateTime date;
  final String pickuppoint;

  TripModel({
    required this.id,
    required this.vehicle,
    required this.routes,
    required this.sacco,
    required this.seats,
    required this.date,
    required this.pickuppoint,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
    id: json["id"],
    vehicle: VehicleModel.fromJson(json["vehicle"]),
    routes: RouteModel.fromJson(json["routes"]),
    sacco: SaccoModel.fromJson(json["sacco"]),
    seats: List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
    date: DateTime.parse(json["date"]),
    pickuppoint: json["pickuppoint"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vehicle": vehicle.toJson(),
    "routes": routes.toJson(),
    "sacco": sacco.toJson(),
    "seats": List<dynamic>.from(seats.map((x) => x.toJson())),
    "date": date.toIso8601String(),
    "pickuppoint": pickuppoint,
  };
}


class Seat {
   int id;
   int seatNumber;
   bool isBooked;
   UserModel customer;

  Seat( {
    required this.id,
    required this.seatNumber,
    required this.isBooked,
    required this.customer,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
    id: json["id"],
    seatNumber: json["seat_number"],
    isBooked: json["isBooked"],
    customer: UserModel.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "seat_number": seatNumber,
    "isBooked": isBooked,
    "customer": customer.toJson(),
  };
}

