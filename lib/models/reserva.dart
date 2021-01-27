import 'dart:convert';

List<Reserva> reservaFromJson(String str) =>
    List<Reserva>.from(json.decode(str).map((x) => Reserva.fromJson(x)));

String reservaToJson(List<Reserva> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reserva {
  Reserva(
      {this.fecha_reserva,
      this.latitud,
      this.duracion,
      this.fecha_cancelada,
      this.reserva_id,
      this.estado,
      this.fecha_aceptada,
      this.evento_id,
      this.comentarios,
      this.owner,
      this.fecha_evento,
      this.nombre_evento,
      this.estudio_id,
      this.fotografo_id,
      this.longitud,
      this.fecha_finalizada,
      this.nombre_lugar});

  final int fecha_reserva;
  final double latitud;
  final int duracion;
  final int fecha_cancelada;
  final String reserva_id;
  final String estado;
  final int fecha_aceptada;
  final String evento_id;
  final String comentarios;
  final String owner;
  final int fecha_evento;
  final String nombre_evento;
  final String estudio_id;
  final String fotografo_id;
  final double longitud;
  final int fecha_finalizada;
  final String nombre_lugar;

  factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
      fecha_reserva: json["fecha_reserva"],
      latitud: json["latitud"],
      duracion: json["duracion"],
      fecha_cancelada: json["fecha_cancelada"],
      reserva_id: json["reserva_id"],
      estado: json["estado"],
      fecha_aceptada: json["fecha_aceptada"],
      evento_id: json["evento_id"],
      comentarios: json["comentarios"],
      owner: json["owner"],
      fecha_evento: json["fecha_evento"],
      nombre_evento: json["nombre_evento"],
      estudio_id: json["estudio_id"],
      fotografo_id: json["fotografo_id"],
      longitud: json["longitud"],
      fecha_finalizada: json["fecha_finalizada"],
      nombre_lugar: json["nombre_lugar"]);

  Map<String, dynamic> toJson() => {
        "reserva_id": reserva_id,
        "latitud": latitud,
        "duracion": duracion,
        "fecha_cancelada": fecha_cancelada,
        "reserva_id": reserva_id,
        "estado": estado,
        "fecha_aceptada": fecha_aceptada,
        "evento_id": evento_id,
        "comentarios": comentarios,
        "owner": owner,
        "fecha_evento": fecha_evento,
        "nombre_evento": nombre_evento,
        "estudio_id": estudio_id,
        "fotografo_id": fotografo_id,
        "longitud": longitud,
        "fecha_finalizada": fecha_finalizada,
        "nombre_lugar": nombre_lugar
      };
}
