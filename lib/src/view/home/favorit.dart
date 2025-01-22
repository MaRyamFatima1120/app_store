import 'package:app_store/common/constants/app_icon.dart';
import 'package:app_store/src/view_model/favorit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../common/constants/global_variable.dart';
class FavoritPage extends StatefulWidget {
  const FavoritPage({super.key});

  @override
  State<FavoritPage> createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  final FocusNode _focusNode = FocusNode();
  final favoritesController = Get.put(FavoritesController());

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:GestureDetector(
          onTap: (){
            _focusNode.unfocus();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Center(
                      child: Text("Favorites", style: textTheme(context).bodyLarge?.copyWith(
                          fontSize: 24, fontWeight: FontWeight.w600),),
                    ),
                    SizedBox(height: 10,),
                    SearchBar(
                      focusNode: _focusNode,
                      leading:  SvgPicture.asset(
                        AppIcon.search,
                        width: 16,
                        height: 16,
                      ),
                      hintText: 'Search',
                      hintStyle:  WidgetStateProperty.all(
                          textTheme(context).titleSmall?.copyWith(color: colorScheme(context).primary)),
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      elevation: WidgetStateProperty.all(0.0),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                              color: colorScheme(context).primary
                          )
                      )),
                     onChanged:(query) => favoritesController.search(query),
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 14.0)),
                      textStyle: WidgetStateProperty.all(
                          textTheme(context).titleSmall?.copyWith(color: colorScheme(context).primary,)),

                    ),
                    SizedBox(height: 10,),
                   Obx(()=> Text("${favoritesController.filteredProducts.length} results found",style: textTheme(context).titleSmall?.copyWith(color: colorScheme(context).primary.withValues(alpha:0.3)),)),
                    SizedBox(height: 10,),
                    Expanded(child:  Obx(() {
                      if (favoritesController.favoritProduct.isEmpty) {
                        return Center(child: Text("No favorites yet!",style: textTheme(context).bodySmall?.copyWith(
                            color: colorScheme(context).primary,
                            fontSize: 14),));
                      }
                      return ListView.builder(

                        itemCount: favoritesController.filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = favoritesController.filteredProducts[index];
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 1) ,
                            title: Text(
                              product.title ?? "No Title",
                              style: textTheme(context).bodySmall?.copyWith(
                                  color: colorScheme(context).primary,
                                  fontSize: 14),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("\$${product.price}",
                                    style: textTheme(context).bodySmall?.copyWith(
                                        color: colorScheme(context).primary,
                                        fontSize: 15)),
                                Row(
                                  children: [
                                    // Display stars dynamically
                                    Text(product.rating?.toStringAsFixed(1) ?? "0.0",
                                        style: textTheme(context).bodySmall?.copyWith(
                                            color: colorScheme(context).primary)),
                                    SizedBox(width: 8),
                                    RatingBarIndicator(
                                      rating: product.rating ?? 0.0,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: colorScheme(context).onSurface,
                                      ),
                                      itemCount: 5,
                                      itemSize: 16.0,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            leading:CircleAvatar(
                              radius: 40,
                              backgroundColor:Color(0xffD9D9D9),
                              foregroundImage:  NetworkImage(product.images![0]),
                              
                            ),
                            trailing: Obx(() {
                              final favIcon = favoritesController.isFavorit(product);
                              return IconButton(
                                onPressed: () {
                                  favoritesController.toggleFavorit(product);
                                },
                                icon: Icon(
                                  favIcon ? Icons.favorite : Icons.favorite_outline,
                                  size: 30,
                                  color: favIcon
                                      ? Color(0xffee3c3c)
                                      : colorScheme(context).primary,
                                ),

                              );
                            }
                            ),
                            onTap: () {

                            },
                          );
                        },
                      );
                    }),
                    )

                  ],
              ),

            ),
          ),
        )
    );
  }
}
