import 'dart:async';

import 'package:clock_simple/modules/home_screen/controller/home_controller.dart';
import 'package:clock_simple/utils/navigation_utils/routes.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

import '../../../utils/app_color.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../setting_screen/controller/setting_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (settingController.preventLocking.value) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }
    SizeUtils().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Obx(() => Visibility(
              visible: homeController.isButtonVisible.value,
              child: IconButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  Navigation.pushNamed(Routes.settingScreen);
                },
                icon: Icon(Icons.settings, color: AppColor.whiteColor),
              ),
            )),
        body: Obx(() => Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black.withOpacity(homeController.currentSliderValueForColor.value),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 10),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          settingController.dimmer.value
                              ? SizedBox(
                                  height: 30,
                                  child: Visibility(
                                    visible: homeController.isVisible.value,
                                    child: Center(
                                      child: CupertinoSlider(
                                        value: homeController.currentSliderValue.value,
                                        max: 1,
                                        min: 0.1,
                                        activeColor: AppColor.whiteColor,
                                        thumbColor: Colors.transparent,
                                        onChanged: (double value) {},
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: settingController.hourFormat.value
                                    ? homeController.timeString24.value.substring(0, 8)
                                    : settingController.leadingZero.value == false && homeController.timeString.value.substring(0, 1) == "0"
                                        ? homeController.timeString.value.substring(1, 8)
                                        : homeController.timeString.value.substring(0, 8),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeUtils.fSize_60(),
                                    color:  (homeController.currentSliderValueForColor.value <= 0.5)
                                        ? Colors.black
                                        : AppColor.whiteColor.withOpacity(homeController.currentSliderValue.value)),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: " ${homeController.timeString.value.toString().substring(9, 11)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeUtils.fSize_24(),
                                        color: (homeController.currentSliderValueForColor.value <= 0.5)
                                            ? Colors.black
                                            : AppColor.whiteColor.withOpacity(homeController.currentSliderValue.value)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                          )
                        ],
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          homeController.isButtonVisible.value = !homeController.isButtonVisible.value;
                          SystemChrome.setEnabledSystemUIMode(
                              homeController.isButtonVisible.value ? SystemUiMode.manual : SystemUiMode.immersiveSticky,
                              overlays: SystemUiOverlay.values);
                        },
                        onPanEnd: (val) {
                          Timer.periodic(const Duration(seconds: 2), (Timer t) {
                            homeController.isVisible.value = false;
                          });
                        },
                        onPanUpdate: (details) {
                          print("onVerticalDragUpdate x : ${details.delta.dx}");
                          print("onVerticalDragUpdate y : ${details.delta.dy}");
                          if (settingController.dimmer.value) {
                            homeController.isVisible.value = true;
                            if (details.delta.dy < 0 && details.delta.dx == 0) {
                              homeController.isVisible.value = true;
                              if (homeController.currentSliderValue.value.toDouble() < 1) {
                                homeController.currentSliderValue.value += 0.01;
                              } else if (homeController.currentSliderValue.value.isNegative || homeController.currentSliderValue.value <= 0.9) {
                                homeController.currentSliderValue.value = 1.0;
                              }
                            } else if (details.delta.dy > 0 && details.delta.dx == 0) {
                              homeController.isVisible.value = true;
                              if (homeController.currentSliderValue.value.toDouble() > 0.2) {
                                homeController.currentSliderValue.value -= 0.01;
                              } else if (homeController.currentSliderValue.value.isNegative &&
                                  homeController.currentSliderValue.value.toDouble() <= 0.2) {
                                homeController.currentSliderValue.value = 0.2;
                              }
                            } else if (details.delta.dx < 0 && details.delta.dy == 0) {
                              if (homeController.currentSliderValueForColor.value.toDouble() < 1) {
                                homeController.currentSliderValueForColor.value += 0.01;
                              } else if (homeController.currentSliderValueForColor.value.isNegative ||
                                  homeController.currentSliderValueForColor.value <= 0.9) {
                                homeController.currentSliderValueForColor.value = 1.0;
                              }
                            } else if (details.delta.dx > 0 && details.delta.dy == 0) {
                              if (homeController.currentSliderValueForColor.value.toDouble() > 0.1) {
                                homeController.currentSliderValueForColor.value -= 0.01;
                              } else if (homeController.currentSliderValueForColor.value.isNegative &&
                                  homeController.currentSliderValueForColor.value.toDouble() <= 0.1) {
                                homeController.currentSliderValueForColor.value = 0.1;
                              }
                            }
                          }
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
