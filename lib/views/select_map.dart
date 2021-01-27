import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectMap extends StatelessWidget {
//  @override
//  _SelectMapState createState() => _SelectMapState();
//}
//
//class _SelectMapState extends State<SelectMap> {
  PickResult selectedPlace = new PickResult();
  @override
  Widget build(BuildContext context) {
    final kInitialPosition = LatLng(-17.7882056, -63.16566528);
    return Container(
      child: PlacePicker(
        apiKey: "<GOOGLE API KEY>",
        initialPosition: kInitialPosition,
        useCurrentLocation: true,
        onPlacePicked: (result) {
          selectedPlace = result;
          Get.back(result: selectedPlace);
        },
      ),
    );
  }
}
