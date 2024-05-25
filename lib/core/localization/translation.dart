import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {"From": "من", "Location1": "الموقع 1", "Bus": "باص"},
        "en": {"From": "From", "Location1": "Location1", "Bus": "Bus"}
      };
}
