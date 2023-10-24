import 'dart:convert';

import 'package:bus/models/routeModel.dart';

List<SaccoModel> saccoModelFromJson(String str) =>
    List<SaccoModel>.from(json.decode(str).map((x) => SaccoModel.fromJson(x)));

String saccoModelToJson(List<SaccoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SaccoModel {
  int id;
  String name;
  String description;
  List<RouteModel> routes;

  @override
  String toString() {
    return name;
  }

  SaccoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.routes,
  });

  factory SaccoModel.fromJson(Map<String, dynamic> json) => SaccoModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        routes: List<RouteModel>.from(
            json["routes"].map((x) => RouteModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
      };
}

class Routes {
  int id;
  String routes;
  String fare;

  @override
  String toString() {
    return routes;
  }

  Routes({
    required this.id,
    required this.routes,
    required this.fare,
  });

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
        id: json["id"],
        routes: json["routes"],
        fare: json["fare"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "routes": routes,
        "fare": fare,
      };
}
