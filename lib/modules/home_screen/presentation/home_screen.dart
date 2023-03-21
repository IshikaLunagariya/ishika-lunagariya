import 'package:clock_simple/modules/home_screen/controller/home_controller.dart';
import 'package:clock_simple/utils/navigation_utils/routes.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../utils/navigation_utils/navigation.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Scaffold(
      floatingActionButton: IconButton(
        splashColor: Colors.transparent,
        onPressed: () {
          Navigation.pushNamed(Routes.settingScreen);
        },
        icon: Icon(Icons.settings, color: AppColor.whiteColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Center(
              child: RichText(
                text: TextSpan(
                  text: homeController.timeString.value.substring(0, 8),
                  style: TextStyle(
                      fontWeight: FontWeight.w400, fontSize: SizeUtils.fSize_60(), color: AppColor.whiteColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: " ${homeController.timeString.value.toString().substring(9, 11)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: SizeUtils.fSize_24(), color: AppColor.whiteColor),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
