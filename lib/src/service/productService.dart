import 'dart:convert';
import '../model/product_model.dart';
import 'package:http/http.dart' as http;
class ProductService{
  Future<List<Products>> fetchProduct([String? apiUrl]) async{
    String url= 'https://dummyjson.com/products?limit=100';
    if (apiUrl != null && apiUrl.isNotEmpty) {
      // If category is provided, filter products by category
      url = 'https://dummyjson.com/products/category/$apiUrl';
    }

    try{
      final response=await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        List<Products> products=(data['products'] as List).map((productJson)=> Products.fromJson(productJson)).toList();
        return products;

      }
      else{
        throw Exception("Failed to load data. Status code: ${response.statusCode}");
      }
    }
    catch(e){
      throw Exception('Error: $e');
    }
  }


}