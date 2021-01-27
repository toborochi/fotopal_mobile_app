import 'package:fotopal_beta/models/evento.dart';
import 'package:fotopal_beta/services/EventoService.dart';
import 'package:get/get.dart';

class EventoController extends GetxController {
  var eventos = List<Evento>().obs;

  @override
  void onInit() {
    super.onInit();
    fetchAsist();
  }

  void fetchAsist() async {
    var res = await EventoService.fetchEventos();
    if (res != null) {
      eventos.assignAll(res);
    }
  }
}
