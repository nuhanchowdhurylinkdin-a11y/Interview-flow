// To parse this JSON data, do
//
//     final progressModel = progressModelFromJson(jsonString);

import 'dart:convert';

ProgressModel progressModelFromJson(String str) => ProgressModel.fromJson(json.decode(str));

String progressModelToJson(ProgressModel data) => json.encode(data.toJson());

class ProgressModel {
  bool success;
  String message;
  Datam data;

  ProgressModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
    success: json["success"],
    message: json["message"],
    data: Datam.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Datam {
  double yourScore;
  double avgScore;
  int streak;

  Datam({
    required this.yourScore,
    required this.avgScore,
    required this.streak,
  });

  factory Datam.fromJson(Map<String, dynamic> json) => Datam(
    yourScore: (json["yourScore"] as num).toDouble(),
    avgScore: (json["avgScore"] as num).toDouble(),
    streak: (json["streak"] as num).toInt(),
  );

  Map<String, dynamic> toJson() => {
    "yourScore": yourScore,
    "avgScore": avgScore,
    "streak": streak,
  };
}
