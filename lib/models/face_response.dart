import 'dart:convert';

String faceToJson(List<FaceResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaceResponse {
  final String message;
  final String code;
  final String debug;

  FaceResponse(this.message, this.code, this.debug);

  factory FaceResponse.fromJson(dynamic json) {
    return FaceResponse(json['message'] as String, json['code'] as String,
        json['code'] as String);
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "debug": debug,
      };
}
