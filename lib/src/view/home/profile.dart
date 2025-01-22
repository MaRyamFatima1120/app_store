import 'package:app_store/common/constants/app_color.dart';
import 'package:app_store/common/constants/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../common/constants/global_variable.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorScheme(context).secondary,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Mitt konto", style: textTheme(context).bodyLarge?.copyWith(
                    fontSize: 24, fontWeight: FontWeight.w600),),
                Container(
                  height: Get.height * 0.2,
                  margin: EdgeInsets.symmetric(vertical: 34.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: colorScheme(context).primary,
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Row(
          
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColor.whiteColor,
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("My Name", style: textTheme(context).bodySmall,),
                          Text("myname@gmail.com",
                            style: textTheme(context).bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                height: 2.0),),
                          Text("07XXXXXXXX",
                            style: textTheme(context).bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                height: 2.0),)
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                      children: [
                        listItem(
                            context,
                            title: 'Kontoinstallningar',
                            iconPath: AppIcon.setting,
                            onTap: () {  }),
                        listItem(
                            context,
                            title: 'betalmetoder',
                            iconPath: AppIcon.mina,
                            onTap: () {  }),
                        listItem(
                            context,
                            title: 'Support',
                            iconPath: AppIcon.support,
                            onTap: () {  }),
                      ],
                    ))
              ],
            ),
          ),
        )
    );
  }
}


Widget listItem(BuildContext context, {
  required String title,
  required String iconPath,
  required VoidCallback onTap}) {
  return Column(
    children: [
      ListTile(
        leading: SvgPicture.asset( iconPath,),
        title: Text(title,style: textTheme(context).bodyMedium?.copyWith( fontWeight: FontWeight.w400,
            color: colorScheme(context).onSecondary),),
        onTap: onTap,
      ),

    ],
  );
}