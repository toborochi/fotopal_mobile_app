import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/fontelico_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/controllers/reserva_controller.dart';
import 'package:fotopal_beta/views/agenda_foto.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:fotopal_beta/views/mis_eventos_foto.dart';
import 'package:get/get.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePageFotografo extends StatefulWidget {
  @override
  _HomePageFotografoState createState() => _HomePageFotografoState();
}

class _HomePageFotografoState extends State<HomePageFotografo> {
  var reservaController = Get.put(ReservaController());
  AmplifyController amp = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      content: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Escanear QR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              Container(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                child: FittedBox(
                  child: CircularGradientButton(
                    child: Icon(
                      FontAwesome5.qrcode,
                      size: MediaQuery.of(context).size.width * 0.075,
                    ),
                    callback: () async {
                      String barcodeScanRes =
                          await FlutterBarcodeScanner.scanBarcode(
                              "#ff6666", "CANCELAR", true, ScanMode.QR);

                      print(barcodeScanRes);
                      Map myJSON = {
                        "id": barcodeScanRes,
                        "estado": "PROCESANDO",
                        "fotografo_id": amp.userId
                      };
                      bool resultado =
                          await reservaController.updateReserva(myJSON);
                      if (resultado) {
                        Get.defaultDialog(
                            title: "PROCESANDO", content: Icon(Icons.message));
                      }
                      print("CODIGO QR: " + barcodeScanRes);
                    },
                    gradient: Gradients.cosmicFusion,
                    shadowColor:
                        Gradients.deepSpace.colors.last.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                height: 20,
              )
            ],
          ),
        ),
        SliverGrid.count(crossAxisCount: 2, children: [
          _button(
              Icon(
                Typicons.location,
                color: Colors.white,
                size: 60,
              ),
              "Eventos",
              MisEventosFoto()),
          _button(
              Icon(
                Elusive.calendar,
                color: Colors.white,
                size: 60,
              ),
              "Agenda",
              AgendaFoto())
        ])
      ]),
    );
  }

  Widget _button(Icon i, String txt, Widget w) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FlatButton(
        color: Colors.black.withOpacity(0.33),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            i,
            Text(
              txt,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        onPressed: () => {Get.to(w)},
      ),
    );
  }
}
