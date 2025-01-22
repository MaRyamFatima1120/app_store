import 'package:app_store/src/model/CategoryModel.dart';
import 'package:app_store/src/service/category_service.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';

class CategoryController extends GetxController {
  final CategoryService _categoryService = CategoryService();
  var isLoading = true.obs;
  var category = <CategoryModal>[].obs;
  var filteredCategory = <CategoryModal>[].obs;
  var searchText = ''.obs;
  var products = <Products>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Function to fetch categories and update the state
  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await _categoryService.fetchCategories();
      category.value = fetchedCategories;
      filteredCategory.value=fetchedCategories;
    } catch (e) {
      print('Error: $e');
    }
  }


  void search(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      // If the search query is empty, show all categories
      filteredCategory.value = category;
    } else {
      // Filter categories based on the search query
      filteredCategory.value = category
          .where((category) =>
          category.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}

