

import '../../../Class/crud.dart';
import '../../../Constant/app_links.dart';

class TripPageData {
  Crud crud;
  TripPageData(this.crud);
  getData() async {
    var response = await crud.postData(AppLinks.tripData, {

    });
    // ignore: avoid_print
    print("  ================================== $response");
    return response.fold((l) => l, (r) => r);
  }
}
