import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/views/home_page.dart';
import 'package:fotopal_beta/views/home_page_foto.dart';
import 'package:get/get.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:image_picker/image_picker.dart';

class SesionCrear extends StatefulWidget {
  @override
  _SesionCrearState createState() => _SesionCrearState();
}

class _SesionCrearState extends State<SesionCrear> {
  Color myColor = new Color(0xfff97fe3);
  AmplifyController amp = Get.find();
  @override
  void initState() {
    super.initState();
  }

  TextEditingController correoController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nombreController = new TextEditingController();
  TextEditingController codigoController = new TextEditingController();
  bool hide = true;

  File file;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        print(file.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
                    "Crear Cuenta",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.33,
                  child: FittedBox(
                    child: CircularGradientButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome5.camera,
                            size: MediaQuery.of(context).size.width * 0.04,
                          ),
                          Text(
                            "Tomar\nFoto",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 6,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          )
                        ],
                      ),
                      callback: getImage,
                      gradient: Gradients.cosmicFusion,
                      shadowColor:
                          Gradients.deepSpace.colors.last.withOpacity(0.5),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: file == null
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            height: MediaQuery.of(context).size.width * 0.33,
                            color: Colors.white,
                            child: Icon(
                              FontAwesome5.user,
                              color: Colors.blueGrey,
                            ),
                          )
                        : Stack(
                            children: [
                              Container(
                                color: Colors.white,
                              ),
                              FadeInImage(
                                  fit: BoxFit.cover,
                                  width:
                                      MediaQuery.of(context).size.width * 0.33,
                                  height:
                                      MediaQuery.of(context).size.width * 0.33,
                                  placeholder:
                                      AssetImage("assets/images/spinner.gif"),
                                  image: FileImage(this.file))
                            ],
                          ))
              ],
            ),
            Divider(),
            _inputTextField("Nombre", nombreController, Icons.person, false),
            Divider(),
            _inputTextField(
                "Correo Electronico", correoController, Icons.email, false),
            Divider(),
            _passwordTextField("Contraseña", passwordController, Icons.lock)
          ],
        ),
      ),
    );
  }

  Widget _inputTextField(
      String txt, TextEditingController txtController, IconData i, bool label) {
    return Column(
      children: <Widget>[
        TextField(
          controller: txtController,
          style: TextStyle(color: Colors.white),
          decoration: _decoration(txt, label, i),
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
                child: Text("Crear Cuenta",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () async {
                  // TODO: aca va la registrada
                  bool result = await amp.signUp(nombreController.text,
                      correoController.text, passwordController.text, file);
                  if (result) {
                    openAlertBox();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)))),
        Divider(),
        ButtonTheme(
            height: 48.0,
            minWidth: double.infinity,
            child: RaisedButton(
                color: Color(0xfff97fe3),
                child: Text("Código de Verificación",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () async {
                  if (!(nombreController.text?.isEmpty ?? true) &&
                      !(correoController.text?.isEmpty ?? true) &&
                      !(passwordController.text?.isEmpty ?? true)) {
                    print("OKE");
                  } else {
                    print("NOOKE");
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

  openAlertBox() {
    print("ALERT BOX");
    print("s");
    Get.defaultDialog(
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
        onCancel: () {
          Get.back();
        },
        onConfirm: () async {
          bool res = await amp.checkSignUp(
              correoController.text, codigoController.text);
          String role = await amp.getRole(correoController.text);
          if (role != null && res) {
            if (role == "regular") {
              Get.offAll(HomePage());
            } else {
              Get.offAll(HomePageFotografo());
            }
          }
        },
        textConfirm: "Validar",
        textCancel: "Cancelar",
        confirmTextColor: Colors.white,
        cancelTextColor: Color(0xfff97fe3),
        buttonColor: Color(0xfff97fe3));
  }
}
