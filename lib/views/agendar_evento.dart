import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/controllers/reserva_controller.dart';
import 'package:fotopal_beta/models/estudio.dart';
import 'package:fotopal_beta/models/reserva.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:fotopal_beta/views/evento_agendado.dart';
import 'package:fotopal_beta/views/select_map.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:intl/intl.dart';
import 'package:textfield_tags/textfield_tags.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(79, 23, 96, .1),
  100: Color.fromRGBO(79, 23, 96, .2),
  200: Color.fromRGBO(79, 23, 96, .3),
  300: Color.fromRGBO(79, 23, 96, .4),
  400: Color.fromRGBO(79, 23, 96, .5),
  500: Color.fromRGBO(79, 23, 96, .6),
  600: Color.fromRGBO(79, 23, 96, .7),
  700: Color.fromRGBO(79, 23, 96, .8),
  800: Color.fromRGBO(79, 23, 96, .9),
  900: Color.fromRGBO(79, 23, 96, 1),
};

class AgendarEvento extends StatefulWidget {
  @override
  _AgendarEventoState createState() => _AgendarEventoState();
}

class _AgendarEventoState extends State<AgendarEvento> {
  final reservaController = Get.put(ReservaController());
  AmplifyController amp = Get.find();

  String direccion = "Seleccionar Ubicación";
  PickResult pr = null;
  List<Estudio> est = [
    new Estudio(estudio_id: "1", nombre_estudio: "Estudio Agfa"),
    new Estudio(estudio_id: "2", nombre_estudio: "Fotobueno"),
    new Estudio(estudio_id: "3", nombre_estudio: "Momentos Felices")
  ];

  TextEditingController nombreEventoController = new TextEditingController();
  TextEditingController cantidadEventoController = new TextEditingController();
  TextEditingController cantidadFotografosController =
      new TextEditingController();
  TextEditingController comentariosEventoController =
      new TextEditingController();
  TextEditingController duracionEventoController = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  int _itemCount = 30;
  int _estudioIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("USERID " + amp.userId);

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
                    "Agendar un Evento",
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
            _inputTextField('Nombre del Evento', nombreEventoController),
            Divider(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Colors.white),
                  color: Colors.black.withOpacity(0.33)),
              child: new Row(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.arrow_back_ios),
                    onPressed: () => setState(() => (_estudioIndex - 1 >= 0)
                        ? _estudioIndex -= 1
                        : _estudioIndex = 0),
                    color: Colors.white,
                  ),
                  Expanded(
                      child: Text(
                    " Estudio: " + est[_estudioIndex].nombre_estudio,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                  new IconButton(
                    icon: new Icon(Icons.arrow_forward_ios),
                    onPressed: () => setState(() =>
                        (_estudioIndex + 1 < est.length)
                            ? _estudioIndex += 1
                            : _estudioIndex = est.length - 1),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.33)),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    tooltip: 'Fecha',
                    onPressed: () async {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day + 7,
                              23), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                  ),
                  Text(
                    'Fecha: ${DateFormat('yyyy-MM-dd – kk:mm').format(selectedDate)}',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Colors.white),
                  color: Colors.black.withOpacity(0.33)),
              child: new Row(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.remove),
                    onPressed: () => setState(() => (_itemCount - 30 >= 30)
                        ? _itemCount -= 30
                        : _itemCount = 30),
                    color: Colors.white,
                  ),
                  Expanded(
                      child: Text(
                    _itemCount.toString() + " Minutos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                  new IconButton(
                    icon: new Icon(Icons.add),
                    onPressed: () => setState(() => _itemCount += 30),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Divider(),
            _inputArea('Comentario(s)', comentariosEventoController),
            Divider(),
            TextFieldTags(
              textFieldStyler: TextFieldStyler(
                textStyle: TextStyle(color: Colors.white),
                textFieldFilled: true,
                textFieldFilledColor: Colors.black.withOpacity(0.33),
                helperText: 'Tipo de Fotos',
                isDense: true,
                hintText: 'Etiquetas',
              ),
              tagsStyler: TagsStyler(
                  tagCancelIcon:
                      Icon(Icons.cancel, size: 16.0, color: Color(0xfff97fe3)),
                  tagTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff140938)),
                  tagDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: Colors.white),
                      color: Colors.white)),
              onTag: (tag) {},
              onDelete: (tag) {},
            ),
            Divider(),
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.33)),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    tooltip: 'Ubicacion',
                    onPressed: () async {
                      Get.to(SelectMap()).then((value) {
                        if (value != null) {
                          setState(() {
                            pr = value;
                            print(pr.formattedAddress);
                            direccion = pr.formattedAddress;
                          });
                        } else {
                          direccion = "Seleccionar Ubicación";
                        }
                      });
                    },
                  ),
                  Flexible(
                    child: Text(
                      'Dirección: ${direccion}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            ButtonTheme(
                height: 48.0,
                child: RaisedButton(
                    color: Color(0xfff97fe3),
                    child: Text("Agendar",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    onPressed: () async {
                      print("RESERVANDO");
                      print(nombreEventoController.text);
                      print(_itemCount.toString());
                      print("USERID" + amp.userId);

                      if (nombreEventoController.text.isNotEmpty &&
                          pr != null &&
                          amp.userId != null) {
                        Reserva res = new Reserva(
                            nombre_evento: nombreEventoController.text,
                            owner: amp.userId,
                            duracion: _itemCount * 60,
                            latitud: pr.geometry.location.lat,
                            longitud: pr.geometry.location.lng,
                            estudio_id: _estudioIndex.toString(),
                            comentarios: comentariosEventoController.text,
                            nombre_lugar: pr.formattedAddress,
                            fecha_evento:
                                (selectedDate.microsecondsSinceEpoch / 1000000)
                                    .round());
                        print("RESERVANDO");
                        bool reservaCreada =
                            await reservaController.saveReserva(res);
                        if (reservaCreada) {
                          Get.back();
                        }
                      }

                      //Get.to(SelectMap()).then((value) => print('DD ${value}'));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0))))
          ],
        ),
      )),
    );
  }

  InputDecoration _decoration(String txt, bool floating) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.black.withOpacity(0.33),
      floatingLabelBehavior: (floating)
          ? FloatingLabelBehavior.always
          : FloatingLabelBehavior.auto,
      hintStyle: TextStyle(color: Colors.white),
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
      ),
      labelText: txt,
    );
  }

  Widget _inputTextField(String txt, TextEditingController txtController) {
    return TextField(
      controller: txtController,
      style: TextStyle(color: Colors.white),
      decoration: _decoration(txt, true),
    );
  }

  Widget _inputNumberField(String txt, TextEditingController txtController) {
    return TextField(
      controller: txtController,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.white),
      decoration: _decoration(txt, true),
    );
  }

  Widget _inputArea(String txt, TextEditingController txtController) {
    return TextField(
      controller: txtController,
      maxLines: 3,
      style: TextStyle(color: Colors.white),
      decoration: _decoration(txt, true),
    );
  }
}
