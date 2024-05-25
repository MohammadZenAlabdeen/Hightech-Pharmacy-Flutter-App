import 'dart:html';

import 'package:get/get.dart';
import 'package:hightech_pharmacy/core/services/services.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'dart:convert';

import '../../../core/constant/app_route.dart';

abstract class PharmacySearchController extends GetxController{}

class PharmacySearchControllerImp extends PharmacySearchController{
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = true.obs;
  MyServices myServices = Get.find();
  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;

  Future<void> searchPharmacy(String query) async {
    isLoading(true);
    final url = Uri.parse('http://127.0.0.1:8000/api/medicines/search');

    try {
      final response = await http.post(
        url,
        body: {
          'name': query,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        searchResults.clear();
        searchResults.addAll(jsonData.map<Map<String, dynamic>>((medicine) => {
          'id': medicine['id'],
          'name': medicine['name'],
          'count': medicine['count'],
          'pharmacy': medicine['pharmacy'],
        }));

      } else {
        print('Failed to fetch search data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching search data: $e');
    } finally {
      isLoading(false);
    }
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
  }

  @override
  gotoDetailsPage(int i) {
    Get.toNamed(AppRoutes.pharmacydetails,
        arguments:{
          "user_latitude":latitude.toDouble(),
          "user_longitude":longitude.toDouble(),
          "pharmacy_id":searchResults[i]["pharmacy"]["id"],
          "pharmacy_latitude":searchResults[i]["pharmacy"]["latitude"],
          "pharmacy_longitude":searchResults[i]["pharmacy"]["longitude"],
          "pharmacy_name":searchResults[i]["pharmacy"]["name"],
        }
    );

  }
  @override
  void onInit() {
   getLocation();
    super.onInit();
  }
}