import 'package:flutter/material.dart';
import 'package:fotopal_beta/controllers/reserva_controller.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgendaFoto extends StatefulWidget {
  @override
  _AgendaFotoState createState() => _AgendaFotoState();
}

class _AgendaFotoState extends State<AgendaFoto> {
  var res = Get.put(ReservaController());

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
                  "Eventos Agendados",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: GetX<ReservaController>(builder: (controller) {
              return ListView.builder(
                itemCount: controller.galeria.length,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                        dense: true,
                        leading: SizedBox(
                          height: 500,
                          child: Icon(Icons.map, size: 40),
                        ),
                        title: Text(controller.galeria[index].nombre_evento),
                        subtitle:
                            Text(fecha(controller.galeria[index].fecha_evento)),
                        onTap: () => {}),
                    //trailing: _textoEstado(controller.eventos[index].estado),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  String fecha(int sec) {
    var d = DateTime.fromMillisecondsSinceEpoch(sec * 1000);
    var f = DateFormat('yyyy-MM-dd – kk:mm').format(d);
    return f;
  }
}
