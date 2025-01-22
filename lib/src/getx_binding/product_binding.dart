import '../view_model/product_controller.dart';
import 'package:get/get.dart';

class ProductBinding implements Bindings{

  @override
  void dependencies(){
    Get.lazyPut(()=>ProductController());
  }
}