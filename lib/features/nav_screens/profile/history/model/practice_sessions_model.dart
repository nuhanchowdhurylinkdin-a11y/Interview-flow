// To parse this JSON data, do
//
//     final practiceSessionsModel = practiceSessionsModelFromJson(jsonString);

import 'dart:convert';

PracticeSessionsModel practiceSessionsModelFromJson(String str) => PracticeSessionsModel.fromJson(json.decode(str));

String practiceSessionsModelToJson(PracticeSessionsModel data) => json.encode(data.toJson());

class PracticeSessionsModel {
  bool success;
  String message;
  List<Datum> data;

  PracticeSessionsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PracticeSessionsModel.fromJson(Map<String, dynamic> json) => PracticeSessionsModel(
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
  Type type;
  Category category;
  int? overallScore;
  DateTime updatedAt;
  List<Question> questions;

  Datum({
    required this.id,
    required this.type,
    required this.category,
    required this.overallScore,
    required this.updatedAt,
    required this.questions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: typeValues.map[json["type"]]!,
    category: categoryValues.map[json["category"]]!,
    overallScore: json["overallScore"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
    "category": categoryValues.reverse[category],
    "overallScore": overallScore,
    "updatedAt": updatedAt.toIso8601String(),
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

enum Category {
  NON_TECHNICAL_BEHAVIORAL,
  TECHNICAL_BEHAVIORAL,
  TECHNICAL_CASE_STUDY,
  TECHNICAL_HIRING_MANAGER,
  TECHNICAL_QUESTIONS,
  TECHNICAL_SYSTEM_DESIGN
}

final categoryValues = EnumValues({
  "non_technical_behavioral": Category.NON_TECHNICAL_BEHAVIORAL,
  "technical_behavioral": Category.TECHNICAL_BEHAVIORAL,
  "technical_case_study": Category.TECHNICAL_CASE_STUDY,
  "technical_hiring_manager": Category.TECHNICAL_HIRING_MANAGER,
  "technical_questions": Category.TECHNICAL_QUESTIONS,
  "technical_system_design": Category.TECHNICAL_SYSTEM_DESIGN
});

class Question {
  String id;
  String sessionId;
  int order;
  String question;
  List<String> hints;
  String? answer;
  Feedback? feedback;
  double? score;
  DateTime createdAt;
  DateTime updatedAt;

  Question({
    required this.id,
    required this.sessionId,
    required this.order,
    required this.question,
    required this.hints,
    required this.answer,
    required this.feedback,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    sessionId: json["sessionId"],
    order: json["order"],
    question: json["question"],
    hints: List<String>.from(json["hints"].map((x) => x)),
    answer: json["answer"],
    feedback: json["feedback"] == null ? null : Feedback.fromJson(json["feedback"]),
    score: json["score"]?.toDouble(),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sessionId": sessionId,
    "order": order,
    "question": question,
    "hints": List<dynamic>.from(hints.map((x) => x)),
    "answer": answer,
    "feedback": feedback?.toJson(),
    "score": score,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Feedback {
  String answer;
  Overview overview;
  String question;
  List<String> suggestions;
  SampleImprovedAnswer sampleImprovedAnswer;

  Feedback({
    required this.answer,
    required this.overview,
    required this.question,
    required this.suggestions,
    required this.sampleImprovedAnswer,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
    answer: json["answer"],
    overview: Overview.fromJson(json["overview"]),
    question: json["question"],
    suggestions: List<String>.from(json["suggestions"].map((x) => x)),
    sampleImprovedAnswer: SampleImprovedAnswer.fromJson(json["sample_improved_answer"]),
  );

  Map<String, dynamic> toJson() => {
    "answer": answer,
    "overview": overview.toJson(),
    "question": question,
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
  Rating rating;
  String explanation;

  Clarity({
    required this.rating,
    required this.explanation,
  });

  factory Clarity.fromJson(Map<String, dynamic> json) => Clarity(
    rating: ratingValues.map[json["rating"]]!,
    explanation: json["explanation"],
  );

  Map<String, dynamic> toJson() => {
    "rating": ratingValues.reverse[rating],
    "explanation": explanation,
  };
}

enum Rating {
  THE_15,
  THE_25,
  THE_35,
  THE_45
}

final ratingValues = EnumValues({
  "1/5": Rating.THE_15,
  "2/5": Rating.THE_25,
  "3/5": Rating.THE_35,
  "4/5": Rating.THE_45
});

class SampleImprovedAnswer {
  String task;
  String action;
  String result;
  String situation;

  SampleImprovedAnswer({
    required this.task,
    required this.action,
    required this.result,
    required this.situation,
  });

  factory SampleImprovedAnswer.fromJson(Map<String, dynamic> json) => SampleImprovedAnswer(
    task: json["task"],
    action: json["action"],
    result: json["result"],
    situation: json["situation"],
  );

  Map<String, dynamic> toJson() => {
    "task": task,
    "action": action,
    "result": result,
    "situation": situation,
  };
}

enum Type {
  BEHAVIORAL,
  TECHNICAL
}

final typeValues = EnumValues({
  "behavioral": Type.BEHAVIORAL,
  "technical": Type.TECHNICAL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
