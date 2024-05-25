
import 'package:get/get.dart';


import '../core/Class/crud.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    //Get.put(Test1PageControllerImp());
    //Get.lazyPut(() => Test1());
  }
}
