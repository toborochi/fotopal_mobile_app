import 'package:flutter/material.dart';
import 'package:fotopal_beta/views/home_page.dart';
import 'package:fotopal_beta/views/sesion_usuario.dart';
import 'package:get/get.dart';

import 'controllers/auth_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      transitionDuration: Duration(milliseconds: 250),
      defaultTransition: Transition.fade,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          hintColor: Colors.white),
      home: SesionUsuario(),
      getPages: [
        GetPage(
            transition: Transition.fadeIn, name: '/', page: () => HomePage()),
      ],
    );
  }
}
