import 'dart:convert';
import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/models/foto_simp.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GaleriaService {
  static var client = http.Client();
  static AmplifyController amp = Get.find();

  static Future<List<FotoSimp>> fetchFotos() async {
    var id = amp.userId;
    var url = '<YOUR API HERE>?id=${id}';
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var tagObjsJson = jsonDecode(response.body) as List;
      List<FotoSimp> fotos =
          tagObjsJson.map((tagJson) => FotoSimp.fromJson(tagJson)).toList();
      print('Fotos ${fotos.length}');
      return fotos;
    } else {
      return null;
    }
  }

  static Future<List<FotoSimp>> fetchFotosEvento(String evento) async {
    var url = '<YOUR API HERE>?id=${evento}';
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var tagObjsJson = jsonDecode(response.body) as List;
      List<FotoSimp> fotos =
          tagObjsJson.map((tagJson) => FotoSimp.fromJson(tagJson)).toList();
      print('Fotos ${fotos.length}');
      return fotos;
    } else {
      return null;
    }
  }
}
