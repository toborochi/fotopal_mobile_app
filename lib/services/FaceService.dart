import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/models/face_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FaceService {
  static var client = http.Client();
  static AmplifyController amp = Get.find();

  static Future<FaceResponse> getFaces(String ev) async {
    var id = amp.userId;
    var url = '<YOUR API HERE>?usr_id=${id}&evn_id=${ev}';
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return FaceResponse.fromJson(jsonDecode(jsonString));
    } else {
      return null;
    }
  }
}
