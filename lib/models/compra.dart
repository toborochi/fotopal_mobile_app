import 'dart:convert';

List<Compra> fotoSimpFromJson(String str) =>
    List<Compra>.from(json.decode(str).map((x) => Compra.fromJson(x)));

String fotoSimpToJson(List<Compra> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Compra {
  final String compra_id;
  final List<String> fotos;
  final String owner;

  Compra({this.compra_id, this.fotos, this.owner});

  factory Compra.fromJson(Map<String, dynamic> json) => Compra(
        compra_id: json["compra_id"],
        owner: json["owner"],
        fotos: jsonDecode(json["fotos"]),
      );

  Map<String, dynamic> toJson() => {
        "owner": owner,
        "fotos": fotos,
        "compra_id": compra_id,
      };
}
