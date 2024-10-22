import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/mapScreen/components/mapviewpopup.dart';
import 'package:socialmedia/view/mapScreen/controller/mapviewController.dart';
import 'package:socialmedia/view/mapScreen/view/Addcheckindialogue.dart';

class Mapview extends StatelessWidget {
  Mapview({super.key});
  final MapScreenController mapController = Get.put(MapScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {showDialog(
                      barrierColor: Colors.black.withOpacity(0.8),
                      context: context,
                      builder: (BuildContext context) =>
                           AddCheckInDialog());},
        backgroundColor: Colors.black.withOpacity(0.8),
        splashColor: Colors.red.withOpacity(0.3),
        child: Text(
          'Add\nLocation',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white, fontSize: 10),
        ),
      ),
      appBar: AppBar(
        title: const Text("Your Location"),
        actions: const [
          Mapviewpopup()
        ],
      ),
      body: Obx(() {
        // Observe the isLoading value
        if (mapController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                  mapController.currentPosition.value.latitude,
                  mapController.currentPosition.value.longitude),
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                // Display map tiles from any source
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                subdomains: ['a', 'b', 'c'],
                //userAgentPackageName: 'com.example.app',
                // And many more recommended properties!
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(
                      mapController.currentPosition.value.latitude,
                      mapController.currentPosition.value.longitude,
                    ),
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.blue,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }
}
