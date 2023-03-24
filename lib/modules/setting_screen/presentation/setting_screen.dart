import 'package:clock_simple/modules/setting_screen/controller/setting_controller.dart';
import 'package:clock_simple/utils/app_color.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:clock_simple/utils/string_utils.dart';
import 'package:clock_simple/widget/app_text.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 6),
        child: Obx(() {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                              fontSize: SizeUtils.fSize_17(),
                            ),
                            subTitle: AppString.preventLockingDes,
                            onChange: (value) async {
                              settingController.preventLocking.value = value;
                              await Preferences.instance.prefs
                                  ?.setBool("preventLocking", settingController.preventLocking.value);
                            },
                            value: settingController.preventLocking.value,
                          ),
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.dimmer,
                              color: AppColor.whiteColor,
                              fontSize: SizeUtils.fSize_17(),
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
                              fontSize: SizeUtils.fSize_17(),
                            ),
                            onChange: (value) async {
                              settingController.hourFormat.value = value;
                              await Preferences.instance.prefs
                                  ?.setBool("hourFormat", settingController.hourFormat.value);
                            },
                            value: settingController.hourFormat.value,
                          ),
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.leadingZero,
                              color: AppColor.whiteColor,
                              fontSize: SizeUtils.fSize_17(),
                            ),
                            onChange: (value) async {
                              settingController.leadingZero.value = value;
                              await Preferences.instance.prefs
                                  ?.setBool("leadingZero", settingController.leadingZero.value);
                            },
                            value: settingController.leadingZero.value,
                          ),
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.interval,
                              color: AppColor.whiteColor,
                              fontSize: SizeUtils.fSize_17(),
                            ),
                            onChange: (value) async {
                              settingController.intervalSwitch.value = value;
                              await Preferences.instance.prefs
                                  ?.setBool("intervalSwitch", settingController.intervalSwitch.value);
                            },
                            value: settingController.intervalSwitch.value,
                          ),
                          CustomSwitchWidget(
                            title: AppText(
                              text: AppString.secondsUntil,
                              color: AppColor.whiteColor,
                              fontSize: SizeUtils.fSize_17(),
                            ),
                            onChange: (value) async {
                              settingController.secondsUntil.value = value;
                              await Preferences.instance.prefs
                                  ?.setBool("secondsUntil", settingController.secondsUntil.value);
                            },
                            value: settingController.secondsUntil.value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget customTextField({required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(),
    );
  }
}
