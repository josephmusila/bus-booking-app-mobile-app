import 'package:bus/config/urls.dart';
import 'package:bus/models/routeModel.dart';
import 'package:bus/models/saccoModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/tripModel.dart';
import '../models/vehiclesModel.dart';

class SaccoServices {
  Future<dynamic> addSacco(
      {required String saccoName,
      required String saccoDescription,
      required String saccoImage}) async {
    var response = await http.post(Uri.parse("${BaseUrls.baseUrl}sacco/"),
        body: {
          "name": saccoName,
          "description": saccoDescription,
          "image": saccoImage
        });
    return response.statusCode;
  }

  Future<List<SaccoModel>> getAllSaccoList() async {
    var response = await http.get(Uri.parse("${BaseUrls.baseUrl}sacco/"));
    return saccoModelFromJson(response.body);
  }

  Future<VehicleModel> addVehicle(
      {required String sacco,
      required String registration,
      required String image,
      required String capacity}) async {
    var response =
        await http.post(Uri.parse("${BaseUrls.baseUrl}vehicles/"), body: {
      "capacity": capacity,
      "routes": "2",
      "registration": registration,
      "image": image,
      "sacco": sacco
    });

    return singleVehicleModelFromJson(response.body);
  }

  Future<List<VehicleModel>> getAllVehicles(String id) async {
    var response =
        await http.get(Uri.parse("${BaseUrls.baseUrl}vehicles/?id=$id"));
    // print(response.body);
    return vehicleModelFromJson(response.body);
  }

  Future<int> addSaccoRoute(
      {required String saccoId,
      required String fare,
      required String routeDescription,
      required String startingPoint,
      required String destination}) async {
    int statusCode = 0;
    var response =
        await http.post(Uri.parse("${BaseUrls.baseUrl}routes/"), body: {
      "sacco": saccoId,
      "fare": fare,
      "description": routeDescription,
      "start": startingPoint,
      "destination": destination
    });
    // print(response.body);
    // return routeModelFromJson(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      RouteModel routeModel = routeModelFromJson(response.body);
      var saccoRes =
          await addRouteToSacco(saccoId: saccoId, routeId: routeModel.id);
      statusCode = saccoRes;
    } else {
      statusCode = response.statusCode;
    }

    return response.statusCode;
  }

  Future<dynamic> addRouteToSacco(
      {required String saccoId, required routeId}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PATCH', Uri.parse("${BaseUrls.baseUrl}/sacco/routes/$saccoId"));
    request.body = json.encode({"routes": routeId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  Future<dynamic> addRouteToVehicle(
      {required String vehicleId, required routeId}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PATCH', Uri.parse("${BaseUrls.baseUrl}/vehicle/routes/$vehicleId"));
    request.body = json.encode({"routes": routeId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

//trips

  Future<TripModel> addTrip({
    required String vehicleId,
    required String saccoId,
    required String routeId,
    required String pickUpPoint,
    required int vehicleCapacity,
  }) async {
    //   return TripModel
    List<Map> seats = [];
    for (var i = 0; i < vehicleCapacity; i++) {
      seats.add({
        // "trip":tripId,
        "seat_number": i + 1,
        "customer": 1,
      });
    }

    try {
      var headers = {'Content-Type': 'application/json'};
      var request =
          http.Request('POST', Uri.parse("${BaseUrls.baseUrl}trips/"));
      request.body = json.encode({
        "seats": seats,
        "vehicle": vehicleId,
        "sacco": saccoId,
        "routes": routeId,
        "pickuppoint": pickUpPoint
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      // print(response.stream.bytesToString());
      return singleTripModelFromJson(await response.stream.bytesToString());
    } on Exception catch (e) {
      rethrow;
      // TODO
    }
  }

  Future<List<TripModel>> getAllTrips() async {
    try {
      var response = await http.get(Uri.parse("${BaseUrls.baseUrl}trips/"));
      return tripModelFromJson(response.body);
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<TripModel> getSelectedTrip({required String tripId}) async {
    try {
      var response =
          await http.get(Uri.parse("${BaseUrls.baseUrl}trips/$tripId/"));
      return singleTripModelFromJson(response.body);
    } on Exception catch (e) {
      rethrow;
    }
  }

  // booking


}
