import 'package:get/get.dart';
import '../model/product_model.dart';
import '../service/productService.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  var isLoading = true.obs;
  var products = <Products>[].obs;
  var filteredProduct = <Products>[].obs;
  var searchtext = ''.obs;



  Future<void> fetchProducts([String? category]) async {
    try {
      isLoading.value = true;
      List<Products> fetchProduct = await _productService.fetchProduct(category);
      products.value = fetchProduct;
      filteredProduct.value = fetchProduct;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  void search(String query) {
    searchtext.value = query;
    if (query.isEmpty) {
      filteredProduct.value = products;
    }
    else {
      filteredProduct.value =
          products.where((product) => product.title?.toLowerCase().contains(
              query.toLowerCase()) ?? false)
              .toList();
    }
  }
}
