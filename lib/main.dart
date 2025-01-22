import 'package:app_store/src/routes/app_pages.dart';
import 'package:app_store/src/routes/route.dart';
import 'package:app_store/src/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App Store',
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
      getPages: AppPage.pages,
      initialRoute: MyAppRouts.splashPage,

    );
  }
}


