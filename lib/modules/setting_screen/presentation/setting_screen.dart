import 'package:clock_simple/modules/setting_screen/controller/setting_controller.dart';
import 'package:clock_simple/utils/app_color.dart';
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
                          horizontal: SizeUtils.horizontalBlockSize * 20, vertical: SizeUtils.verticalBlockSize * 10),
                      child: Column(
                        children: [
                          CustomSwitchWidget(
                            title: AppString.preventLocking,
                            subTitle: AppString.preventLockingDes,
                            onChange: (value) {
                              settingController.preventLocking.value = value;
                            },
                            value: settingController.preventLocking.value,
                          ),
                          CustomSwitchWidget(
                            title: AppString.dimmer,
                            subTitle: AppString.dimmerDes,
                            onChange: (value) {
                              settingController.dimmer.value = value;
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
                            onChange: (value) {
                              settingController.hourFormate.value = value;
                            },
                            value: settingController.hourFormate.value,
                          ),
                          CustomSwitchWidget(
                            title: AppString.leadingZero,
                            onChange: (value) {
                              settingController.leadingZero.value = value;
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
