// To parse this JSON data, do
//
//     final notificationSettingsModel = notificationSettingsModelFromJson(jsonString);

import 'dart:convert';

NotificationSettingsModel notificationSettingsModelFromJson(String str) => NotificationSettingsModel.fromJson(json.decode(str));

String notificationSettingsModelToJson(NotificationSettingsModel data) => json.encode(data.toJson());

class NotificationSettingsModel {
  bool success;
  String message;
  Data data;

  NotificationSettingsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) => NotificationSettingsModel(
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
  String id;
  bool practiceReminders;
  bool interviewReminders;
  bool weeklyProgressSummary;
  bool tipsAndRecommendations;
  String userProfileId;

  Data({
    required this.id,
    required this.practiceReminders,
    required this.interviewReminders,
    required this.weeklyProgressSummary,
    required this.tipsAndRecommendations,
    required this.userProfileId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    practiceReminders: json["practiceReminders"],
    interviewReminders: json["interviewReminders"],
    weeklyProgressSummary: json["weeklyProgressSummary"],
    tipsAndRecommendations: json["tipsAndRecommendations"],
    userProfileId: json["userProfileId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "practiceReminders": practiceReminders,
    "interviewReminders": interviewReminders,
    "weeklyProgressSummary": weeklyProgressSummary,
    "tipsAndRecommendations": tipsAndRecommendations,
    "userProfileId": userProfileId,
  };
}
