
import 'dart:convert';

UserModel userModelFromJson(String str)=>UserModel.fromJson(json.decode(str));

class UserModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String idNumber;
  bool isSuperUser;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.idNumber,
    required this.isSuperUser,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        idNumber: json["idnumber"],
        isSuperUser: json["is_superuser"],
      );

  Map<String,dynamic> toJson()=>{
    "id":id,
    "fist_name":firstName,
    "lst_name":lastName,
    "email":email,
    "phone":phone,
    "idnumber":idNumber,
    "is_superuser":isSuperUser,


  };
}
