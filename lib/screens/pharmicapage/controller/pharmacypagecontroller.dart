import 'package:get/get.dart';
import 'package:hightech_pharmacy/core/services/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';

import '../../../core/constant/app_route.dart';

abstract class PharmacyPageController extends GetxController {
  gotoDetailsPage(int i);
  getLocation();
}

class PharmacyPageControllerImp extends PharmacyPageController {
  MyServices myServices = Get.find();
  RxList<Map<String, dynamic>> pharmacyList = <Map<String, dynamic>>[].obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = true.obs;

  @override
  gotoDetailsPage(int i) {
    Get.toNamed(AppRoutes.pharmacydetails,
        arguments:{
          "user_latitude":latitude.toDouble(),
          "user_longitude":longitude.toDouble(),
          "pharmacy_id":pharmacyList[i]["id"],
          "pharmacy_latitude":pharmacyList[i]["latitude"],
          "pharmacy_longitude":pharmacyList[i]["longitude"],
          "pharmacy_name":pharmacyList[i]["name"],
        }
    );
  }

  @override
  Future<void> getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        isLoading(false);
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        isLoading(false);
        return;
      }
    }

    LocationData locationData = await location.getLocation();
    latitude(locationData.latitude ?? 0.0);
    longitude(locationData.longitude ?? 0.0);
    isLoading(false);
    // Call postLocation after latitude and longitude have been updated
    await postLocation(latitude.value, longitude.value);
  }

  Future<void> postLocation(double latitude, double longitude) async {
    pharmacyList.clear();
    final url = Uri.parse('http://127.0.0.1:8000/api/pharmacies');

    try {
      print(latitude);
      final response = await http.post(
        url,
        body: {
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> jsonData = json.decode(response.body);

        // Add parsed pharmacies to pharmacyList
        pharmacyList.addAll(jsonData.map<Map<String, dynamic>>((pharmacy) => {
          'id': pharmacy['id'],
          'name': pharmacy['name'],
          'state': pharmacy['state'],
          'distance': pharmacy['distance'] , // Ensure distance is not null
          'latitude': pharmacy['latitude'],
          'longitude': pharmacy['longitude'],
        }));

        // Update the UI
        update();
      } else {
        // Handle error response
        print('Failed to fetch pharmacy data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network errors
      print('Error fetching pharmacy data: $e');
    }
  }

  @override
  void onInit() {
    getLocation();
    postLocation(latitude.value, longitude.value);

    super.onInit();
  }
}
