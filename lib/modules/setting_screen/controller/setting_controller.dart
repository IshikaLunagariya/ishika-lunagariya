import 'dart:async';
import 'dart:developer';

import 'package:clock_simple/utils/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  setIntervalRemainder({int? minutes, int? second}) {
    int minuteToSecond = Duration(minutes: minutes ?? 1).inSeconds;
    int finalSecond = minuteToSecond - (second ?? 0);
    Timer.periodic(Duration(seconds: finalSecond), (Timer t) {
      log("Interval");
      Fluttertoast.showToast(
          msg: "Interval",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    });
  }
}
