import 'package:flutter/material.dart';
import 'package:fotopal_beta/controllers/auth_controller.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:fotopal_beta/views/sesion_crear.dart';
import 'package:fotopal_beta/views/sesion_iniciar.dart';
import 'package:get/get.dart';

class SesionUsuario extends StatelessWidget {
  AmplifyController amp = Get.put(AmplifyController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AppScaffold(
        content: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: TabBar(
            onTap: (index) {},
            tabs: [
              Tab(icon: Icon(Icons.alternate_email)),
              Tab(icon: Icon(Icons.account_circle)),
            ],
          ),
          body: TabBarView(
            children: [
              Center(child: SesionCrear()),
              Center(child: SesionIniciar()),
            ],
          ),
        ),
      ),
    );
  }
}
