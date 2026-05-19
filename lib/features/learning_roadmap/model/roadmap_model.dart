// To parse this JSON data, do
//
//     final roadmapModel = roadmapModelFromJson(jsonString);

import 'dart:convert';

RoadmapModel roadmapModelFromJson(String str) => RoadmapModel.fromJson(json.decode(str));

String roadmapModelToJson(RoadmapModel data) => json.encode(data.toJson());

class RoadmapModel {
  bool success;
  String message;
  Data data;

  RoadmapModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RoadmapModel.fromJson(Map<String, dynamic> json) => RoadmapModel(
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
  List<LearningArea> learningAreas;

  Data({
    required this.overallProgress,
    required this.learningAreas,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    overallProgress: json["overallProgress"],
    learningAreas: List<LearningArea>.from(json["learningAreas"].map((x) => LearningArea.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overallProgress": overallProgress,
    "learningAreas": List<dynamic>.from(learningAreas.map((x) => x.toJson())),
  };
}

class LearningArea {
  String id;
  String area;
  double progress;
  int progressPercentage;
  List<String> topics;
  DateTime createdAt;
  DateTime updatedAt;

  LearningArea({
    required this.id,
    required this.area,
    required this.progress,
    required this.progressPercentage,
    required this.topics,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LearningArea.fromJson(Map<String, dynamic> json) => LearningArea(
    id: json["id"],
    area: json["area"],
    progress: json["progress"],
    progressPercentage: json["progressPercentage"],
    topics: List<String>.from(json["topics"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "area": area,
    "progress": progress,
    "progressPercentage": progressPercentage,
    "topics": List<dynamic>.from(topics.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
