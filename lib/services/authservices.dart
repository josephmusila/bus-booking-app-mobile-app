import 'package:bus/models/loginErrorModel.dart';
import 'package:bus/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/urls.dart';

class AuthServices {
  Future<UserModel> registerUser({
    required String firtsName,
    required String lastName,
    required String email,
    required String password,
    required String phoneNumber,
    required String idNumber,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      var request = http.Request(
          'POST', Uri.parse('${BaseUrls.baseUrl}/auth/register/'));
      request.body = json.encode({
        "first_name": firtsName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "idnumber": idNumber,
        "phone": phoneNumber
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());
      return userModelFromJson(await response.stream.bytesToString());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> message = {"code": int, "data": dynamic};

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var response = await http.post(
          Uri.parse("${BaseUrls.baseUrl}/auth/login/"),
          body: {"email": email, "password": password});

      if (response.statusCode == 200) {
        UserModel user = userModelFromJson(response.body);
        message["code"] = 200;
        message["data"] = user;
      } else if (response.statusCode == 403) {
        LoginErrorModel error = loginErrorModelFromJson(response.body);
        message["code"] = 403;
        message["data"] = error;
      } else {
        // return response.body;
        message["code"] = response.statusCode;
        message["data"] = response.body;
      }
    } catch (e) {
      message["code"] = 0;
      message["data"] = e.toString();
    }

    return message;
  }

  Future<dynamic> updateProfile({
    required String idNumber,
    required String firstName,
    required String lastname,
    required String email,
    required String phone,
    required String password,
    required String id,
  }) async {
    var message = {"status_code": 0, "message": ""};
    try {
      var response = await http
          .put(Uri.parse("${BaseUrls.baseUrl}update_profile/$id/"), body: {
        "first_name": firstName,
        "last_name": lastname,
        "email": email,
        "phone": phone,
        "password": password,
        "idnumber": idNumber
      });

      if (response.statusCode == 200) {
        var message = {
          "status_code": response.statusCode,
          "message": "Account Updated Successfully"
        };
        return message;
      } else {
        var message = {
          "status_code": response.statusCode,
          // "message":EmailErrors.fromJson(json.decode(response.body))
        };
        return message;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
