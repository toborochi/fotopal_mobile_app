import 'dart:convert';

import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/models/reserva.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ReservaService {
  static var client = http.Client();
  static AmplifyController amp = Get.find();

  static Future<List<Reserva>> fetchReservas() async {
    var id = amp.userId;
    var role = amp.rol;
    var estudio = amp.estudioId;

    print(id);
    print(role);
    print(estudio);

    var url = "";
    if (role == "regular") {
      url = '<YOUR API HERE>?tipo=regular&id=${id}';
    } else {
      url = '<YOUR API HERE>?tipo=fotografo&id=${id}&id_estudio=${estudio}';
    }

    var response = await client.get(url);

    if (response.statusCode == 200) {
      print("EVENTOS OBTENIDOS");
      var jsonString = response.body;
      return reservaFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<List<Reserva>> fetchAgenda() async {
    var id = amp.userId;
    var url = '<YOUR API HERE>?id=${id}';

    var response = await client.get(url);

    if (response.statusCode == 200) {
      print("EVENTOS OBTENIDOS");
      var jsonString = response.body;
      return reservaFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<bool> postUpdateRserva(Map data) async {
    var url = '<YOUR API HERE>';
    try {
      final res = await http.post(url,
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        print("RESERVA");
        return true;
      }
    } catch (e) {
      print(e);
      print("RESERVA NO");
      return false;
    }
  }

  static Future<bool> postReserva(Reserva reserva) async {
    var r;
    var url = '<YOUR API HERE>';
    try {
      print(reserva.toJson());
      final res = await http.post(url,
          body: jsonEncode(reserva.toJson()),
          headers: {"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        print("RESERVA");
        return true;
      }
    } catch (e) {
      print(e);
      print("RESERVA NO");
      return false;
    }
    return false;
  }
}
