import 'package:clock_simple/utils/navigation_utils/navigation.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/string_utils.dart';
import 'package:clock_simple/widget/app_text.dart';
import 'package:clock_simple/widget/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../utils/size_utils.dart';
import '../../home_screen/controller/limit_range_text_input formatter.dart';
import '../controller/setting_controller.dart';

class LandscapeView extends StatelessWidget {
  LandscapeView({Key? key}) : super(key: key);
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.horizontalBlockSize * 7,
            ),
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (settingController.intervalSwitch.value || settingController.secondsUntil.value) {
                      settingController.intervalSwitch.value = false;
                      settingController.secondsUntil.value = false;
                    } else {
                      Navigation.pushNamed(Routes.homeScreen);
                    }
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.screenHeight < 300 ? SizeUtils.horizontalBlockSize * 7 : 0,
                      ),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          Navigation.pushNamed(Routes.homeScreen);
                        },
                        icon: Icon(
                          Icons.close,
                          color: AppColor.whiteColor,
                          size: SizeUtils.screenHeight < 300 ? 10 : 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 6, vertical: Get.height / 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomSwitchWidget(
                                title: AppText(
                                  text: AppString.preventLocking,
                                  color: AppColor.whiteColor,
                                  fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_9(),
                                ),
                                subTitle: AppString.preventLockingDes,
                                onChange: (value) async {
                                  settingController.preventLocking.value = value;
                                  await Preferences.instance.prefs
                                      ?.setBool("preventLocking", settingController.preventLocking.value);
                                },
                                value: settingController.preventLocking.value,
                              ),
                              SizedBox(
                                height: SizeUtils.verticalBlockSize * 4,
                              ),
                              CustomSwitchWidget(
                                title: AppText(
                                  text: AppString.dimmer,
                                  color: AppColor.whiteColor,
                                  fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_9(),
                                ),
                                subTitle: AppString.dimmerDes,
                                onChange: (value) async {
                                  settingController.dimmer.value = value;
                                  await Preferences.instance.prefs?.setBool("dimmer", settingController.dimmer.value);
                                },
                                value: settingController.dimmer.value,
                              ),
                            ],
                          ),
                          Container(
                            color: AppColor.whiteColor,
                            width: 1,
                            height: 250,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSwitchWidget(
                                title: AppText(
                                  text: AppString.hourFormate,
                                  color: AppColor.whiteColor,
                                  fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_9(),
                                ),
                                onChange: (value) async {
                                  settingController.hourFormat.value = value;
                                  await Preferences.instance.prefs
                                      ?.setBool("hourFormat", settingController.hourFormat.value);
                                },
                                value: settingController.hourFormat.value,
                              ),
                              SizedBox(
                                height: SizeUtils.verticalBlockSize * 2,
                              ),
                              CustomSwitchWidget(
                                title: AppText(
                                  text: AppString.leadingZero,
                                  color: AppColor.whiteColor,
                                  fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_9(),
                                ),
                                onChange: (value) async {
                                  settingController.leadingZero.value = value;
                                  await Preferences.instance.prefs
                                      ?.setBool("leadingZero", settingController.leadingZero.value);
                                },
                                value: settingController.leadingZero.value,
                              ),
                              // Divider(
                              //   color: AppColor.whiteColor,
                              //   // height: SizeUtils.verticalBlockSize * 7,
                              //   thickness: 5,
                              // ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: SizeUtils.screenHeight < 300 ? 20 : 25,
                                    child: TextField(
                                      readOnly: true,
                                      cursorColor: Colors.white,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        hintText: "01",
                                        hintStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        hintMaxLines: 1,
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        // settingController.minutesController.clear();
                                        settingController.intervalSwitch.value = true;
                                        settingController.secondsUntil.value = false;

                                        // CustomKeyboard(onTextInput: (myText) {
                                        //   settingController.insertText(
                                        //     myText,
                                        //     settingController.minutesController,
                                        //   );
                                        // }, onBackspace: () {
                                        //   settingController.backspace(settingController.minutesController);
                                        // }, onSubmit: ((value) async {
                                        //   settingController.isAlarm.value = true;
                                        //   settingController.minutesController.clear();
                                        //   settingController.minutesController.text = value;
                                        //   // settingController.alarmPlugin.deleteAllAlarms();
                                        //   log("Set Interval");
                                        //   settingController.secondTimer?.cancel();
                                        //   settingController.minuteTimer?.cancel();
                                        //   settingController.setMinuteIntervalRemainder(
                                        //     minutes: int.parse(settingController.minutesController.text),
                                        //   );
                                        //   await Preferences.instance.prefs
                                        //       ?.setString("minutes", settingController.minutesController.text);
                                        // }));
                                      },
                                      // textInputAction: TextInputAction.done,
                                      // textSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
                                      style: const TextStyle(color: Colors.white, fontSize: 20),
                                      controller: settingController.minutesController,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.digitsOnly,
                                      //   LengthLimitingTextInputFormatter(2),
                                      //   FilteringTextInputFormatter.deny(" "),
                                      //   FilteringTextInputFormatter.deny("."),
                                      //   LimitRangeTextInputFormatter(1, 60),
                                      // ],
                                      // keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                      // onFieldSubmitted: (value) async {
                                      //   settingController.isAlarm.value = true;
                                      //   await Preferences.instance.prefs
                                      //       ?.setBool("isAlarm", settingController.isAlarm.value);
                                      //   settingController.minutesController.clear();
                                      //   settingController.minutesController.text = value;
                                      //   // settingController.alarmPlugin.deleteAllAlarms();
                                      //   log("Set Interval");
                                      //   settingController.secondTimer?.cancel();
                                      //   settingController.minuteTimer?.cancel();
                                      //   settingController.setMinuteIntervalRemainder(
                                      //     minutes: int.parse(settingController.minutesController.text),
                                      //   );
                                      //   await Preferences.instance.prefs
                                      //       ?.setString("minutes", settingController.minutesController.text);
                                      // },
                                      // hintColor: AppColor.whiteColor,
                                      // hint: "00",
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: SizeUtils.screenHeight < 300 ? 4 : 0,
                                        horizontal: SizeUtils.screenHeight < 300 ? 8 : 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: AppString.interval,
                                          color: AppColor.whiteColor,
                                          fontSize: SizeUtils.fSize_9(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: AppText(
                                            text: AppString.inMinutes,
                                            color: AppColor.gray,
                                            fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_12() : 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeUtils.verticalBlockSize * 2,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: SizeUtils.screenHeight < 300 ? 20 : 25,
                                    child: /*CustomTextFormField(
                                      textInputAction: TextInputAction.done,
                                      textSize: SizeUtils.screenHeight < 300 ? 15 : 20,
                                      controller: settingController.secondController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(2),
                                        FilteringTextInputFormatter.deny(" "),
                                        FilteringTextInputFormatter.deny("."),
                                        LimitRangeTextInputFormatter(0, 60),
                                      ],
                                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                      onFieldSubmitted: (value) async {
                                        settingController.isAlarm.value = true;
                                        settingController.secondController.clear();
                                        settingController.secondController.text = value;
                                        log("Set Interval");
                                        // settingController.alarmPlugin.deleteAllAlarms();
                                        settingController.secondTimer?.cancel();
                                        settingController.minuteTimer?.cancel();
                                        settingController.setMinuteIntervalRemainder(
                                          minutes: int.parse(settingController.minutesController.text),
                                        );
                                        settingController.setSecondIntervalRemainder(
                                          minutes: int.parse(settingController.minutesController.text),
                                          second: int.parse(settingController.secondController.text),
                                        );
                                        await Preferences.instance.prefs
                                            ?.setString("seconds", settingController.secondController.text);
                                        await Preferences.instance.prefs
                                            ?.setString("minutes", settingController.minutesController.text);
                                      },
                                      hint: "00",
                                      hintColor: AppColor.whiteColor,
                                    ),*/
                                        TextField(
                                      cursorColor: Colors.white,
                                      showCursor: true,
                                      style: const TextStyle(color: Colors.white, fontSize: 20),
                                      decoration: InputDecoration(
                                        hintText: "00",
                                        hintStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        hintMaxLines: 1,
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        // settingController.secondController.clear();
                                        if (settingController.minutesController.text.isEmpty) {
                                          settingController.intervalSwitch.value = false;
                                          settingController.secondsUntil.value = false;
                                        } else {
                                          settingController.secondsUntil.value = true;
                                        }
                                        // showModalBottomSheet(
                                        //     context: context,
                                        //     builder: (context) {
                                        //       return CustomKeyboard(onTextInput: (myText) {
                                        //         settingController.insertText(
                                        //           myText,
                                        //           settingController.secondController,
                                        //         );
                                        //       }, onBackspace: () {
                                        //         settingController.backspace(settingController.secondController);
                                        //       }, onSubmit: (() async {
                                        //         print("Hello");
                                        //         settingController.isAlarm.value = true;
                                        //         // settingController.secondController.clear();
                                        //
                                        //         log("Set Interval");
                                        //         settingController.secondTimer?.cancel();
                                        //         settingController.minuteTimer?.cancel();
                                        //         // settingController.setMinuteIntervalRemainder(
                                        //         //   minutes: int.parse(settingController.minutesController.text),
                                        //         // );
                                        //         // await Preferences.instance.prefs
                                        //         //     ?.setString("minutes", settingController.minutesController.text);
                                        //       }));
                                        //     });
                                      },
                                      readOnly: true,
                                      textInputAction: TextInputAction.done,

                                      // textSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
                                      controller: settingController.secondController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(2),
                                        FilteringTextInputFormatter.deny(" "),
                                        FilteringTextInputFormatter.deny("."),
                                        LimitRangeTextInputFormatter(0, 60),
                                      ],
                                      keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                      onChanged: (value) {
                                        print("value---->$value");
                                      },

                                      // onFieldSubmitted: (value) async {
                                      //   settingController.isAlarm.value = true;
                                      //   await Preferences.instance.prefs
                                      //       ?.setBool("isAlarm", settingController.isAlarm.value);
                                      //   settingController.secondController.clear();
                                      //   settingController.secondController.text = value;
                                      //   log("Set Interval");
                                      //   settingController.secondTimer?.cancel();
                                      //   settingController.minuteTimer?.cancel();
                                      //   settingController.setMinuteIntervalRemainder(
                                      //     minutes: int.parse(settingController.minutesController.text),
                                      //   );
                                      //   settingController.setSecondIntervalRemainder(
                                      //     minutes: int.parse(settingController.minutesController.text),
                                      //     second: int.parse(settingController.secondController.text),
                                      //   );
                                      //   await Preferences.instance.prefs
                                      //       ?.setString("seconds", settingController.secondController.text);
                                      //   await Preferences.instance.prefs
                                      //       ?.setString("minutes", settingController.minutesController.text);
                                      // },
                                      // hint: "00",
                                      // hintColor: AppColor.whiteColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: SizeUtils.screenHeight < 300 ? 4 : 0,
                                        horizontal: SizeUtils.screenHeight < 300 ? 8 : 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: AppString.secondsUntil,
                                          color: AppColor.whiteColor,
                                          fontSize: SizeUtils.fSize_9(),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: AppText(
                                            text: AppString.inSeconds,
                                            color: AppColor.gray,
                                            fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_12() : 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
