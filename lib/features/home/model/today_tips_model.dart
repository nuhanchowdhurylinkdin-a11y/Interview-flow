// To parse this JSON data, do
//
//     final todayTipsModel = todayTipsModelFromJson(jsonString);

import 'dart:convert';

TodayTipsModel todayTipsModelFromJson(String str) => TodayTipsModel.fromJson(json.decode(str));

String todayTipsModelToJson(TodayTipsModel data) => json.encode(data.toJson());

class TodayTipsModel {
  bool success;
  String message;
  Data data;

  TodayTipsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TodayTipsModel.fromJson(Map<String, dynamic> json) => TodayTipsModel(
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
  String topic;
  String tip;

  Data({
    required this.topic,
    required this.tip,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    topic: json["topic"],
    tip: json["tips"],
  );

  Map<String, dynamic> toJson() => {
    "topic": topic,
    "tip": tip,
  };
}
