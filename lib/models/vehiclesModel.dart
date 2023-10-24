import 'dart:convert';

List<VehicleModel> vehicleModelFromJson(String str) => List<VehicleModel>.from(
    json.decode(str).map((x) => VehicleModel.fromJson(x)));
VehicleModel singleVehicleModelFromJson(String str) =>
    VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(List<VehicleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
String singleVehicleModelToJson(VehicleModel data) =>
    json.encode(data.toJson());

class VehicleModel {
  int id;
  String capacity;
  // List<Routes> routes;
  String registration;
  String image;
  int sacco;

  @override
  String toString() {
    return registration;
  }

  VehicleModel({
    required this.id,
    required this.capacity,
    // required this.routes,
    required this.registration,
    required this.image,
    required this.sacco,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json["id"],
        capacity: json["capacity"],
        // routes: List<Routes>.from(json["routes"].map((x) => Routes.fromJson(x))),
        registration: json["registration"],
        image: json["image"],
        sacco: json["sacco"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "capacity": capacity,
        // "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "registration": registration,
        "image": image,
        "sacco": sacco,
      };
}
