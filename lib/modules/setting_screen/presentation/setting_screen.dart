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
    SizeUtils().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                Navigation.pushNamed(Routes.homeScreen);
              },
              icon: Icon(Icons.close, color: AppColor.whiteColor),
            ),
            CustomSwitchWidget(
              title: AppString.preventLocking,
              subTitle: AppString.preventLockingDes,
              onChange: (value) {
                settingController.preventLocking.value = value;
              },
              value: settingController.preventLocking.value,
            ),
          ],
        ),
      ),
    );
  }
}
