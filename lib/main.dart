
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hightech_pharmacy/routes.dart';
import 'binding/initial_binding.dart';
import 'core/Localization/changelocal.dart';
import 'core/Localization/translation.dart';
import 'core/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) => GetMaterialApp(
        initialBinding: InitialBinding(),
        locale: controller.language,
        debugShowCheckedModeBanner: false,
        translations: MyTranslation(),
        //   translations: MyTranslation(),
        getPages: routes,
      ),
    );
  }
}
