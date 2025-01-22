import 'package:app_store/common/constants/app_icon.dart';
import 'package:app_store/src/view_model/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../common/constants/global_variable.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final FocusNode _focusNode = FocusNode();

  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme(context).secondary,
          automaticallyImplyLeading: false,
          title: Text(
            "Categories",
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  side: BorderSide(color: colorScheme(context).primary))),
              onChanged: (query) => categoryController.search(query),
              padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0)),
              textStyle: WidgetStateProperty.all(
                  textTheme(context).titleSmall?.copyWith(
                        color: colorScheme(context).primary,
                      )),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => Text(
                  "${categoryController.filteredCategory.length} results found",
                  style: textTheme(context).titleSmall?.copyWith(
                      color:
                          colorScheme(context).primary.withValues(alpha: 0.3)),
                )),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(
                () {
                  if (categoryController.category.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: categoryController.filteredCategory.length,
                      itemBuilder: (context, index) {
                        final category =
                            categoryController.filteredCategory[index];
                        return GestureDetector(
                          onTap: () {
                             Get.toNamed("/product",arguments: category.slug,);
                          },
                          child: ClipRRect(
                            child: Stack(
                              children: [
                                Container(
                                  height: 180,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          category.thumbnail,
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Container(
                                  height: 180,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 140),
                                    child: Text(
                                      category.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
