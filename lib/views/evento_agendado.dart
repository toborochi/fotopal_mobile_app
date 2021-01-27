import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/controllers/galeria_controller.dart';
import 'package:fotopal_beta/controllers/reserva_controller.dart';
import 'package:fotopal_beta/models/reserva.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:fotopal_beta/views/galeria_evento.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventoAgendado extends StatefulWidget {
  @override
  _EventoAgendadoState createState() => _EventoAgendadoState();
}

class _EventoAgendadoState extends State<EventoAgendado> {
  Reserva data = Get.arguments;
  var galeriaController = Get.put(GaleriaController());
  AmplifyController amp = Get.find();
  ReservaController res = Get.find();

  @override
  Widget build(BuildContext context) {
    print(data.nombre_evento);

    return AppScaffold(
        content: Container(
            child: Form(
                child: ListView(
      padding: EdgeInsets.all(20),
      shrinkWrap: false,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              child: Text(
                "Evento Agendado",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        Divider(),
        Row(
          children: [
            Text(
              "Evento: ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              data.nombre_evento,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Fecha: ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              fecha(data.fecha_evento),
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Comentarios: ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Flexible(
              child: Text(
                data.comentarios,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Estado: ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Flexible(
              child: Text(
                data.estado,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Lugar: ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Flexible(
              child: Text(
                formateado(data.nombre_lugar),
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
        Divider(),
        (amp.rol == "regular")
            ? Center(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(4),
                  child: QrImage(
                    data: data.reserva_id,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              )
            : ButtonTheme(
                height: 48.0,
                child: RaisedButton(
                    color: Color(0xfff97fe3),
                    child: Text("Aceptar",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    onPressed: () async {
                      print(data.reserva_id);
                      Map myJSON = {
                        "id": data.reserva_id,
                        "estado": "ACEPTADO",
                        "fotografo_id": amp.userId
                      };
                      bool resultado = await res.updateReserva(myJSON);
                      if (resultado) {
                        Get.back();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)))),
        Divider(),
        (data.estado == "FINALIZADO" && amp.rol == "regular")
            ? Column(
                children: [
                  ButtonTheme(
                      minWidth: double.infinity,
                      height: 48.0,
                      child: RaisedButton(
                          color: Colors.lightBlue,
                          child: Text("Ver Fotos",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          onPressed: () async {
                            var x = await galeriaController
                                .fetchGaleriaEvento(data.evento_id);
                            print('LISTADO');
                            Get.to(GaleriaEvento(),
                                arguments: [x, data.nombre_evento]);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)))),
                  Divider(),
                  ButtonTheme(
                      minWidth: double.infinity,
                      height: 48.0,
                      child: RaisedButton(
                          color: Colors.green,
                          child: Text("Compartir",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          onPressed: () async {
                            await FlutterClipboard.copy(data.evento_id)
                                .then((value) => print('copied'));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)))),
                ],
              )
            : Container()
      ],
    ))));
  }

  String fecha(int sec) {
    var d = DateTime.fromMillisecondsSinceEpoch(sec * 1000);
    var f = DateFormat('yyyy-MM-dd – kk:mm').format(d);
    return f;
  }

  String formateado(String source) {
    final codeUnits = source.codeUnits;
    return Utf8Decoder().convert(codeUnits);
  }
}
