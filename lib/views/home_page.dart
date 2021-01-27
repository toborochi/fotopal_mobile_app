import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fotopal_beta/views/Components/MainButton.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:fotopal_beta/views/compras.dart';
import 'package:fotopal_beta/views/eventos_asistidos.dart';
import 'package:fotopal_beta/views/galeria.dart';
import 'package:fotopal_beta/views/mis_eventos.dart';
import 'package:get/get.dart';
import 'package:fotopal_beta/views/lista_compras.dart';

class HomePage extends StatelessWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      content: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Agendar Evento",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
                MainButton(),
                Container(
                  height: 20,
                )
              ],
            ),
          ),
          SliverGrid.count(crossAxisCount: 2, children: [
            _button(
                Icon(
                  Elusive.group,
                  color: Colors.white,
                  size: 60,
                ),
                "Mis Eventos",
                MisEventos()),
            _button(
                Icon(
                  MfgLabs.calendar,
                  color: Colors.white,
                  size: 60,
                ),
                "Asistidos",
                EventosAsistidos()),
            _button(
                Icon(
                  Typicons.picture,
                  color: Colors.white,
                  size: 60,
                ),
                "Galería",
                Galeria()),
            _button(
                Icon(
                  Entypo.bag,
                  color: Colors.white,
                  size: 60,
                ),
                "Compras",
                ListaCompras())
          ]),
          SliverToBoxAdapter(
              child: Container(
            padding: EdgeInsets.all(10),
          ))
        ],
      ),
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
