import 'package:fotopal_beta/models/estudio.dart';
import 'package:http/http.dart' as http;

class EstudioService {
  static var client = http.Client();

  static Future<List<Estudio>> fetchEstudios() async {
    var url = '<YOUR API HERE>';
    var response = await client.get(url);

    if (response.statusCode == 200) {
      print("ESTUDIOS OBTENIDOS");
      var jsonString = response.body;
      List<Estudio> l = (jsonString as List)
          .map((tagJson) => Estudio.fromJson(tagJson))
          .toList();
      return l;
    } else {
      return null;
    }
  }
}
