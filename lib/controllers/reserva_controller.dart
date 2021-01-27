import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/models/reserva.dart';
import 'package:fotopal_beta/services/ReservaService.dart';
import 'package:get/get.dart';

class ReservaController extends GetxController {
  var reservas = List<Reserva>().obs;
  var galeria = List<Reserva>().obs;
  AmplifyController amp = Get.find();

  @override
  void onInit() {
    fetchReserva();
    if (amp.rol == "fotografo") {
      fetchGaleria();
    }
    super.onInit();
  }

  void fetchReserva() async {
    var res = await ReservaService.fetchReservas();
    if (res != null) {
      reservas.assignAll(res);
    } else {
      reservas.assignAll(new List<Reserva>());
    }
  }

  void fetchGaleria() async {
    var res = await ReservaService.fetchAgenda();
    if (res != null) {
      galeria.assignAll(res);
    } else {
      galeria.assignAll(new List<Reserva>());
    }
  }

  Future<bool> saveReserva(Reserva reserva) async {
    var r = await ReservaService.postReserva(reserva);
    return r;
  }

  Future<bool> updateReserva(Map reserva) async {
    var r = await ReservaService.postUpdateRserva(reserva);
    return r;
  }
}
