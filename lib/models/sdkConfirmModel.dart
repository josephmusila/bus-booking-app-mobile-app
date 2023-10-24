// To parse this JSON data, do
//
//     final sdkConfirmModel = sdkConfirmModelFromJson(jsonString);

import 'dart:convert';

SdkConfirmModel sdkConfirmModelFromJson(String str) => SdkConfirmModel.fromJson(json.decode(str));

String sdkConfirmModelToJson(SdkConfirmModel data) => json.encode(data.toJson());

class SdkConfirmModel {
  final String status;
  final int transactionId;

  SdkConfirmModel({
    required this.status,
    required this.transactionId,
  });

  factory SdkConfirmModel.fromJson(Map<String, dynamic> json) => SdkConfirmModel(
    status: json["status"],
    transactionId: json["transaction_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "transaction_id": transactionId,
  };
}
