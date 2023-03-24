import 'dart:async';
import 'dart:ui';

import 'package:clock_simple/modules/home_screen/controller/home_controller.dart';
import 'package:clock_simple/utils/navigation_utils/navigation.dart';
import 'package:clock_simple/utils/navigation_utils/routes.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

import '../../../utils/app_color.dart';
import '../../setting_screen/controller/setting_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find();

  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    if (settingController.preventLocking.value) {
      Wakelock.enable();
    } else {
      Wakelock.disable();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Obx(() => Visibility(
            visible: homeController.isButtonVisible.value,
            child: IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                Navigation.pushNamed(Routes.settingScreen);
              },
              icon: Icon(
                Icons.settings,
                color:
                    homeController.currentSliderValueForColor.value <= 0.5 ? AppColor.blackColor : AppColor.whiteColor,
              ),
            ),
          )),
      body: Obx(() => Center(
            child: Container(
              margin: EdgeInsets.zero,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(homeController.currentSliderValueForColor.value),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 10),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        settingController.dimmer.value
                            ? SizedBox(
                                height: 30,
                                child: Visibility(
                                  visible: homeController.isVisible.value,
                                  child: SizedBox(
                                    width: 130,
                                    child: SliderTheme(
                                      data: SliderThemeData(
                                        thumbShape: SliderComponentShape.noThumb,
                                        trackHeight: 0.5,
                                        overlayShape: SliderComponentShape.noThumb,
                                        inactiveTrackColor: Colors.transparent,
                                        activeTrackColor: homeController.currentSliderValueForColor.value <= 0.5
                                            ? AppColor.blackColor
                                            : AppColor.whiteColor,
                                      ),
                                      child: Slider(
                                        value: homeController.currentSliderValue.value,
                                        max: 1,
                                        min: 0.1,
                                        onChanged: (double value) {},
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            text: settingController.hourFormat.value
                                ? homeController.timeString24.value.substring(0, 8)
                                : settingController.leadingZero.value == false &&
                                        homeController.timeString.value.substring(0, 1) == "0"
                                    ? homeController.timeString.value.substring(1, 8)
                                    : homeController.timeString.value.substring(0, 8),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeUtils.fSize_60(),
                                color: (homeController.currentSliderValueForColor.value <= 0.5)
                                    ? Colors.black.withOpacity(homeController.currentSliderValue.value)
                                    : AppColor.whiteColor.withOpacity(homeController.currentSliderValue.value)),
                            children: <TextSpan>[
                              TextSpan(
                                text: " ${homeController.timeString.value.toString().substring(9, 11)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: SizeUtils.fSize_24(),
                                    color: (homeController.currentSliderValueForColor.value <= 0.5)
                                        ? Colors.black.withOpacity(homeController.currentSliderValue.value)
                                        : AppColor.whiteColor.withOpacity(homeController.currentSliderValue.value)),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
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
                        Future.delayed(const Duration(seconds: 2)).then((value) {
                          homeController.isVisible.value = false;
                        });
                      },
                      onPanUpdate: (details) {
                        print("onVerticalDragUpdate x : ${details.delta.dx}");
                        print("onVerticalDragUpdate y : ${details.delta.dy}");
                        if (settingController.dimmer.value) {
                          if (details.delta.dy < 0 && details.delta.dx == 0) {
                            homeController.isVisible.value = true;
                            if (homeController.currentSliderValue.value.toDouble() < 1) {
                              homeController.currentSliderValue.value += 0.01;
                            } else if (homeController.currentSliderValue.value.isNegative ||
                                homeController.currentSliderValue.value <= 0.9) {
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
                          } else if (details.delta.dx > 0 && details.delta.dy == 0) {
                            homeController.isVisible.value = false;
                            if (homeController.currentSliderValueForColor.value.toDouble() < 1) {
                              homeController.currentSliderValueForColor.value += 0.05;
                            } else if (homeController.currentSliderValueForColor.value.isNegative ||
                                homeController.currentSliderValueForColor.value <= 0.9) {
                              homeController.currentSliderValueForColor.value = 1.0;
                            }
                          } else if (details.delta.dx < 0 && details.delta.dy == 0) {
                            homeController.isVisible.value = false;
                            if (homeController.currentSliderValueForColor.value.toDouble() > 0.1) {
                              homeController.currentSliderValueForColor.value -= 0.05;
                            } else if (homeController.currentSliderValueForColor.value.isNegative &&
                                homeController.currentSliderValueForColor.value.toDouble() <= 0.1) {
                              homeController.currentSliderValueForColor.value = 0.0;
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
    );
  }
}
