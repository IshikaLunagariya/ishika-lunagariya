import 'dart:developer';

import 'package:clock_simple/utils/navigation_utils/navigation.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/string_utils.dart';
import 'package:clock_simple/widget/app_text.dart';
import 'package:clock_simple/widget/custom_keyboard_screen.dart';
import 'package:clock_simple/widget/custom_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../utils/size_utils.dart';
import '../../../widget/custom_text_feild.dart';
import '../../home_screen/controller/limit_range_text_input formatter.dart';
import '../controller/setting_controller.dart';

class PotraitView extends StatelessWidget {
  PotraitView({Key? key}) : super(key: key);
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
                    Navigation.pushNamed(Routes.homeScreen);
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
                      padding: SizeUtils.screenHeight < 300
                          ? EdgeInsets.symmetric(horizontal: Get.width / 6, vertical: Get.height / 37)
                          : EdgeInsets.symmetric(horizontal: Get.width / 6, vertical: Get.height / 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.preventLocking,
                              color: AppColor.whiteColor,
                              fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
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
                            height: SizeUtils.verticalBlockSize * 2,
                          ),
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.dimmer,
                              color: AppColor.whiteColor,
                              fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
                            ),
                            subTitle: AppString.dimmerDes,
                            onChange: (value) async {
                              settingController.dimmer.value = value;
                              await Preferences.instance.prefs?.setBool("dimmer", settingController.dimmer.value);
                            },
                            value: settingController.dimmer.value,
                          ),
                          Divider(
                            color: AppColor.gray,
                            height: SizeUtils.verticalBlockSize * 7,
                            thickness: 1,
                          ),
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.hourFormate,
                              color: AppColor.whiteColor,
                              fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
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
                              fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
                            ),
                            onChange: (value) async {
                              settingController.leadingZero.value = value;
                              await Preferences.instance.prefs
                                  ?.setBool("leadingZero", settingController.leadingZero.value);
                            },
                            value: settingController.leadingZero.value,
                          ),
                          Divider(
                            color: AppColor.gray,
                            height: SizeUtils.verticalBlockSize * 4,
                            thickness: 1,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: SizeUtils.screenHeight < 300 ? 20 : 25,
                                child: CustomTextFormField(
                                  readOnly: true,
                                  onTap: () {
                                    settingController.minutesController.clear();
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
                                  textInputAction: TextInputAction.done,
                                  textSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
                                  style: TextStyle(color: Colors.white),
                                  controller: settingController.minutesController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(2),
                                    FilteringTextInputFormatter.deny(" "),
                                    FilteringTextInputFormatter.deny("."),
                                    LimitRangeTextInputFormatter(1, 60),
                                  ],
                                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                  onFieldSubmitted: (value) async {
                                    settingController.isAlarm.value = true;
                                    settingController.minutesController.clear();
                                    settingController.minutesController.text = value;
                                    // settingController.alarmPlugin.deleteAllAlarms();
                                    log("Set Interval");
                                    settingController.secondTimer?.cancel();
                                    settingController.minuteTimer?.cancel();
                                    settingController.setMinuteIntervalRemainder(
                                      minutes: int.parse(settingController.minutesController.text),
                                    );
                                    await Preferences.instance.prefs
                                        ?.setString("minutes", settingController.minutesController.text);
                                  },
                                  hintColor: AppColor.whiteColor,
                                  hint: "00",
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
                                      fontSize: SizeUtils.fSize_17(),
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
                                child: CustomTextFormField(
                                  onTap: () {
                                    settingController.secondController.clear();
                                  },
                                  readOnly: true,
                                  textInputAction: TextInputAction.done,
                                  textSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
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
                                    settingController.secondTimer?.cancel();
                                    settingController.minuteTimer?.cancel();
                                    // settingController.alarmPlugin.deleteAllAlarms();
                                    settingController.setMinuteIntervalRemainder(
                                      minutes: int.parse(settingController.minutesController.text),
                                    );
                                    settingController.setIntervalRemainder(
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
                                      fontSize: SizeUtils.fSize_17(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: AppText(
                                        text: AppString.inSeconds,
                                        color: AppColor.gray,
                                        fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_12() : 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          /*  CustomSwitchWidget(
                            title: settingController.intervalSwitch.value
                                ? SizedBox(
                                    width: SizeUtils.screenHeight < 300 ? 70 : 100,
                                    height: 20,
                                    child: CustomTextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(2),
                                        FilteringTextInputFormatter.deny(" "),
                                        FilteringTextInputFormatter.deny("."),
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        settingController.minutesController.text = value;
                                      },
                                      onFieldSubmitted: (value) {
                                        if (value.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg: "Enter Number",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              fontSize: 16.0);
                                        } else if (int.parse(value) > 60 || int.parse(value) < 1) {
                                          Fluttertoast.showToast(
                                              msg: "Enter valid Number",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              fontSize: 16.0);
                                        } else {
                                          settingController.minutesController.clear();
                                          settingController.minutesController.text = value;
                                          log("Set Interval");

                                          settingController.setIntervalRemainder(
                                            minutes: int.parse(settingController.minutesController.text),
                                            second: int.parse(settingController.dropDownValue.split(" ").first),
                                          );
                                        }
                                      },
                                      hint: "Type Minute",
                                      hintColor: AppColor.whiteColor,
                                    ),
                                  )
                                : AppText(
                                    text: AppString.interval,
                                    color: AppColor.whiteColor,
                                    fontSize: SizeUtils.screenHeight < 600 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
                                  ),
                            onChange: (value) async {
                              settingController.intervalSwitch.value = value;
                              await Preferences.instance.prefs?.setBool("intervalSwitch", settingController.intervalSwitch.value);
                            },
                            value: settingController.intervalSwitch.value,
                          ),
                          CustomSwitchWidget(
                            title: settingController.secondsUntil.value
                                ? DropdownButton<String>(
                                    isExpanded: false,
                                    alignment: Alignment.center,
                                    value: settingController.dropDownValue,
                                    items: settingController.secondList.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: AppText(
                                          text: items,
                                          color: AppColor.blackColor,
                                          fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      settingController.dropDownValue = newValue!;
                                      settingController.setIntervalRemainder(
                                        minutes: int.parse(settingController.minutesController.text),
                                        second: int.parse(settingController.dropDownValue.split(" ").first),
                                      );
                                    },
                                    selectedItemBuilder: (context) {
                                      return settingController.secondList.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: AppText(
                                            text: items,
                                            color: AppColor.whiteColor,
                                            fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
                                          ),
                                        );
                                      }).toList();
                                    },
                                  )
                                : AppText(
                                    text: AppString.secondsUntil,
                                    color: AppColor.whiteColor,
                                    fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_15() : SizeUtils.fSize_20(),
                                  ),
                            onChange: (value) async {
                              settingController.secondsUntil.value = value;
                              await Preferences.instance.prefs?.setBool("secondsUntil", settingController.secondsUntil.value);
                            },
                            value: settingController.secondsUntil.value,
                          ),*/
                          CustomKeyboard(onTextInput: (myText) {
                            settingController.insertText(
                              myText,
                              settingController.minutesController,
                            );
                          }, onBackspace: () {
                            settingController.backspace(settingController.minutesController);
                          }, onSubmit: ((value) async {
                            settingController.isAlarm.value = true;
                            settingController.minutesController.clear();
                            settingController.minutesController.text = value;
                            // settingController.alarmPlugin.deleteAllAlarms();
                            log("Set Interval");
                            settingController.secondTimer?.cancel();
                            settingController.minuteTimer?.cancel();
                            settingController.setMinuteIntervalRemainder(
                              minutes: int.parse(settingController.minutesController.text),
                            );
                            await Preferences.instance.prefs
                                ?.setString("minutes", settingController.minutesController.text);
                          })),
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
