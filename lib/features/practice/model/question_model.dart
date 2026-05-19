// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
  bool success;
  String message;
  Data data;

  QuestionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
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
  String sessionId;
  AiData aiData;

  Data({
    required this.sessionId,
    required this.aiData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sessionId: json["sessionId"],
    aiData: AiData.fromJson(json["aiData"]),
  );

  Map<String, dynamic> toJson() => {
    "sessionId": sessionId,
    "aiData": aiData.toJson(),
  };
}

class AiData {
  List<PersonalizedQuestion> personalizedQuestions;

  AiData({
    required this.personalizedQuestions,
  });

  factory AiData.fromJson(Map<String, dynamic> json) => AiData(
    personalizedQuestions: List<PersonalizedQuestion>.from(json["personalized_questions"].map((x) => PersonalizedQuestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "personalized_questions": List<dynamic>.from(personalizedQuestions.map((x) => x.toJson())),
  };
}

class PersonalizedQuestion {
  String question;
  List<String> hints;

  PersonalizedQuestion({
    required this.question,
    required this.hints,
  });

  factory PersonalizedQuestion.fromJson(Map<String, dynamic> json) => PersonalizedQuestion(
    question: json["question"],
    hints: List<String>.from(json["hints"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "hints": List<dynamic>.from(hints.map((x) => x)),
  };
}
