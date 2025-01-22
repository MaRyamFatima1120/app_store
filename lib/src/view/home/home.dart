import 'package:app_store/common/constants/global_variable.dart';
import 'package:app_store/src/view/home/category/category.dart';
import 'package:app_store/src/view/home/profile.dart';
import 'package:app_store/src/view/home/product/product.dart';
import 'package:app_store/src/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_color.dart';
import '../../../common/constants/app_icon.dart';
import 'favorit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.find();

  final List<Widget> _pages=[
    ProductPage(),
    CategoryPage(),
    FavoritPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).secondary,
      body: Obx(() => _pages[controller.selected.value]),
      bottomNavigationBar: Obx(()=>
         ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5), // Rounded corners
            topRight: Radius.circular(5),
          ),
          child: SizedBox(
              height:75,
              child: BottomNavigationBar(
                backgroundColor: colorScheme(context).primary,
                  type:BottomNavigationBarType.fixed,
                  currentIndex: controller.selected.value,
                  onTap: controller.onItemTap,
                  unselectedItemColor:AppColor.whiteColor,
                  selectedItemColor: AppColor.whiteColor,
                  unselectedFontSize: 10,
                  selectedFontSize: 10,
                  items: [
                    BottomNavigationBarItem(
                        icon:SvgPicture.asset(
                      AppIcon.products,
                    ),label: "Products"),
                    BottomNavigationBarItem(icon:SvgPicture.asset(
                        AppIcon.category),label: "Categories"),
                    BottomNavigationBarItem(icon:SvgPicture.asset(
                        AppIcon.favorit,),label: "Favourites"),
                    BottomNavigationBarItem(icon:SvgPicture.asset(
                        AppIcon.profile),label: "Mitt konto"),
                  ]),
            ),
          ),
      ),

    );
  }
}
