import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fotopal_beta/controllers/evento_controller.dart';
import 'package:fotopal_beta/controllers/face_controller.dart';
import 'package:fotopal_beta/models/face_response.dart';
import 'package:fotopal_beta/models/foto_simp.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:fotopal_beta/views/galeria_evento.dart';
import 'package:get/get.dart';

class EventosAsistidos extends StatefulWidget {
  @override
  _EventosAsistidosState createState() => _EventosAsistidosState();
}

class _EventosAsistidosState extends State<EventosAsistidos> {
  final eventosController = Get.put(EventoController());
  final faceController = Get.put(FaceController());
  TextEditingController codigoController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              children: <Widget>[
                Text(
                  "Asistidos",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Spacer(),
                ButtonTheme(
                    child: RaisedButton(
                        color: Color(0xfff97fe3),
                        child: Text("Codigo de Evento",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onPressed: openAlertBox,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0))))
              ],
            ),
          ),
          Expanded(
            child: GetX<EventoController>(builder: (controller) {
              return ListView.builder(
                itemCount: controller.eventos.length,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.white,
                      child: ListTile(
                        dense: true,
                        leading: SizedBox(
                          height: 500,
                          child: Icon(
                            LineariconsFree.picture_1,
                            size: 40,
                            color: Color(0xff140938),
                          ),
                        ),
                        title: Text(
                          controller.eventos[index].nombre_evento,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                        subtitle: Text(
                          'Fotos del Evento: ${controller.eventos[index].fotos.length}',
                        ),
                        onTap: () => _verGaleria(
                            controller.eventos[index].fotos,
                            controller.eventos[index].nombre_evento),
                        //trailing: _textoEstado(controller.eventos[index].estado),
                      ));
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  openAlertBox() {
    print("ALERT BOX");
    print("s");
    var d = Get.defaultDialog(
        title: "Verificación",
        content: Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            controller: this.codigoController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(color: Colors.grey),
                )),
          ),
        ),
        onConfirm: () async {
          FaceResponse fr =
              await faceController.getFace(this.codigoController.text);
          print(fr);

          Get.back();

          Get.defaultDialog(
              title: formateado(fr.message), content: Icon(Icons.ac_unit));
        },
        textConfirm: "Validar",
        confirmTextColor: Colors.white,
        cancelTextColor: Color(0xfff97fe3),
        buttonColor: Color(0xfff97fe3));
  }

  String formateado(String source) {
    final codeUnits = source.codeUnits;
    return Utf8Decoder().convert(codeUnits);
  }

  _verGaleria(var data, String nombre) {
    Get.to(GaleriaEvento(), arguments: [data, nombre]);
  }
}
