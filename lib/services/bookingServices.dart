import 'package:bus/config/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/sdkConfirmModel.dart';
import '../models/tripModel.dart';

class BookingServices {
  Future<List<Seat>> bookSeat({required List<Seat> seats}) async {
    List<Map> selectedSeats = [];
    for (var i = 0; i < seats.length; i++) {
      selectedSeats.add(
        {
          "id": seats[i].id,
          "seat_number": seats[i].seatNumber,
          "isBooked": true,
          "customer": 1
        },
      );
    }
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('PUT', Uri.parse("${BaseUrls.baseUrl}seats/"));
      request.body = json.encode(selectedSeats);
      request.headers.addAll(headers);
      var response = await request.send();
      return seatModelFromJson(await response.stream.bytesToString());
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> initiatePayments(
      String phoneNumber, String amount) async {
    var message = {"code": 0, "data": dynamic};

    try {
      var res = await http.post(
          Uri.parse("${BaseUrls.baseUrl}/payments/submit/"),
          body: {"phone_number": phoneNumber, "amount": "1"});
      if (res.statusCode == 200) {
        print("STK Send to $phoneNumber");
        message["code"] = res.statusCode;
        message["data"] = sdkConfirmModelFromJson(res.body);
        return message;
        // return sdkConfirmModelFromJson(res.body);
      } else {
        message["code"] = res.statusCode;
        message["data"] = res.body;
        print(res.statusCode);
        print(res.body);
        return message;
      }
    } catch (e) {
      print(e.toString());
      message["code"] = 0;
      message["data"] = e.toString();
      return message;
    }
  }
}
