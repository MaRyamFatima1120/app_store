import 'package:app_store/src/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../../common/constants/global_variable.dart';
import '../../../view_model/favorit_controller.dart';

class ProductDetails extends StatefulWidget {
  final Products product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final favoritesController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme(context).secondary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
          color: colorScheme(context).primary,
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Products",
          style: textTheme(context)
              .bodyLarge
              ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: '${product.id}',
              child: Container(
                width: double.infinity,
                height: 210,
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  image: DecorationImage(
                    image: NetworkImage(
                      product.images![0],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Product Details:",
                        style: textTheme(context).bodyMedium?.copyWith(
                              color: colorScheme(context).primary,
                              fontSize: 18,
                            ),
                      ),
                      Obx(() {
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
                    ],
                  ),
                  _buildDetailRow("Name:", " ${product.title}", context),
                  _buildDetailRow("Price:", " \$${product.price}", context),
                  _buildDetailRow(
                      "Category:", " \$${product.category}", context),
                  _buildDetailRow("Brand:", " ${product.brand}", context),
                  Row(
                    children: [
                      Text(
                        'Rating: ',
                        style: textTheme(context).bodyMedium?.copyWith(
                            color: colorScheme(context).primary, fontSize: 12),
                      ),
                      // Display stars dynamically
                      Text(
                        product.rating?.toStringAsFixed(1) ?? "0.0",
                        style: textTheme(context).bodyMedium?.copyWith(
                            color: colorScheme(context).primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                      ),
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
                  _buildDetailRow("Stock:", " ${product.stock}", context),
                  Text(
                    'Description :',
                    style: textTheme(context).bodyMedium?.copyWith(
                        color: colorScheme(context).primary, fontSize: 12),
                  ),
                  Text(
                    "${product.description}",
                    style: textTheme(context).bodyMedium?.copyWith(
                        color: colorScheme(context).primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 10),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Product Gallery:',
                    style: textTheme(context).bodyMedium?.copyWith(
                        color: colorScheme(context).primary, fontSize: 12),
                  ),
                  SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two items per row
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          1.5, // Control the proportions of grid items
                    ),
                    itemCount: product.images?.length ?? 0,
                    itemBuilder: (context, index) {
                      final imageUrl = product.images![index];
                      bool isOffset = index % 2 != 0;
                      return Transform.translate(
                        offset: isOffset ? Offset(0, -20) : Offset(0, 0),
                        // Upward offset for alternate items
                        child: Container(
                          width: Get.width,
                          height: Get.height * 0.19,
                          decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                          ),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
                            height: 120,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildDetailRow(String title, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title ",
          style: textTheme(context)
              .bodyMedium
              ?.copyWith(color: colorScheme(context).primary, fontSize: 12),
        ),
        Expanded(
          child: Text(
            value,
            style: textTheme(context).bodyMedium?.copyWith(
                color: colorScheme(context).primary,
                fontWeight: FontWeight.w400,
                fontSize: 10),
          ),
        ),
      ],
    ),
  );
}
