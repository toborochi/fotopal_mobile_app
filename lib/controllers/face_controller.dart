import 'package:fotopal_beta/models/face_response.dart';
import 'package:fotopal_beta/models/foto_simp.dart';
import 'package:fotopal_beta/services/FaceService.dart';
import 'package:fotopal_beta/services/GaleriaService.dart';
import 'package:get/get.dart';

class FaceController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<FaceResponse> getFace(String ev) async {
    var pics = await FaceService.getFaces(ev);
    if (pics != null) {
      return pics;
    } else {
      return null;
    }
  }
}
