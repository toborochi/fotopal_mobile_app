import 'package:fotopal_beta/models/foto_simp.dart';
import 'package:fotopal_beta/services/GaleriaService.dart';
import 'package:get/get.dart';

class GaleriaController extends GetxController {
  var fotos = List<FotoSimp>().obs;

  @override
  void onInit() {
    super.onInit();
    fetchGaleria();
  }

  void fetchGaleria() async {
    var pics = await GaleriaService.fetchFotos();
    if (pics != null) {
      fotos.assignAll(pics);
    }
  }

  Future<List<FotoSimp>> fetchGaleriaEvento(String evento) async {
    var pics = await GaleriaService.fetchFotosEvento(evento);
    print(pics);
    return pics;
  }
}
