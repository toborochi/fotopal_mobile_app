import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:fotopal_beta/views/agendar_evento.dart';
import 'package:get/get.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class MainButton extends StatelessWidget {
  _agendarEvento() {
    Get.to(AgendarEvento());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.5,
      width: MediaQuery.of(context).size.width * 0.5,
      child: FittedBox(
        child: CircularGradientButton(
          child: Icon(
            FontAwesome5.calendar_plus,
            size: MediaQuery.of(context).size.width * 0.075,
          ),
          callback: () => _agendarEvento(),
          gradient: Gradients.cosmicFusion,
          shadowColor: Gradients.deepSpace.colors.last.withOpacity(0.5),
        ),
      ),
    );
  }
}
