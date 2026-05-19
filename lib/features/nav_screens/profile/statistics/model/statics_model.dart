// To parse this JSON data, do
//
//     final statisticsModel = statisticsModelFromJson(jsonString);

import 'dart:convert';

StatisticsModel statisticsModelFromJson(String str) => StatisticsModel.fromJson(json.decode(str));

String statisticsModelToJson(StatisticsModel data) => json.encode(data.toJson());

class StatisticsModel {
  bool success;
  String message;
  Data data;

  StatisticsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) => StatisticsModel(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int overallProgress;
  int practiceSessionsCount;
  double avarageScore;

  Data({
    required this.overallProgress,
    required this.practiceSessionsCount,
    required this.avarageScore,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    overallProgress: json["overallProgress"],
    practiceSessionsCount: json["practiceSessionsCount"],
    avarageScore: json["avarageScore"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "overallProgress": overallProgress,
    "practiceSessionsCount": practiceSessionsCount,
    "avarageScore": avarageScore,
  };
}
