import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  bool success;
  String message;
  Data? data;

  ProfileModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  String id;
  String email;
  String status;
  bool isEmailVerified;
  String? verificationCode;
  DateTime? verificationCodeExpiry;
  String refreshToken;
  List<dynamic> fcmTokens;
  String profileId;
  DateTime? lastActiveAt;
  DateTime createdAt;
  DateTime updatedAt;
  Profile? profile;

  Data({
    required this.id,
    required this.email,
    required this.status,
    required this.isEmailVerified,
    this.verificationCode,
    this.verificationCodeExpiry,
    required this.refreshToken,
    required this.fcmTokens,
    required this.profileId,
    this.lastActiveAt,
    required this.createdAt,
    required this.updatedAt,
    this.profile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] ?? "",
    email: json["email"] ?? "",
    status: json["status"] ?? "",
    isEmailVerified: json["isEmailVerified"] ?? false,
    verificationCode: json["verificationCode"],
    verificationCodeExpiry: json["verificationCodeExpiry"] == null
        ? null
        : DateTime.tryParse(json["verificationCodeExpiry"]),
    refreshToken: json["refreshToken"] ?? "",
    fcmTokens: json["fcmTokens"] == null ? [] : List<dynamic>.from(json["fcmTokens"]),
    profileId: json["profileId"] ?? "",
    lastActiveAt: json["lastActiveAt"] == null ? null : DateTime.tryParse(json["lastActiveAt"]),
    createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );
}

class Profile {
  String id;
  String fullName;
  String currentRole;
  List<String> targetRole;
  List<String> targetCompany;
  String experienceLevel;
  List<String> careerGoals;
  List<String> strengths;
  List<String> weakAreas;
  String jobDescription;
  List<String> resumeUrls;
  ProfilePlan? plan;
  String? profilePictureId;
  ProfilePicture? profilePicture;

  Profile({
    required this.id,
    required this.fullName,
    required this.currentRole,
    required this.targetRole,
    required this.targetCompany,
    required this.experienceLevel,
    required this.careerGoals,
    required this.strengths,
    required this.weakAreas,
    required this.jobDescription,
    required this.resumeUrls,
    this.plan,
    this.profilePictureId,
    this.profilePicture,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"] ?? "",
    fullName: json["fullName"] ?? "",
    currentRole: json["currentRole"] ?? "",
    targetRole: json["targetRole"] == null ? [] : (json["targetRole"] is List ? List<String>.from(json["targetRole"]) : [json["targetRole"].toString()]),
    targetCompany: json["targetCompany"] == null ? [] : List<String>.from(json["targetCompany"]),
    experienceLevel: json["experienceLevel"] ?? "",
    careerGoals: json["careerGoals"] == null ? [] : List<String>.from(json["careerGoals"]),
    strengths: json["strengths"] == null ? [] : List<String>.from(json["strengths"]),
    weakAreas: json["weakAreas"] == null ? [] : List<String>.from(json["weakAreas"]),
    jobDescription: json["jobDescription"] ?? "",
    resumeUrls: json["resumeUrls"] == null ? [] : List<String>.from(json["resumeUrls"]),
    plan: json["plan"] == null ? null : ProfilePlan.fromJson(json["plan"]),
    profilePictureId: json["profilePictureId"],
    profilePicture: json["profilePicture"] == null ? null : ProfilePicture.fromJson(json["profilePicture"]),
  );
}

class ProfilePlan {
  Roadmap? roadmap;
  BenchmarkScore? benchmarkScore;
  List<KeyFocusArea> keyFocusAreas;
  List<SampleQuestion> sampleQuestions;

  ProfilePlan({
    this.roadmap,
    this.benchmarkScore,
    required this.keyFocusAreas,
    required this.sampleQuestions,
  });

  factory ProfilePlan.fromJson(Map<String, dynamic> json) => ProfilePlan(
    roadmap: json["roadmap"] == null ? null : Roadmap.fromJson(json["roadmap"]),
    benchmarkScore: json["benchmark_score"] == null ? null : BenchmarkScore.fromJson(json["benchmark_score"]),
    keyFocusAreas: json["key_focus_areas"] == null
        ? []
        : List<KeyFocusArea>.from(json["key_focus_areas"].map((x) => KeyFocusArea.fromJson(x))),
    sampleQuestions: json["sample_questions"] == null
        ? []
        : List<SampleQuestion>.from(json["sample_questions"].map((x) => SampleQuestion.fromJson(x))),
  );
}

class BenchmarkScore {
  int scale;
  double target;
  double current;

  BenchmarkScore({required this.scale, required this.target, required this.current});

  factory BenchmarkScore.fromJson(Map<String, dynamic> json) => BenchmarkScore(
    scale: json["scale"] ?? 0,
    target: (json["target"] ?? 0.0).toDouble(),
    current: (json["current"] ?? 0.0).toDouble(),
  );
}

class Roadmap {
  List<PlanElement> plan;
  RoadmapDuration? duration;

  Roadmap({required this.plan, this.duration});

  factory Roadmap.fromJson(Map<String, dynamic> json) => Roadmap(
    plan: json["plan"] == null ? [] : List<PlanElement>.from(json["plan"].map((x) => PlanElement.fromJson(x))),
    duration: json["duration"] == null ? null : RoadmapDuration.fromJson(json["duration"]),
  );
}

class RoadmapDuration {
  String unit;
  int value;

  RoadmapDuration({required this.unit, required this.value});

  factory RoadmapDuration.fromJson(Map<String, dynamic> json) => RoadmapDuration(
    unit: json["unit"] ?? "",
    value: json["value"] ?? 0,
  );
}

class PlanElement {
  String focus;
  int phase;
  String category;
  double progress;
  String timeframe;

  PlanElement({
    required this.focus,
    required this.phase,
    required this.category,
    required this.progress,
    required this.timeframe,
  });

  factory PlanElement.fromJson(Map<String, dynamic> json) => PlanElement(
    focus: json["focus"] ?? "",
    phase: json["phase"] ?? 0,
    category: json["category"] ?? "",
    progress: (json["progress"] ?? 0.0).toDouble(),
    timeframe: json["timeframe"] ?? "",
  );
}

class KeyFocusArea {
  String area;
  String category;
  double progress;

  KeyFocusArea({required this.area, required this.category, required this.progress});

  factory KeyFocusArea.fromJson(Map<String, dynamic> json) => KeyFocusArea(
    area: json["area"] ?? "",
    category: json["category"] ?? "",
    progress: (json["progress"] ?? 0.0).toDouble(),
  );
}

class SampleQuestion {
  String text;
  String type;

  SampleQuestion({required this.text, required this.type});

  factory SampleQuestion.fromJson(Map<String, dynamic> json) => SampleQuestion(
    text: json["text"] ?? "",
    type: json["type"] ?? "",
  );
}

class ProfilePicture {
  String id;
  String fileName;
  String fileUrl;
  String mimeType;
  int fileSize;
  bool isDefault;
  DateTime uploadedAt;

  ProfilePicture({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.mimeType,
    required this.fileSize,
    required this.isDefault,
    required this.uploadedAt,
  });

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => ProfilePicture(
    id: json["id"] ?? "",
    fileName: json["fileName"] ?? "",
    fileUrl: json["fileUrl"] ?? "",
    mimeType: json["mimeType"] ?? "",
    fileSize: json["fileSize"] ?? 0,
    isDefault: json["isDefault"] ?? false,
    uploadedAt: DateTime.tryParse(json["uploadedAt"] ?? "") ?? DateTime.now(),
  );
}