import 'dart:developer';

import 'package:clock_simple/modules/setting_screen/controller/setting_controller.dart';
import 'package:clock_simple/utils/app_color.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:clock_simple/utils/string_utils.dart';
import 'package:clock_simple/widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../widget/custom_switch.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 5),
          child: Obx(() {
            return Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    // Navigation.pushNamed(Routes.homeScreen);
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        Navigation.pushNamed(Routes.homeScreen);
                      },
                      icon: Icon(Icons.close, color: AppColor.whiteColor),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width / 6, vertical: Get.height / 12),
                      child: Column(
                        children: [
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.preventLocking,
                              color: AppColor.whiteColor,
                              fontSize: 17,
                            ),
                            subTitle: AppString.preventLockingDes,
                            onChange: (value) async {
                              settingController.preventLocking.value = value;
                              await Preferences.instance.prefs?.setBool("preventLocking", settingController.preventLocking.value);
                            },
                            value: settingController.preventLocking.value,
                          ),
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.dimmer,
                              color: AppColor.whiteColor,
                              fontSize: 17,
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
                              fontSize: 17,
                            ),
                            onChange: (value) async {
                              settingController.hourFormat.value = value;
                              await Preferences.instance.prefs?.setBool("hourFormat", settingController.hourFormat.value);
                            },
                            value: settingController.hourFormat.value,
                          ),
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.leadingZero,
                              color: AppColor.whiteColor,
                              fontSize: 17,
                            ),
                            onChange: (value) async {
                              settingController.leadingZero.value = value;
                              await Preferences.instance.prefs?.setBool("leadingZero", settingController.leadingZero.value);
                            },
                            value: settingController.leadingZero.value,
                          ),
                          Divider(
                            color: AppColor.gray,
                            height: SizeUtils.verticalBlockSize * 7,
                            thickness: 1,
                          ),
                          CustomSwitchWidget(
                            title: SizedBox(
                              width: 100,
                              height: 20,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(2),
                                  FilteringTextInputFormatter.deny(" "),
                                  FilteringTextInputFormatter.deny("."),
                                ],
                                toolbarOptions: const ToolbarOptions(
                                  selectAll: false,
                                  cut: false,
                                  copy: false,
                                  paste: false,
                                ),
                                cursorColor: AppColor.whiteColor,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                onTap: () {
                                  settingController.minutesController.clear();
                                },
                                onChanged: (value) {
                                  settingController.minutesController.clear();
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
                                      minutes: int.parse(
                                        settingController.minutesController.text,
                                      ),
                                    );
                                  }
                                },
                                readOnly: settingController.intervalSwitch.value ? false : true,
                                decoration: InputDecoration(
                                  hintText: settingController.intervalSwitch.value
                                      ? settingController.minutesController.text ?? "Type Minute"
                                      : AppString.interval,
                                  hintStyle: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // title: AppText(
                            //   text: AppString.interval,
                            //   color: AppColor.whiteColor,
                            //   fontSize: 17,
                            // ),
                            onChange: (value) async {
                              settingController.intervalSwitch.value = value;
                              await Preferences.instance.prefs?.setBool("intervalSwitch", settingController.intervalSwitch.value);
                              settingController.minutesController.text = "Type Minute";
                            },
                            value: settingController.intervalSwitch.value,
                          ),
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.secondsUntil,
                              color: AppColor.whiteColor,
                              fontSize: 17,
                            ),
                            onChange: (value) async {
                              settingController.secondsUntil.value = value;
                              await Preferences.instance.prefs?.setBool("secondsUntil", settingController.secondsUntil.value);
                            },
                            value: settingController.secondsUntil.value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget customTextField({required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(),
    );
  }
}
