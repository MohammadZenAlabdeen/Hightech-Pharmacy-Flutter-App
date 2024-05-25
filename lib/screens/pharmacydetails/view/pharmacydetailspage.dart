import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constant/app_color.dart';
import '../controller/pharmacydetailspagecontroller.dart';

class PharmacyDetails extends StatelessWidget {
  const PharmacyDetails({super.key});
  @override
  Widget build(BuildContext context) {
    PharmacyDetailsPageControllerImp pharmacyDetailsPageControllerImp = Get.put(PharmacyDetailsPageControllerImp());
    print(pharmacyDetailsPageControllerImp.user_latitude);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.pharmicaColors,
        ),
        body: FlutterMap(
          options:  MapOptions(
            initialCenter: LatLng(pharmacyDetailsPageControllerImp.pharmacy_latitude as double,pharmacyDetailsPageControllerImp.pharmacy_longitude as double),
            initialZoom: 11,
            interactionOptions:
                InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),
          ),

          children: [
            openStreetMapTileLayer,
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(pharmacyDetailsPageControllerImp.user_latitude,pharmacyDetailsPageControllerImp.user_longitude),
                  width: 80,
                  height: 80,
                  child: FlutterLogo(),
                ),
                Marker(
                  point: LatLng(pharmacyDetailsPageControllerImp.pharmacy_latitude as double,pharmacyDetailsPageControllerImp.pharmacy_longitude as double),
                  width: 80,
                  height: 80,
                  child: FlutterLogo(),
                ),
              ],
            ),
          ],
        ));
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
