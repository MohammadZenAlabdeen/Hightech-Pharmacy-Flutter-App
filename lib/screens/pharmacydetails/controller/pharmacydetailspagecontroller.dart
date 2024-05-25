import 'package:get/get.dart';

abstract class PharmacyDetailsPageController extends GetxController {}

class PharmacyDetailsPageControllerImp extends PharmacyDetailsPageController {
  var user_latitude,user_longitude,pharmacy_id,pharmacy_latitude,pharmacy_longitude,pharmacy_name;
  @override
  void onInit() {
    user_latitude = Get.arguments["user_latitude"];
    user_longitude = Get.arguments["user_longitude"];
    pharmacy_id= Get.arguments["pharmacy_id"];
    pharmacy_latitude = Get.arguments["pharmacy_latitude"];
    pharmacy_longitude = Get.arguments["pharmacy_longitude"];
    pharmacy_name = Get.arguments["pharmacy_name"];
    super.onInit();
  }
}
