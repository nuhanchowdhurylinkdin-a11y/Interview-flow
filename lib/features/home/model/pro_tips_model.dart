// To parse this JSON data, do
//
//     final proTipsModel = proTipsModelFromJson(jsonString);

import 'dart:convert';

ProTipsModel proTipsModelFromJson(String str) => ProTipsModel.fromJson(json.decode(str));

String proTipsModelToJson(ProTipsModel data) => json.encode(data.toJson());

class ProTipsModel {
  bool success;
  String message;
  Data data;

  ProTipsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProTipsModel.fromJson(Map<String, dynamic> json) => ProTipsModel(
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
  List<String> interviewPreparation;
  List<String> duringTheInterview;
  List<String> technicalInterviews;
  List<String> bodyLanguagePresence;
  List<String> behavioralQuestions;
  List<String> virtualInterviews;
  List<String> salaryNegotiation;
  List<String> followUpThankYou;
  List<String> commonMistakesToAvoid;

  Data({
    required this.interviewPreparation,
    required this.duringTheInterview,
    required this.technicalInterviews,
    required this.bodyLanguagePresence,
    required this.behavioralQuestions,
    required this.virtualInterviews,
    required this.salaryNegotiation,
    required this.followUpThankYou,
    required this.commonMistakesToAvoid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    interviewPreparation: List<String>.from((json["Interview Preparation"] ?? []).map((x) => x)),
    duringTheInterview: List<String>.from((json["During the interview"] ?? []).map((x) => x)),
    technicalInterviews: List<String>.from((json["Technical Interviews"] ?? []).map((x) => x)),
    bodyLanguagePresence: List<String>.from((json["Body Language & Presence"] ?? []).map((x) => x)),
    behavioralQuestions: List<String>.from((json["Behavioral Questions"] ?? []).map((x) => x)),
    virtualInterviews: List<String>.from((json["Virtual Interviews"] ?? []).map((x) => x)),
    salaryNegotiation: List<String>.from((json["Salary Negotiation"] ?? []).map((x) => x)),
    followUpThankYou: List<String>.from((json["Follow-Up & Thank You"] ?? []).map((x) => x)),
    commonMistakesToAvoid: List<String>.from((json["Common Mistakes to Avoid"] ?? []).map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Interview Preparation": List<dynamic>.from(interviewPreparation.map((x) => x)),
    "During the interview": List<dynamic>.from(duringTheInterview.map((x) => x)),
    "Technical Interviews": List<dynamic>.from(technicalInterviews.map((x) => x)),
    "Body Language & Presence": List<dynamic>.from(bodyLanguagePresence.map((x) => x)),
    "Behavioral Questions": List<dynamic>.from(behavioralQuestions.map((x) => x)),
    "Virtual Interviews": List<dynamic>.from(virtualInterviews.map((x) => x)),
    "Salary Negotiation": List<dynamic>.from(salaryNegotiation.map((x) => x)),
    "Follow-Up & Thank You": List<dynamic>.from(followUpThankYou.map((x) => x)),
    "Common Mistakes to Avoid": List<dynamic>.from(commonMistakesToAvoid.map((x) => x)),
  };
}
