import 'dart:async';
import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
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
  RxBool isAlarm = false.obs;
  TextEditingController minutesController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  String dropDownValue = '0 Second';

  var secondList = ["0 Second", "15 Seconds", "30 Seconds", "45 Seconds", "60 Seconds"];

  Timer? secondTimer;
  Timer? minuteTimer;
  final alarmSettings = AlarmSettings(
    id: 42,
    dateTime: DateTime.now(),
    assetAudioPath: 'assets/beep_alarm.mp3',
    loopAudio: false,
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
    isAlarm.value = Preferences.instance.prefs?.getBool("isAlarm") ?? false;
    minutesController.text = Preferences.instance.prefs?.getString("minutes") ?? "01";
    secondController.text = Preferences.instance.prefs?.getString("seconds") ?? "00";
    super.onInit();
  }

  setMinuteIntervalRemainder({int? minutes}) {
    minuteTimer = Timer.periodic(Duration(minutes: minutes ?? 1), (Timer t) async {
      if (SizeUtils.screenHeight < 300) {
        Vibration.vibrate(duration: 4000, repeat: 20, amplitude: 128);
      } else {
        Vibration.vibrate(duration: 4000, repeat: 20, amplitude: 128);
        FlutterRingtonePlayer.play(looping: false, volume: 1, asAlarm: true, fromAsset: 'assets/beep_alarm.mp3');
        setIntervalRemainder(
            minutes: int.parse(minutesController.text), second: secondController.text.isEmpty ? 0 : int.parse(secondController.text));
      }
    });
  }

  setIntervalRemainder({int? minutes, int? second}) {
    int minuteToSecond = Duration(minutes: minutes ?? 1).inSeconds;
    int finalSecond = minuteToSecond - (second ?? 0);

    secondTimer = Timer.periodic(Duration(seconds: finalSecond), (Timer t) async {
      if (SizeUtils.screenHeight < 300) {
        Vibration.vibrate(duration: 4000, repeat: 20, amplitude: 100);
      } else {
        log("Interval $finalSecond $minuteToSecond");
        Vibration.vibrate(duration: 4000, repeat: 20, amplitude: 100);
        // await Alarm.set(alarmSettings: alarmSettings);
        // await Alarm.setNotificationOnAppKillContent("Interval", "body");
        FlutterRingtonePlayer.play(looping: false, volume: 1, asAlarm: true, fromAsset: 'assets/beep_alarm.mp3');
      }
      secondTimer!.cancel();
    });
  }
}
