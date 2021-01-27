import 'package:fotopal_beta/models/estudio.dart';
import 'package:fotopal_beta/services/EstudioService.dart';
import 'package:get/get.dart';

class EstudioController extends GetxController {
  var estudio = List<Estudio>().obs;

  @override
  void onInit() {
    fetchEstudio();
    super.onInit();
  }

  void fetchEstudio() async {
    var res = await EstudioService.fetchEstudios();
    if (res != null) {
      estudio.assignAll(res);
    }
  }
}
