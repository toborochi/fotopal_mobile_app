import 'dart:convert';

List<Estudio> estudioFromJson(String str) =>
    List<Estudio>.from(json.decode(str).map((x) => Estudio.fromJson(x)));

String estudioToJson(List<Estudio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Estudio {
  final String estudio_id;
  final String nombre_estudio;

  Estudio({this.estudio_id, this.nombre_estudio});

  factory Estudio.fromJson(Map<String, dynamic> json) => Estudio(
      estudio_id: json["estudio_id"], nombre_estudio: json["nombre_estudio"]);

  Map<String, dynamic> toJson() =>
      {"estudio_id": estudio_id, "nombre_estudio": nombre_estudio};
}
