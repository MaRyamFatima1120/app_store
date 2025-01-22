import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants/app_image.dart';
import '../../common/constants/global_variable.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), (){
      Get.offNamed("/home");
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 60.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImage.splashImage), fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Store",
                style: textTheme(context).bodyLarge,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 70),
                child: Column(children: [
                  Text(
                    "Valkommen",
                    style: textTheme(context).bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hos ass kan du baka tid has nastan alla Sveriges salonger och motagningar. Baka frisor, massage, skonhetsbehandingar, friskvard och mycket mer.",
                    style: textTheme(context).bodyMedium?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
