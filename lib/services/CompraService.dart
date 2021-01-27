import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/models/compra.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompraService {
  static var client = http.Client();
  static AmplifyController amp = Get.find();

  static Future<bool> comprar(data) async {
    var url = '<YOUR API HERE>';
    try {
      final res = await http
          .post(url, body: data, headers: {"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
      print("RESERVA NO");
      return false;
    }
  }

  static Future<List<Compra>> getCompras() async {
    var id = amp.userId;
    var url = '<YOUR API HERE>${id}';
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      List<Compra> l = (jsonString as List)
          .map((tagJson) => Compra.fromJson(tagJson))
          .toList();
      return l;
    } else {
      return null;
    }
  }
}
