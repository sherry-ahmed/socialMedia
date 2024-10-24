import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class MapScreenController extends GetxController {
  var currentPosition = Position(
    latitude: 0.0,
    longitude: 0.0,
    timestamp: DateTime.now(),
    altitude: 0.0,
    accuracy: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0, altitudeAccuracy: 0.0, headingAccuracy: 0.0,
  ).obs;

  var isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  // Method to fetch the current location
  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );
      currentPosition.value = position;
      isLoading.value = false;
    } catch (e) {
      print("Error: $e");
    }
  }

}
