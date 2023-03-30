import 'package:alarm/alarm.dart';
import 'package:clock_simple/modules/home_screen/controller/home_controller.dart';
import 'package:clock_simple/utils/navigation_utils/navigation.dart';
import 'package:clock_simple/utils/navigation_utils/routes.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
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
                size: SizeUtils.screenHeight < 300 ? 10 : 30,
              ),
            ),
          )),
      body: Obx(() => Center(
            child: Container(
              height: SizeUtils.screenHeight,
              width: SizeUtils.screenWidth,
              color: Colors.black.withOpacity(homeController.currentSliderValueForColor.value),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.verticalBlockSize * 9, horizontal: SizeUtils.verticalBlockSize * 2),
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
                                    width: SizeUtils.screenHeight < 300 ? 50 : 130,
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
                                fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_50() : SizeUtils.fSize_60(),
                                color: (homeController.currentSliderValueForColor.value <= 0.5)
                                    ? Colors.black.withOpacity(homeController.currentSliderValue.value)
                                    : AppColor.whiteColor.withOpacity(homeController.currentSliderValue.value)),
                            children: <TextSpan>[
                              TextSpan(
                                text: " ${homeController.timeString.value.toString().substring(9, 11)}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize:
                                        SizeUtils.screenHeight < 300 ? SizeUtils.fSize_20() : SizeUtils.fSize_24(),
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
                      behavior: HitTestBehavior.opaque,
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
                      onPanUpdate: (DragUpdateDetails details) {
                        homeController.changeBrightness(
                          dimmer: settingController.dimmer.value,
                          details: details,
                        );
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Transform.scale(
                            scale: SizeUtils.screenHeight < 300 ? 0.4 : 1,
                            child: IconButton(
                              onPressed: () async {
                                settingController.isAlarm.value = false;
                                settingController.minutesController.clear();
                                settingController.secondController.clear();
                                settingController.secondTimer?.cancel();
                                settingController.minuteTimer?.cancel();
                                Alarm.stop(42);
                                // FlutterRingtonePlayer.stop();
                                // Vibration.cancel();
                                // settingController.alarmPlugin.deleteAllAlarms();
                                await Preferences.instance.prefs?.setBool("isAlarm", settingController.isAlarm.value);
                              },
                              icon: Icon(
                                settingController.isAlarm.value ? Icons.notifications : Icons.notifications_off,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                            /*CupertinoSwitch(
                            value: settingController.isAlarm.value,
                            onChanged: (value) async {
                              settingController.isAlarm.value = false;
                              settingController.minutesController.clear();
                              settingController.secondController.clear();
                              settingController.secondTimer?.cancel();
                              settingController.minuteTimer?.cancel();
                              FlutterRingtonePlayer.stop();
                              Vibration.cancel();
                              // settingController.alarmPlugin.deleteAllAlarms();
                              await Preferences.instance.prefs?.setBool("isAlarm", settingController.isAlarm.value);
                            },
                            thumbColor: Colors.white,
                            activeColor: Colors.grey,
                          ),*/
                            ),
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
