import 'package:fotopal_beta/models/compra.dart';
import 'package:fotopal_beta/services/CompraService.dart';
import 'package:get/get.dart';

class CompraController extends GetxController {
  var compras = List<Compra>().obs;

  @override
  void onInit() {
    listarCompra();
    super.onInit();
  }

  Future<bool> crearCompra(data) async {
    var res = await CompraService.comprar(data);
    return res;
  }

  void listarCompra() async {
    var res = await CompraService.getCompras();
    print(res);
    compras.assignAll(res);
  }
}
