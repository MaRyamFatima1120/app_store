import 'package:app_store/common/constants/app_icon.dart';
import 'package:app_store/src/view_model/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../common/constants/global_variable.dart';

class ProductPage extends StatefulWidget {
  final String? category; //
  const ProductPage({super.key, this.category});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final FocusNode _focusNode = FocusNode();
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.fetchProducts(widget.category);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme(context).secondary,
          leading: Offstage(
            offstage: widget.category == null,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              color: colorScheme(context).primary,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          title: Text(
            widget.category == null
                ? "Products"
                : "${widget.category}".replaceAll("-", " ").toUpperCase(),
            style: textTheme(context)
                .bodyLarge
                ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            _focusNode.unfocus();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBar(
                      focusNode: _focusNode,
                      leading: SvgPicture.asset(
                        AppIcon.search,
                        width: 16,
                        height: 16,
                      ),
                      hintText: 'Search',
                      hintStyle: WidgetStateProperty.all(textTheme(context)
                          .titleSmall
                          ?.copyWith(color: colorScheme(context).primary)),
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      elevation: WidgetStateProperty.all(0.0),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side:
                              BorderSide(color: colorScheme(context).primary))),
                      onChanged: (query) => productController.search(query),
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 14.0)),
                      textStyle: WidgetStateProperty.all(
                          textTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).primary,
                              )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => Text(
                          "${productController.filteredProduct.length} results found",
                          style: textTheme(context).titleSmall?.copyWith(
                              color: colorScheme(context)
                                  .primary
                                  .withValues(alpha: 0.3)),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Obx(() {
                        if (productController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (productController.filteredProduct.isEmpty) {
                          return Center(child: Text("No products available"));
                        }
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          itemCount: productController.filteredProduct.length,
                          itemBuilder: (context, index) {
                            final product =
                                productController.filteredProduct[index];
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed("/product-details",
                                    arguments: product);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: '${product.id}',
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          // Rounded corners
                                          bottomRight: Radius.circular(10),
                                        ),
                                        child: Container(
                                          width: Get.width,
                                          height: Get.height * 0.19,
                                          decoration: BoxDecoration(
                                            color: Color(0xffD9D9D9),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                product.images![0],
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          product.title ?? "No Title",
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .primary,
                                                  fontSize: 14),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text("\$${product.price}",
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .primary,
                                                  fontSize: 16)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      // Display stars dynamically
                                      Text(
                                          product.rating?.toStringAsFixed(1) ??
                                              "0.0",
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .primary)),
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
                                  SizedBox(height: 3),
                                  Text(
                                    "By ${product.brand ?? "No Brand"}",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color: colorScheme(context)
                                                .primary
                                                .withValues(alpha: 0.3),
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "In ${product.category ?? "No Category"}",
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color: colorScheme(context).primary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
