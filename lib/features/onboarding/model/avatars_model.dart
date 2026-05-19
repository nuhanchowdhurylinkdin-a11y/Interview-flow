// To parse this JSON data, do
//
//     final avatarsModel = avatarsModelFromJson(jsonString);

import 'dart:convert';

AvatarsModel avatarsModelFromJson(String str) => AvatarsModel.fromJson(json.decode(str));

String avatarsModelToJson(AvatarsModel data) => json.encode(data.toJson());

class AvatarsModel {
  bool success;
  String message;
  List<Datum> data;

  AvatarsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AvatarsModel.fromJson(Map<String, dynamic> json) => AvatarsModel(
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
  String fileName;
  String fileUrl;
  String mimeType;
  int fileSize;
  bool isDefault;
  DateTime uploadedAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.mimeType,
    required this.fileSize,
    required this.isDefault,
    required this.uploadedAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    fileName: json["fileName"],
    fileUrl: json["fileUrl"],
    mimeType: json["mimeType"],
    fileSize: json["fileSize"],
    isDefault: json["isDefault"],
    uploadedAt: DateTime.parse(json["uploadedAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fileName": fileName,
    "fileUrl": fileUrl,
    "mimeType": mimeType,
    "fileSize": fileSize,
    "isDefault": isDefault,
    "uploadedAt": uploadedAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
