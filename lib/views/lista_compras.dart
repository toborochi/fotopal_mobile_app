import 'package:flutter/material.dart';
import 'package:fotopal_beta/controllers/compra_controller.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:get/get.dart';

class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  var compraController = Get.put(CompraController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      content: Column(
        children: [
          Expanded(
            child: GetX<CompraController>(builder: (controller) {
              return ListView.builder(
                itemCount: controller.compras.length,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    dense: true,
                    leading: SizedBox(
                      height: 500,
                      child: Icon(Icons.camera),
                    ),
                    title: Text(controller.compras[index].compra_id),
                    onTap: () async {
                      print(controller.compras[index]);
                    },
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
}
