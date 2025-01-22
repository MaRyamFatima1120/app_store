import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/CategoryModel.dart';

class CategoryService {
  Future<List<CategoryModal>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> categories = jsonDecode(response.body);

      // Fetching thumbnail for each category
      List<CategoryModal> categoriesWithThumbnails = [];
      for (var category in categories) {
        final String url = category['url'];
        final thumbnailResponse = await http.get(Uri.parse(url));
        if (thumbnailResponse.statusCode == 200) {
          final products = jsonDecode(thumbnailResponse.body)['products'];
          final String thumbnail =
              products.isNotEmpty ? products[1]['thumbnail'] : '';
          categoriesWithThumbnails
              .add(CategoryModal.fromJson(category, thumbnail));
        }
      }
      return categoriesWithThumbnails;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
