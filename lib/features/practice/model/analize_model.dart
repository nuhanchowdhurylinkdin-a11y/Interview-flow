// To parse this JSON data, do
//
//     final analizeModel = analizeModelFromJson(jsonString);

import 'dart:convert';

AnalizeModel analizeModelFromJson(String str) => AnalizeModel.fromJson(json.decode(str));

String analizeModelToJson(AnalizeModel data) => json.encode(data.toJson());

class AnalizeModel {
  bool success;
  String message;
  Data data;

  AnalizeModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AnalizeModel.fromJson(Map<String, dynamic> json) => AnalizeModel(
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
  AiData aiData;

  Data({
    required this.aiData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    aiData: AiData.fromJson(json["aiData"]),
  );

  Map<String, dynamic> toJson() => {
    "aiData": aiData.toJson(),
  };
}

class AiData {
  OverallPerformance overallPerformance;
  List<DetailedFeedback> detailedFeedback;

  AiData({
    required this.overallPerformance,
    required this.detailedFeedback,
  });

  factory AiData.fromJson(Map<String, dynamic> json) => AiData(
    overallPerformance: OverallPerformance.fromJson(json["overall_performance"]),
    detailedFeedback: List<DetailedFeedback>.from(json["detailed_feedback"].map((x) => DetailedFeedback.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overall_performance": overallPerformance.toJson(),
    "detailed_feedback": List<dynamic>.from(detailedFeedback.map((x) => x.toJson())),
  };
}

class DetailedFeedback {
  String question;
  String answer;
  Overview overview;
  List<String> suggestions;
  SampleImprovedAnswer sampleImprovedAnswer;

  DetailedFeedback({
    required this.question,
    required this.answer,
    required this.overview,
    required this.suggestions,
    required this.sampleImprovedAnswer,
  });

  factory DetailedFeedback.fromJson(Map<String, dynamic> json) => DetailedFeedback(
    question: json["question"],
    answer: json["answer"],
    overview: Overview.fromJson(json["overview"]),
    suggestions: List<String>.from(json["suggestions"].map((x) => x)),
    sampleImprovedAnswer: SampleImprovedAnswer.fromJson(json["sample_improved_answer"]),
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "overview": overview.toJson(),
    "suggestions": List<dynamic>.from(suggestions.map((x) => x)),
    "sample_improved_answer": sampleImprovedAnswer.toJson(),
  };
}

class Overview {
  Clarity clarity;
  Clarity structure;
  Clarity confidence;

  Overview({
    required this.clarity,
    required this.structure,
    required this.confidence,
  });

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    clarity: Clarity.fromJson(json["clarity"]),
    structure: Clarity.fromJson(json["structure"]),
    confidence: Clarity.fromJson(json["confidence"]),
  );

  Map<String, dynamic> toJson() => {
    "clarity": clarity.toJson(),
    "structure": structure.toJson(),
    "confidence": confidence.toJson(),
  };
}

class Clarity {
  String rating;
  String explanation;

  Clarity({
    required this.rating,
    required this.explanation,
  });

  factory Clarity.fromJson(Map<String, dynamic> json) => Clarity(
    rating: json["rating"],
    explanation: json["explanation"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "explanation": explanation,
  };
}

class SampleImprovedAnswer {
  String situation;
  String task;
  String action;
  String result;

  SampleImprovedAnswer({
    required this.situation,
    required this.task,
    required this.action,
    required this.result,
  });

  factory SampleImprovedAnswer.fromJson(Map<String, dynamic> json) => SampleImprovedAnswer(
    situation: json["situation"],
    task: json["task"],
    action: json["action"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "situation": situation,
    "task": task,
    "action": action,
    "result": result,
  };
}

class OverallPerformance {
  int rating;
  List<String> strengths;
  List<String> areasToImprove;

  OverallPerformance({
    required this.rating,
    required this.strengths,
    required this.areasToImprove,
  });

  factory OverallPerformance.fromJson(Map<String, dynamic> json) => OverallPerformance(
    rating: json["rating"],
    strengths: List<String>.from(json["strengths"].map((x) => x)),
    areasToImprove: List<String>.from(json["areas_to_improve"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "strengths": List<dynamic>.from(strengths.map((x) => x)),
    "areas_to_improve": List<dynamic>.from(areasToImprove.map((x) => x)),
  };
}
