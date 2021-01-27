import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:fotopal_beta/controllers/galeria_controller.dart';
import 'package:fotopal_beta/views/Components/SelectableItem.dart';
import 'package:fotopal_beta/views/app_scaffold.dart';
import 'package:get/get.dart';
import 'package:fotopal_beta/views/compras.dart';
import 'package:fotopal_beta/models/foto_simp.dart';

class Galeria extends StatefulWidget {
  @override
  _GaleriaState createState() => _GaleriaState();
}

class _GaleriaState extends State<Galeria> {
  final fotosController = Get.put(GaleriaController());
  final grid_controller = DragSelectGridViewController();

  void scheduleRebuild() => setState(() {});

  @override
  void initState() {
    super.initState();
    grid_controller.addListener(scheduleRebuild);
  }

  @override
  void dispose() {
    grid_controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      content: Column(
        children: [
          Divider(),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              children: <Widget>[
                Text(
                  "Galeria",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                Spacer(),
                FlatButton(
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.select_all,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      grid_controller.clear();
                    }),
                ButtonTheme(
                    child: RaisedButton(
                        color: Color(0xfff97fe3),
                        child: Text("Comprar",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        onPressed: () async {
                          List<FotoSimp> f = new List<FotoSimp>();
                          print(grid_controller.value.selectedIndexes);
                          grid_controller.value.selectedIndexes
                              .forEach((element) {
                            print(element);
                            f.add(fotosController.fotos[element]);
                          });
                          if (grid_controller.value.selectedIndexes.length >
                              0) {
                            await Get.to(Compras(), arguments: f);
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0))))
              ],
            ),
          ),
          Flexible(child: GetX<GaleriaController>(builder: (controller) {
            return DragSelectGridView(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              gridController: grid_controller,
              itemCount: controller.fotos.length,
              itemBuilder: (context, index, selected) {
                return SelectableItem(
                  index: index,
                  selected: selected,
                  foto: controller.fotos[index],
                );
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 80,
              ),
            );
          })),
        ],
      ),
    );
  }
}
