import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static var client = http.Client();
  static Future<String> fetchRoles(String user) async {
    var url = '<YOUR API HERE>';
    var response = await client.post(url,
        body: '{\n  \"usr\": \"${user}\"\n}',
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('ROL: ${data["custom:rol"]}');
      return data["custom:rol"];
    } else {
      return null;
    }
  }

  static Future<String> fetchID(String user) async {
    var url = '<YOUR API HERE>';
    var response = await client.post(url,
        body: '{\n  \"usr\": \"${user}\"\n}',
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('ROL: ${data["sub"]}');
      return data["sub"];
    } else {
      return null;
    }
  }

  static Future<String> fetchEstudio(String user) async {
    var url = '<YOUR API HERE>';
    var response = await client.post(url,
        body: '{\n  \"usr\": \"${user}\"\n}',
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('ROL: ${data["sub"]}');
      return data["custom:estudio"];
    } else {
      return null;
    }
  }
}
