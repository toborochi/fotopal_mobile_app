import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/controllers/compra_controller.dart';
import 'package:fotopal_beta/models/foto_simp.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Compras extends StatefulWidget {
  @override
  _MisEventosState createState() => _MisEventosState();
}

class _MisEventosState extends State<Compras> {
  List<FotoSimp> lista = Get.arguments;
  var compraController = Get.put(CompraController());
  AmplifyController amp = Get.find();

  @override
  Widget build(BuildContext context) {
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
                  "Compra",
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
          CarouselSlider(
            options: CarouselOptions(
                height: MediaQuery.of(context).size.width * 0.5),
            items: lista.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(color: Colors.black38),
                    child: OverflowBox(
                      minWidth: 0.0,
                      minHeight: 0.0,
                      maxWidth: double.infinity,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/spinner.gif',
                        image: i.foto_thumb,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Divider(),
          Text(
            "Costo: ${lista.length * 3}BOB.",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          Divider(),
          ButtonTheme(
              height: 48.0,
              child: RaisedButton(
                  color: Color(0xfff97fe3),
                  child: Text("Comprar",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () async {
                    List<String> s = new List<String>();
                    for (var i = 0; i < lista.length; ++i) {
                      s.add(lista[i].foto_thumb);
                    }
                    var monto_final = lista.length * 3;
                    var d = {
                      "usr": amp.userId,
                      "pics": jsonEncode(s),
                      "monto": monto_final
                    };
                    var js = jsonEncode(d);
                    bool r = await compraController.crearCompra(js);
                    print(js);
                    if (r) {
                      Get.back();
                    }
                    //Get.to(SelectMap()).then((value) => print('DD ${value}'));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0))))
        ]))));
  }
}
