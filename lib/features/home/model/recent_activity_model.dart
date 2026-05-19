// To parse this JSON data, do
//
//     final recentActivityModel = recentActivityModelFromJson(jsonString);

import 'dart:convert';

RecentActivityModel recentActivityModelFromJson(String str) => RecentActivityModel.fromJson(json.decode(str));

String recentActivityModelToJson(RecentActivityModel data) => json.encode(data.toJson());

class RecentActivityModel {
  bool success;
  String message;
  List<Datum> data;

  RecentActivityModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RecentActivityModel.fromJson(Map<String, dynamic> json) => RecentActivityModel(
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
  String title;
  String subtitle;
  dynamic score;
  String timeAgo;
  int answeredCount;
  int totalQuestions;

  Datum({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.score,
    required this.timeAgo,
    required this.answeredCount,
    required this.totalQuestions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    subtitle: json["subtitle"],
    score: json["score"],
    timeAgo: json["timeAgo"],
    answeredCount: json["answeredCount"],
    totalQuestions: json["totalQuestions"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
    "score": score,
    "timeAgo": timeAgo,
    "answeredCount": answeredCount,
    "totalQuestions": totalQuestions,
  };
}
