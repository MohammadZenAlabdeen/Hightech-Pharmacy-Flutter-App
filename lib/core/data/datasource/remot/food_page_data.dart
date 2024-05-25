

import '../../../Class/crud.dart';
import '../../../constant/app_links.dart';

class GetFoodData {
  Crud crud;
  GetFoodData(this.crud);
  getData() async {
    var response = await crud.postData(AppLinks.foodLink, {});
    // ignore: avoid_print
    print("  ================================== $response");
    return response.fold((l) => l, (r) => r);
  }
}
