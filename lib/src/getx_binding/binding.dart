import 'package:app_store/src/view_model/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings{

  @override
  void dependencies(){
    Get.lazyPut(()=>HomeController());
  }
}