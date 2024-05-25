import 'package:get/get.dart';
import 'package:hightech_pharmacy/screens/pharmacydetails/view/pharmacydetailspage.dart';
import 'package:hightech_pharmacy/screens/pharmicapage/view/pharmacypage.dart';

import 'core/constant/app_route.dart';


List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoutes.home, page: () => const PharmacyPage()),
  GetPage(name: AppRoutes.pharmacydetails, page: () => const PharmacyDetails()),
];
