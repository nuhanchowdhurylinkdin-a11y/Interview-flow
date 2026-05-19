import 'dart:convert';

// Use this if you have a raw String
LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

class LoginModel {
  bool success;
  String message;
  Data? data;

  LoginModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    // Guard against null 'data'
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  User user;
  bool isFirstTimer;
  String accessToken;
  String refreshToken;

  Data({
    required this.user,
    required this.isFirstTimer,
    required this.accessToken,
    required this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"] ?? {}),
    isFirstTimer: json["isFirstTimer"] ?? false,
    accessToken: json["accessToken"] ?? "",
    refreshToken: json["refreshToken"] ?? "",
  );
}

class User {
  String id;
  String email;
  String role;
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

  User({
    required this.id,
    required this.email,
    required this.role,
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
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? "",
    email: json["email"] ?? "",
    role: json["role"] ?? "USER",
    status: json["status"] ?? "",
    isEmailVerified: json["isEmailVerified"] ?? false,
    verificationCode: json["verificationCode"],
    // SAFELY parse dates that might be null
    verificationCodeExpiry: json["verificationCodeExpiry"] == null
        ? null
        : DateTime.tryParse(json["verificationCodeExpiry"].toString()),
    refreshToken: json["refreshToken"] ?? "",
    // SAFELY handle null list
    fcmTokens: json["fcmTokens"] == null ? [] : List<dynamic>.from(json["fcmTokens"]),
    profileId: json["profileId"] ?? "",
    lastActiveAt: json["lastActiveAt"] == null
        ? null
        : DateTime.tryParse(json["lastActiveAt"].toString()),
    // Use tryParse with a fallback to now() to avoid crashes
    createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
  );
}