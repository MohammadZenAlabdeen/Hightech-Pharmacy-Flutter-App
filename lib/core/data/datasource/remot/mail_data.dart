

import '../../../Class/crud.dart';
import '../../../constant/app_links.dart';

class GetMailData {
  Crud crud;
  GetMailData(this.crud);
  getData(String country,String kind) async {
    var response = await crud.postData(AppLinks.mailLink, {
      "mail_country": country,
      "mail_kind": kind
    });
    // ignore: avoid_print
    print("  ================================== $response");
    return response.fold((l) => l, (r) => r);
  }
}
