import 'package:flutter/material.dart';
import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/views/sesion_usuario.dart';
import 'package:get/get.dart';

class AppScaffold extends StatefulWidget {
  Widget content;

  AppScaffold({Key key, this.content}) : super(key: key);

  @override
  _AppScafdoldState createState() => _AppScafdoldState();
}

class _AppScafdoldState extends State<AppScaffold> {
  AmplifyController amp = Get.find();

  @override
  Widget build(BuildContext context) {
    var text = new RichText(
      text: new TextSpan(
        style: TextStyle(fontSize: 26),
        children: <TextSpan>[
          new TextSpan(text: 'foto', style: TextStyle(color: Colors.white)),
          new TextSpan(
              text: 'pal',
              style: TextStyle(
                  color: Color(0xfff97fe3), fontWeight: FontWeight.bold)),
        ],
      ),
    );
    var ruta = Get.currentRoute;
    return Scaffold(
        appBar: AppBar(
          title: text,
          actions: <Widget>[
            (ruta != "/SesionUsuario" && ruta != "/")
                ? IconButton(
                    icon: new Icon(Icons.face),
                    onPressed: () {},
                  )
                : Container(),
            IconButton(
              icon: (ruta != "/SesionUsuario" && ruta != "/")
                  ? new Icon(Icons.logout)
                  : Container(),
              onPressed: () async {
                bool d = await amp.signOut();
                Get.offAll(SesionUsuario());
              },
            )
          ],
          backgroundColor: Color(0xff140938),
          /*leading: GestureDetector(
              onTap: () {
                print("Hola");
              },
              child: Icon(
                Icons.menu,
              ),
            )*/
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xff301e68), Color(0xff4f1760)])),
            child: this.widget.content));
  }
}
