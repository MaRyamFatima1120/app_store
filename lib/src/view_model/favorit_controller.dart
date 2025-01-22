import 'dart:convert';

import 'package:app_store/src/model/product_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends GetxController {
  var favoritProduct = <Products>[].obs;
  var filteredProducts = <Products>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void toggleFavorit(Products products) async{
    if (favoritProduct.contains(products)) {
      favoritProduct.remove(products);
    } else {
      favoritProduct.add(products);
    }
    await saveFavorites();
    search('');
  }

  bool isFavorit(Products products) {
    return favoritProduct.contains(products);
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(favoritProduct);
    } else {
      filteredProducts.assignAll(
        favoritProduct.where((product) =>
            product.title?.toLowerCase().contains(query.toLowerCase()) ??
            false),
      );
    }
  }

  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteList =
        favoritProduct.map((product) => json.encode(product.toJson())).toList();
    await prefs.setStringList('favorites', favoriteList);
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteList = prefs.getStringList('favorites');
    if (favoriteList != null) {
      favoritProduct.assignAll(favoriteList.map((json) {
        return Products.fromJson(jsonDecode(json));
      }).toList());
      search(""); // Update the filtered products
    }
  }
}
