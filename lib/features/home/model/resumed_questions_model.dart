// To parse this JSON data, do
//
//     final resumedQuestionsModel = resumedQuestionsModelFromJson(jsonString);

import 'dart:convert';

ResumedQuestionsModel resumedQuestionsModelFromJson(String str) => ResumedQuestionsModel.fromJson(json.decode(str));

String resumedQuestionsModelToJson(ResumedQuestionsModel data) => json.encode(data.toJson());

class ResumedQuestionsModel {
  bool success;
  String message;
  Data data;

  ResumedQuestionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResumedQuestionsModel.fromJson(Map<String, dynamic> json) => ResumedQuestionsModel(
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
  bool hasResume;
  String sessionId;
  String type;
  String category;
  int answeredCount;
  int totalQuestions;
  String status;
  DateTime? updatedAt;

  Data({
    required this.hasResume,
    required this.sessionId,
    required this.type,
    required this.category,
    required this.answeredCount,
    required this.totalQuestions,
    required this.status,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    hasResume: json["hasResume"] ?? false,
    sessionId: json["sessionId"] ?? "",
    type: json["type"] ?? "",
    category: json["category"] ?? "",
    answeredCount: json["answeredCount"] ?? 0,
    totalQuestions: json["totalQuestions"] ?? 0,
    status: json["status"] ?? "",
    updatedAt: json["updatedAt"] != null ? DateTime.tryParse(json["updatedAt"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "hasResume": hasResume,
    "sessionId": sessionId,
    "type": type,
    "category": category,
    "answeredCount": answeredCount,
    "totalQuestions": totalQuestions,
    "status": status,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
