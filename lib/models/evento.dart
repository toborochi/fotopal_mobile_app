import 'dart:convert';

import 'package:fotopal_beta/models/foto_simp.dart';

List<Evento> eventoFromJson(String str) =>
    List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));

String eventoToJson(List<Evento> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Evento {
  final String evento_id;
  final String nombre_evento;
  final List<FotoSimp> fotos;
  Evento({this.evento_id, this.nombre_evento, this.fotos});

  factory Evento.fromJson(Map<String, dynamic> data) => Evento(
      evento_id: data["evento_id"],
      nombre_evento: data["nombre_evento"],
      fotos: (data['fotos'] as List)
          .map((tagJson) => FotoSimp.fromJson(tagJson))
          .toList());

  Map<String, dynamic> toJson() => {
        "evento_id": evento_id,
        "nombre_evento": nombre_evento,
        "fotos": fotos,
      };
}
