import 'package:clock_simple/modules/home_screen/controller/home_controller.dart';
import 'package:clock_simple/utils/navigation_utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/size_utils.dart';
import '../../../widget/app_text.dart';
import '../../setting_screen/controller/setting_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeController homeController = Get.find();
  SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Scaffold(
      backgroundColor: AppColor.blackColor.withOpacity(homeController.currentSliderValue.value),
      floatingActionButton: IconButton(
        splashColor: Colors.transparent,
        onPressed: () {
          Navigation.pushNamed(Routes.settingScreen);
        },
        icon: Icon(Icons.settings, color: AppColor.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Obx(() => Column(
              children: [
                settingController.dimmer.value
                    ? Center(
                        child: CupertinoSlider(
                          value: homeController.currentSliderValue.value,
                          max: 1,
                          divisions: 10,
                          activeColor: AppColor.whiteColor,
                          thumbColor: Colors.transparent,
                          onChanged: (double value) {
                            if (value == 0.0) {
                              homeController.currentSliderValue.value = 0.2;
                            } else {
                              homeController.currentSliderValue.value = value;
                            }
                          },
                        ),
                      )
                    : const SizedBox(),
                Center(
                  child: AppText(
                    text: homeController.currentTime,
                    color: AppColor.whiteColor.withOpacity(homeController.currentSliderValue.value),
                    fontWeight: FontWeight.normal,
                    fontSize: SizeUtils.fSize_50(),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
