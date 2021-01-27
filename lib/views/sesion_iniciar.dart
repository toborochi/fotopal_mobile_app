import 'package:flutter/material.dart';
import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/views/home_page.dart';
import 'package:fotopal_beta/views/home_page_foto.dart';
import 'package:get/get.dart';

class SesionIniciar extends StatefulWidget {
  @override
  _SesionIniciarState createState() => _SesionIniciarState();
}

class _SesionIniciarState extends State<SesionIniciar> {
  TextEditingController correoController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool hide = true;
  AmplifyController amp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: ListView(
          padding: EdgeInsets.all(20),
          shrinkWrap: false,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    "Iniciar Sesion",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
            Divider(),
            _inputTextField(
                "Correo Electronico", correoController, Icons.email),
            Divider(),
            _passwordTextField("Contraseña", passwordController, Icons.lock)
          ],
        ),
      ),
    );
  }

  Widget _inputTextField(
      String txt, TextEditingController txtController, IconData i) {
    return Column(
      children: <Widget>[
        TextField(
          controller: txtController,
          style: TextStyle(color: Colors.white),
          decoration: _decoration(txt, false, i),
        ),
      ],
    );
  }

  Widget _passwordTextField(
      String txt, TextEditingController txtController, IconData i) {
    return Column(
      children: <Widget>[
        TextFormField(
          obscureText: hide,
          controller: txtController,
          style: TextStyle(color: Colors.white),
          decoration: _decoration(txt, false, i),
        ),
        FlatButton(
            shape: CircleBorder(),
            child: Icon(
              (hide) ? Icons.lock_outline : Icons.remove_red_eye,
              color: Colors.white,
            ),
            onPressed: _toggle),
        Divider(),
        ButtonTheme(
            height: 48.0,
            minWidth: double.infinity,
            child: RaisedButton(
                color: Color(0xfff97fe3),
                child: Text("Iniciar Sesión",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () async {
                  print(amp.isAmplifyConfigured);
                  bool log = await amp.login(
                      correoController.text, passwordController.text);
                  String r = await amp.getRole(correoController.text);
                  print(r);
                  print(log);
                  if (log && r != null) {
                    if (r == "regular") {
                      Get.offAll(HomePage());
                    } else {
                      Get.offAll(HomePageFotografo());
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0))))
      ],
    );
  }

  void _toggle() {
    setState(() {
      hide = !hide;
    });
  }

  InputDecoration _decoration(String txt, bool floating, IconData i) {
    return InputDecoration(
      suffixIcon: Icon(
        i,
        color: Colors.white,
      ),
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
}
