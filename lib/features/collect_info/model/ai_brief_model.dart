// To parse this JSON data, do
//
//     final aiBriefModel = aiBriefModelFromJson(jsonString);

import 'dart:convert';

AiBriefModel aiBriefModelFromJson(String str) => AiBriefModel.fromJson(json.decode(str));

String aiBriefModelToJson(AiBriefModel data) => json.encode(data.toJson());

class AiBriefModel {
  bool success;
  String message;
  Data data;

  AiBriefModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AiBriefModel.fromJson(Map<String, dynamic> json) => AiBriefModel(
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
  String userProfileId;
  AiData aiData;

  Data({
    required this.userProfileId,
    required this.aiData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userProfileId: json["userProfileId"],
    aiData: AiData.fromJson(json["aiData"]),
  );

  Map<String, dynamic> toJson() => {
    "userProfileId": userProfileId,
    "aiData": aiData.toJson(),
  };
}

class AiData {
  Roadmap roadmap;
  List<KeyFocusArea> keyFocusAreas;
  List<SampleQuestion> sampleQuestions;
  BenchmarkScore benchmarkScore;

  AiData({
    required this.roadmap,
    required this.keyFocusAreas,
    required this.sampleQuestions,
    required this.benchmarkScore,
  });

  factory AiData.fromJson(Map<String, dynamic> json) => AiData(
    roadmap: Roadmap.fromJson(json["roadmap"]),
    keyFocusAreas: List<KeyFocusArea>.from(json["key_focus_areas"].map((x) => KeyFocusArea.fromJson(x))),
    sampleQuestions: List<SampleQuestion>.from(json["sample_questions"].map((x) => SampleQuestion.fromJson(x))),
    benchmarkScore: BenchmarkScore.fromJson(json["benchmark_score"]),
  );

  Map<String, dynamic> toJson() => {
    "roadmap": roadmap.toJson(),
    "key_focus_areas": List<dynamic>.from(keyFocusAreas.map((x) => x.toJson())),
    "sample_questions": List<dynamic>.from(sampleQuestions.map((x) => x.toJson())),
    "benchmark_score": benchmarkScore.toJson(),
  };
}

class BenchmarkScore {
  double current;
  double target;
  int scale;

  BenchmarkScore({
    required this.current,
    required this.target,
    required this.scale,
  });

  factory BenchmarkScore.fromJson(Map<String, dynamic> json) => BenchmarkScore(
    current: json["current"]?.toDouble(),
    target: json["target"]?.toDouble(),
    scale: json["scale"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "target": target,
    "scale": scale,
  };
}

class KeyFocusArea {
  String area;
  double progress;

  KeyFocusArea({
    required this.area,
    required this.progress,
  });

  factory KeyFocusArea.fromJson(Map<String, dynamic> json) => KeyFocusArea(
    area: json["area"],
    progress: json["progress"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "area": area,
    "progress": progress,
  };
}

class Roadmap {
  RoadmapDuration duration;
  List<Plan> plan;

  Roadmap({
    required this.duration,
    required this.plan,
  });

  factory Roadmap.fromJson(Map<String, dynamic> json) => Roadmap(
    duration: RoadmapDuration.fromJson(json["duration"]),
    plan: List<Plan>.from(json["plan"].map((x) => Plan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "duration": duration.toJson(),
    "plan": List<dynamic>.from(plan.map((x) => x.toJson())),
  };
}

class RoadmapDuration {
  int value;
  String unit;

  RoadmapDuration({
    required this.value,
    required this.unit,
  });

  factory RoadmapDuration.fromJson(Map<String, dynamic> json) => RoadmapDuration(
    value: json["value"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "unit": unit,
  };
}

class Plan {
  int phase;
  String focus;

  Plan({
    required this.phase,
    required this.focus,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    phase: json["phase"],
    focus: json["focus"],
  );

  Map<String, dynamic> toJson() => {
    "phase": phase,
    "focus": focus,
  };
}

class SampleQuestion {
  String type;
  String text;

  SampleQuestion({
    required this.type,
    required this.text,
  });

  factory SampleQuestion.fromJson(Map<String, dynamic> json) => SampleQuestion(
    type: json["type"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "text": text,
  };
}
