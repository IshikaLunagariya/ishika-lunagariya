import 'dart:async';

import 'package:clock_simple/modules/home_screen/controller/home_controller.dart';
import 'package:clock_simple/utils/navigation_utils/routes.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../setting_screen/controller/setting_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeController homeController = Get.find();
  SettingController settingController = Get.find();

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
      body: GestureDetector(
        onVerticalDragUpdate: (val){

        },
        onVerticalDragStart: (val) {
          settingController.dimmer.value = true;
          homeController.currentSliderValue.value += 0.1;
        },
        onVerticalDragDown: (val) {
          settingController.dimmer.value = true;
          if (homeController.currentSliderValue.value == 0.0) {
            homeController.currentSliderValue.value += 0.1;
          } else {
            homeController.currentSliderValue.value -= 0.1;
          }
        },

        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Obx(
              () => SizedBox(
                height: SizeUtils.screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    settingController.dimmer.value
                        ? Visibility(
                            visible: homeController.isVisible.value,
                            child: Center(
                              child: CupertinoSlider(
                                value: homeController.currentSliderValue.value,
                                max: 1,
                                min: 0.2,
                                activeColor: AppColor.whiteColor,
                                thumbColor: Colors.transparent,
                                onChanged: (double value) {
                                  // if (value == 0.0) {
                                  //   homeController.currentSliderValue.value = 0.1;
                                  // } else {
                                  //   homeController.currentSliderValue.value = value;
                                  // }
                                },
                                onChangeEnd: (val) {
                                  // Timer.periodic(const Duration(seconds: 2), (Timer t) {
                                  //   homeController.isVisible.value = false;
                                  // });
                                },
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: homeController.timeString.value.substring(0, 8),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: SizeUtils.fSize_60(),
                              color: AppColor.whiteColor.withOpacity(homeController.currentSliderValue.value)),
                          children: <TextSpan>[
                            TextSpan(
                              text: " ${homeController.timeString.value.toString().substring(9, 11)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: SizeUtils.fSize_24(),
                                  color: AppColor.whiteColor.withOpacity(homeController.currentSliderValue.value)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
