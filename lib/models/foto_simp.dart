import 'dart:convert';

List<FotoSimp> fotoSimpFromJson(String str) =>
    List<FotoSimp>.from(json.decode(str).map((x) => FotoSimp.fromJson(x)));

String fotoSimpToJson(List<FotoSimp> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FotoSimp {
  final String foto_thumb;
  final String foto_id;
  final String foto_s3_key;

  FotoSimp({this.foto_id, this.foto_s3_key, this.foto_thumb});

  factory FotoSimp.fromJson(Map<String, dynamic> json) => FotoSimp(
        foto_id: json["foto_id"],
        foto_thumb: json["foto_thumb"],
        foto_s3_key: json["foto_s3_key"],
      );

  Map<String, dynamic> toJson() => {
        "foto_id": foto_id,
        "foto_thumb": foto_thumb,
        "foto_s3_key": foto_s3_key,
      };
}
