// To parse this JSON data, do
//
//     final plannerHistoryModel = plannerHistoryModelFromJson(jsonString);

import 'dart:convert';

PlannerHistoryModel plannerHistoryModelFromJson(String str) => PlannerHistoryModel.fromJson(json.decode(str));

String plannerHistoryModelToJson(PlannerHistoryModel data) => json.encode(data.toJson());

class PlannerHistoryModel {
  bool success;
  String message;
  List<Datum> data;

  PlannerHistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PlannerHistoryModel.fromJson(Map<String, dynamic> json) => PlannerHistoryModel(
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String companyName;
  String jobTitle;
  String status;
  DateTime interviewDate;
  String interviewPhase;

  Datum({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.status,
    required this.interviewDate,
    required this.interviewPhase,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    companyName: json["companyName"],
    jobTitle: json["jobTitle"],
    status: json["status"],
    interviewDate: DateTime.parse(json["interviewDate"]),
    interviewPhase: json["interviewPhase"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "jobTitle": jobTitle,
    "status": status,
    "interviewDate": interviewDate.toIso8601String(),
    "interviewPhase": interviewPhase,
  };
}
