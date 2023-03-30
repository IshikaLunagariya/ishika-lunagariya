import 'package:clock_simple/modules/setting_screen/controller/setting_controller.dart';
import 'package:clock_simple/modules/setting_screen/presentation/landscape_view.dart';
import 'package:clock_simple/modules/setting_screen/presentation/potrait_view.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:clock_simple/widget/custom_keyboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        bottomSheet: (settingController.intervalSwitch.value || settingController.secondsUntil.value)
            ? CustomKeyboard(onTextInput: (myText) {
                settingController.insertText(
                  myText,
                  settingController.secondsUntil.value
                      ? settingController.secondController
                      : settingController.minutesController,
                );
              }, onBackspace: () {
                settingController.backspace(
                  settingController.secondsUntil.value
                      ? settingController.secondController
                      : settingController.minutesController,
                );
              }, onSubmit: (() async {
                settingController.isAlarm.value = true;
                // settingController.secondController.clear();
                // settingController.minutesController.clear();
                settingController.secondTimer?.cancel();
                settingController.minuteTimer?.cancel();
                if (settingController.secondsUntil.value) {
                  settingController.secondsUntil.value = false;
                  settingController.setMinuteIntervalRemainder(
                    minutes: int.parse(settingController.minutesController.text),
                  );
                  settingController.setSecondIntervalRemainder(
                    minutes: int.parse(settingController.minutesController.text),
                    second: int.parse(settingController.secondController.text),
                  );
                  await Preferences.instance.prefs?.setString("seconds", settingController.secondController.text);
                  await Preferences.instance.prefs?.setString("minutes", settingController.minutesController.text);
                } else if (settingController.intervalSwitch.value) {
                  print("set intermnam in minute");
                  settingController.intervalSwitch.value = false;
                  settingController.setMinuteIntervalRemainder(
                    minutes: int.parse(settingController.minutesController.text),
                  );
                  await Preferences.instance.prefs?.setString("minutes", settingController.minutesController.text);
                }
              }))
            : const SizedBox(),
        body: OrientationBuilder(builder: (context, orientation) {
          return SizeUtils.screenHeight < 300
              ? PotraitView()
              : orientation == Orientation.portrait
                  ? PotraitView()
                  : LandscapeView();
        }),
      ),
    );
  }
}
