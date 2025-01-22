
import 'package:app_store/src/getx_binding/binding.dart';
import 'package:app_store/src/routes/route.dart';
import 'package:app_store/src/view/home/home.dart';
import 'package:app_store/src/view/home/product/product.dart';
import 'package:app_store/src/view/home/product/product_details.dart';
import 'package:app_store/src/view/splash_page.dart';
import 'package:get/get.dart';
import 'error_route.dart';

class AppPage {
  static final pages = [
    GetPage(name: MyAppRouts.splashPage,
      page: ()=>const SplashPage(),
      transition: Transition.fade,
    ),
    GetPage(name: MyAppRouts.homePage,
      page: ()=>const HomePage(),
      transition: Transition.fade,
      binding: HomeBinding(),
    ),
    GetPage(name: MyAppRouts.productPage,
      page: ()=>ProductPage(category: Get.arguments,),
      transition: Transition.fade,
    ),
    GetPage(name: MyAppRouts.productDetailPage,
      page: ()=>ProductDetails(product:Get.arguments ),
      transition: Transition.fade,
    ),
    GetPage(
        name: MyAppRouts.errorPage,
        page: () => const ErrorPage(),
        transition: Transition.fade),
  ];
}
