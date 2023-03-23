import 'package:clock_simple/modules/setting_screen/controller/setting_controller.dart';
import 'package:clock_simple/utils/app_color.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:clock_simple/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../widget/custom_switch.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Obx(() {
          return Stack(
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
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeUtils.horizontalBlockSize * 15, vertical: SizeUtils.verticalBlockSize * 10),
                      child: Column(
                        children: [
                          CustomSwitchWidget(
                            title: AppString.preventLocking,
                            subTitle: AppString.preventLockingDes,
                            onChange: (value) async {
                              settingController.preventLocking.value = value;
                              await Preferences.instance.prefs
                                  ?.setBool("preventLocking", settingController.preventLocking.value);
                            },
                            value: settingController.preventLocking.value,
                          ),
                          CustomSwitchWidget(
                            title: AppString.dimmer,
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
                            title: AppString.hourFormate,
                            onChange: (value) async {
                              settingController.hourFormat.value = value;
                              await Preferences.instance.prefs
                                  ?.setBool("hourFormat", settingController.hourFormat.value);
                            },
                            value: settingController.hourFormat.value,
                          ),
                          CustomSwitchWidget(
                            title: AppString.leadingZero,
                            onChange: (value) async {
                              settingController.leadingZero.value = value;
                              await Preferences.instance.prefs
                                  ?.setBool("leadingZero", settingController.leadingZero.value);
                            },
                            value: settingController.leadingZero.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
