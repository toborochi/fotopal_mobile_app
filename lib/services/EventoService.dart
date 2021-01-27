import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/models/evento.dart';
import 'package:fotopal_beta/models/reserva.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EventoService {
  static var client = http.Client();
  static AmplifyController amp = Get.find();
  static Future<List<Evento>> fetchEventos() async {
    var id = amp.userId;
    var url = '<YOUR API HERE>?id=${id}';
    var response = await client.get(url);

    if (response.statusCode == 200) {
      print("EVENTOS OBTENIDOS");
      var jsonString = response.body;
      return eventoFromJson(jsonString);
    } else {
      return null;
    }
  }
}
