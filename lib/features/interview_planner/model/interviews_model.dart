// To parse this JSON data, do
//
//     final interviewsModel = interviewsModelFromJson(jsonString);

import 'dart:convert';

InterviewsModel interviewsModelFromJson(String str) => InterviewsModel.fromJson(json.decode(str));

String interviewsModelToJson(InterviewsModel data) => json.encode(data.toJson());

class InterviewsModel {
  bool success;
  String message;
  List<Datum> data;

  InterviewsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory InterviewsModel.fromJson(Map<String, dynamic> json) => InterviewsModel(
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
  String jobDescription;
  DateTime interviewDate;
  DateTime interviewTime;
  String interviewPhase;
  String note;
  String status;
  int preparationProgress;
  bool oneDayBeforeReminder;
  bool oneHourBeforeReminder;
  String userId;

  Datum({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.jobDescription,
    required this.interviewDate,
    required this.interviewTime,
    required this.interviewPhase,
    required this.note,
    required this.status,
    required this.preparationProgress,
    required this.oneDayBeforeReminder,
    required this.oneHourBeforeReminder,
    required this.userId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    companyName: json["companyName"],
    jobTitle: json["jobTitle"],
    jobDescription: json["jobDescription"],
    interviewDate: DateTime.parse(json["interviewDate"]),
    interviewTime: DateTime.parse(json["interviewTime"]),
    interviewPhase: json["interviewPhase"],
    note: json["note"],
    status: json["status"],
    preparationProgress: json["preparationProgress"],
    oneDayBeforeReminder: json["oneDayBeforeReminder"],
    oneHourBeforeReminder: json["oneHourBeforeReminder"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "companyName": companyName,
    "jobTitle": jobTitle,
    "jobDescription": jobDescription,
    "interviewDate": interviewDate.toIso8601String(),
    "interviewTime": interviewTime.toIso8601String(),
    "interviewPhase": interviewPhase,
    "note": note,
    "status": status,
    "preparationProgress": preparationProgress,
    "oneDayBeforeReminder": oneDayBeforeReminder,
    "oneHourBeforeReminder": oneHourBeforeReminder,
    "userId": userId,
  };
}
