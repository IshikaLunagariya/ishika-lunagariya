import 'dart:async';
import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

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
  String dropDownValue = '0 Second';

  var secondList = ["0 Second", "15 Seconds", "30 Seconds", "45 Seconds", "60 Seconds"];

  Timer? timer;
  final alarmSettings = AlarmSettings(
    id: 42,
    dateTime: DateTime.now(),
    assetAudioPath: 'assets/',
    loopAudio: false,
    vibrate: false,
    fadeDuration: 3.0,
    notificationTitle: 'This is the title',
    notificationBody: 'This is the body',
    enableNotificationOnKill: true,
  );

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

  setMinuteIntervalRemainder({int? minutes}) {
    timer = Timer.periodic(Duration(minutes: minutes ?? 1), (Timer t) async {
      if (SizeUtils.screenHeight < 300) {
        Vibration.vibrate(duration: 4000, repeat: 200, amplitude: 128);
      } else {
        print("Interval $minutes");
        // Vibration.vibrate(duration: 4000, repeat: 200, amplitude: 128);
      }
    });
  }

  setIntervalRemainder({int? minutes, int? second}) {
    int minuteToSecond = Duration(minutes: minutes ?? 1).inSeconds;
    int finalSecond = minuteToSecond - (second ?? 0);

    timer = Timer.periodic(Duration(seconds: finalSecond), (Timer t) async {
      if (SizeUtils.screenHeight < 300) {
        Vibration.vibrate(duration: 4000, repeat: 200, amplitude: 100);
      } else {
        log("Interval $finalSecond $minuteToSecond");
        // Vibration.vibrate(duration: 4000, repeat: 200, amplitude: 100);
        // await Alarm.set(alarmSettings: alarmSettings).then((value) async {
        //   await Alarm.setNotificationOnAppKillContent("Interval", "body");
        //   await Alarm.stop(42);
        // });
      }
    });
    /*Timer.periodic(Duration(seconds: finalSecond), (Timer t) {
      log("Interval $finalSecond");
      Fluttertoast.showToast(
          msg: "Interval",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    });*/
  }
}
/*
setMinuteIntervalRemainder({int? minutes, int? second}) {
  timer = Timer.periodic(Duration(minutes: minutes ?? 1), (Timer t) async {
    if(SizeUtils.screenHeight < 300){
      Vibration.vibrate();
    }else{
      Vibration.vibrate();
    }
  });
}
setSecondIntervalRemainder({int? second}) {
  timer = Timer.periodic(Duration(seconds: second ?? 0), (Timer t) async {
    if(SizeUtils.screenHeight < 300){
      Vibration.vibrate();
    }else{
      Vibration.vibrate();
    }
  });
}*/
