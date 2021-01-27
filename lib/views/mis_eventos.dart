import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotopal_beta/controllers/reserva_controller.dart';
import 'package:fotopal_beta/models/reserva.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:fotopal_beta/views/evento_agendado.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MisEventos extends StatefulWidget {
  @override
  _MisEventosState createState() => _MisEventosState();
}

class _MisEventosState extends State<MisEventos> {
  _goToEvento(Reserva r) {
    Get.to(EventoAgendado(), arguments: r);
  }

  final reservaController = Get.put(ReservaController());

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (String listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    List<String> _dropdownItems = ['ssss', 'xxx', 'xxxxxxx'];
    List<DropdownMenuItem<String>> _dropdownMenuItems;
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    String _selectedItem = _dropdownMenuItems[0].value;

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
                  "Mis Eventos",
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
                itemCount: controller.reservas.length,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return Card(
                      color: _colorEstado(controller.reservas[index].estado),
                      child: ListTile(
                        dense: true,
                        leading: SizedBox(
                          height: 500,
                          child:
                              _iconoEstado(controller.reservas[index].estado),
                        ),
                        title: Text(controller.reservas[index].nombre_evento),
                        subtitle: Text(
                            fecha(controller.reservas[index].fecha_evento)),
                        onTap: () => _goToEvento(controller.reservas[index]),
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

  String fecha(int sec) {
    var d = DateTime.fromMillisecondsSinceEpoch(sec * 1000);
    var f = DateFormat('yyyy-MM-dd – kk:mm').format(d);
    return f;
  }

  Color _colorEstado(String e) {
    switch (e) {
      case 'FINALIZADO':
        return Colors.green[50].withOpacity(0.85);
        break;
      case 'PROCESANDO':
        return Colors.pink[50].withOpacity(0.85);
        break;
      case 'PENDIENTE':
        return Colors.orange[50].withOpacity(0.85);
        break;
      case 'ACEPTADO':
        return Colors.blue[50].withOpacity(0.85);
        break;
    }
    return null;
  }

  Text _textoEstado(String e) {
    return Text(
      '(${e[0].toUpperCase()}${e.substring(1)})',
      style:
          TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
    );
  }

  Icon _iconoEstado(String e) {
    IconData i;
    Color c;

    switch (e) {
      case 'FINALIZADO':
        i = Icons.check_circle;
        c = Colors.green;
        break;
      case 'PENDIENTE':
        i = Icons.timelapse;
        c = Colors.deepOrangeAccent;
        break;
      case 'ACEPTADO':
        i = Icons.watch_later;
        c = Colors.blue;
        break;
      case 'PROCESANDO':
        i = Icons.timer;
        c = Colors.pink;
        break;
    }

    return Icon(
      i,
      size: 40,
      color: c,
    );
  }
}
