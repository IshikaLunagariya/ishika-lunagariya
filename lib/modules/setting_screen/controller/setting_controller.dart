import 'package:clock_simple/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get to => SettingController();
  RxBool preventLocking = false.obs;
  RxBool dimmer = false.obs;
  RxBool hourFormat = false.obs;
  RxBool leadingZero = true.obs;
  RxBool intervalSwitch = false.obs;
  RxBool secondsUntil = false.obs;
  TextEditingController minutesController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  String dropdownvalue = '0 Second';

  var secondList = ["0 Second", "15 Seconds", "30 Seconds", "45 Seconds", "60 Seconds"];

  @override
  void onInit() {
    preventLocking.value = Preferences.instance.prefs?.getBool("preventLocking") ?? false;
    dimmer.value = Preferences.instance.prefs?.getBool("dimmer") ?? false;
    hourFormat.value = Preferences.instance.prefs?.getBool("hourFormat") ?? false;
    leadingZero.value = Preferences.instance.prefs?.getBool("leadingZero") ?? true;
    intervalSwitch.value = Preferences.instance.prefs?.getBool("intervalSwitch") ?? false;
    secondsUntil.value = Preferences.instance.prefs?.getBool("secondsUntil") ?? false;
    super.onInit();
  }
}
