
import 'dart:convert';

RouteModel routeModelFromJson(String str) => RouteModel.fromJson(json.decode(str));

String routeModelToJson(RouteModel data) => json.encode(data.toJson());

class RouteModel {
  final int id;
  final String description;
  final String fare;
  final String start;
  final String destination;

  RouteModel({
    required this.id,
    required this.description,
    required this.fare,
    required this.start,
    required this.destination,
  });


  @override
  String toString() {
    return "$start -> $destination";
  }

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
    id: json["id"],
    description: json["description"],
    fare: json["fare"],
    start: json["start"],
    destination: json["destination"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "fare": fare,
    "start": start,
    "destination": destination,
  };
}
