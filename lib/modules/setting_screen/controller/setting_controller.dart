import 'dart:async';
import 'dart:developer';

import 'package:alarm/alarm.dart';
import 'package:clock_simple/utils/preferences.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';
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
  RxList<Ringtone> ringtones = <Ringtone>[].obs;

  var secondList = ["0 Second", "15 Seconds", "30 Seconds", "45 Seconds", "60 Seconds"];

  Timer? secondTimer;
  Timer? minuteTimer;

  final alarmSettings = AlarmSettings(
    id: 40,
    dateTime: DateTime.now(),
    assetAudioPath: 'assets/note_alarm.mp3',
    loopAudio: true,
    vibrate: true,
    notificationTitle: 'This is the title',
    notificationBody: 'This is the body',
    enableNotificationOnKill: true,
  );

  @override
  void onInit() async {
    await getRingtones();
    preventLocking.value = Preferences.instance.prefs?.getBool("preventLocking") ?? false;
    dimmer.value = Preferences.instance.prefs?.getBool("dimmer") ?? false;
    hourFormat.value = Preferences.instance.prefs?.getBool("hourFormat") ?? false;
    leadingZero.value = Preferences.instance.prefs?.getBool("leadingZero") ?? true;
    intervalSwitch.value = Preferences.instance.prefs?.getBool("intervalSwitch") ?? false;
    secondsUntil.value = Preferences.instance.prefs?.getBool("secondsUntil") ?? false;
    isAlarm.value = Preferences.instance.prefs?.getBool("isAlarm") ?? false;
    String? min;
    min = Preferences.instance.prefs?.getString("minutes");
    if (min != "01") {
      minutesController.text = min ?? "";
      if (isAlarm.value) {
        secondTimer?.cancel();
        minuteTimer?.cancel();
        setMinuteIntervalRemainder(
          minutes: int.parse(minutesController.text),
        );
      }
    } else {
      minutesController.clear();
    }
    String? second;
    second = Preferences.instance.prefs?.getString("seconds");
    if (second != "00") {
      secondController.text = second ?? "";
      if (isAlarm.value) {
        secondTimer?.cancel();
        minuteTimer?.cancel();
        setSecondIntervalRemainder(
          minutes: int.parse(minutesController.text),
          second: int.parse(secondController.text),
        );
      }
    } else {
      secondController.clear();
    }

    super.onInit();
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  void insertText(String myText, TextEditingController controller) {
    final text = controller.text;
    final textSelection = controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;

    if (secondsUntil.value) {
      if (newText.length == 1) {
        if (int.parse(newText.substring(0, 1)) < 7) {
          controller.text = newText;
          controller.selection = textSelection.copyWith(
            baseOffset: textSelection.start + myTextLength,
            extentOffset: textSelection.start + myTextLength,
          );
        }
      } else if (newText.length <= 2) {
        if (int.parse(newText.substring(0, 1)) == 6 && int.parse(newText.substring(1, 2)) == 0) {
          controller.text = newText;
          controller.selection = textSelection.copyWith(
            baseOffset: textSelection.start + myTextLength,
            extentOffset: textSelection.start + myTextLength,
          );
        } else if (int.parse(newText.substring(0, 1)) < 6) {
          controller.text = newText;
          controller.selection = textSelection.copyWith(
            baseOffset: textSelection.start + myTextLength,
            extentOffset: textSelection.start + myTextLength,
          );
        }
      }
    } else {
      if (newText.length == 1) {
        if (int.parse(newText.substring(0, 1)) > 0 && int.parse(newText.substring(0, 1)) < 7) {
          controller.text = newText;
          controller.selection = textSelection.copyWith(
            baseOffset: textSelection.start + myTextLength,
            extentOffset: textSelection.start + myTextLength,
          );
        }
      } else if (newText.length <= 2) {
        if (int.parse(newText.substring(0, 1)) == 6 && int.parse(newText.substring(1, 2)) == 0) {
          controller.text = newText;
          controller.selection = textSelection.copyWith(
            baseOffset: textSelection.start + myTextLength,
            extentOffset: textSelection.start + myTextLength,
          );
        } else if (int.parse(newText.substring(0, 1)) < 6) {
          controller.text = newText;
          controller.selection = textSelection.copyWith(
            baseOffset: textSelection.start + myTextLength,
            extentOffset: textSelection.start + myTextLength,
          );
        }
      }
    }

    // if (newText.length <= 2) {
    //   if (int.parse(newText.substring(0, 1)) < 7 && int.parse(newText.substring(1, 2)) < 10) {
    //     if ((int.parse(newText.substring(0, 1)) == 6)) {
    // int.parse(newText.substring(1, 2)) == 0
    //       controller.text = newText.length <= 2 ? newText : "00";
    //       controller.selection = textSelection.copyWith(
    //         baseOffset: textSelection.start + myTextLength,
    //         extentOffset: textSelection.start + myTextLength,
    //       );
    //     }
    //   }
    // }
  }

  void backspace(TextEditingController controller) {
    final text = controller.text;
    final textSelection = controller.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      controller.text = newText;
      controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    controller.text = newText;
    controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  setMinuteIntervalRemainder({int? minutes}) {
    secondTimer?.cancel();
    minuteTimer = Timer.periodic(Duration(minutes: minutes ?? 1), (Timer t) async {
      if (SizeUtils.screenHeight < 300) {
        Vibration.vibrate(duration: 4000, repeat: 20, amplitude: 128);
      } else {
        Vibration.vibrate(duration: 4000, repeat: 20, amplitude: 128);
        // await Alarm.set(alarmSettings: alarmSettings);
        // await Alarm.setNotificationOnAppKillContent("Interval", "body");
        FlutterRingtonePlayer.play(looping: false, volume: 1, asAlarm: true, fromAsset: 'assets/note_alarm.mp3');
        // setSecondIntervalRemainder(
        //     minutes: int.parse(minutesController.text),
        //     second: secondController.text.isEmpty ? 0 : int.parse(secondController.text));
      }
    });
  }

  setSecondIntervalRemainder({int? minutes, int? second}) {
    int minuteToSecond = Duration(minutes: minutes ?? 1).inSeconds;
    int finalSecond = minuteToSecond - (second ?? 0);
    log("finalSecond--->$finalSecond");
    secondTimer = Timer.periodic(Duration(seconds: finalSecond), (Timer t) async {
      if (SizeUtils.screenHeight < 300) {
        Vibration.vibrate(duration: 4000, repeat: 20, amplitude: 100);
      } else {
        log("Interval $finalSecond $minuteToSecond");
        Vibration.vibrate(duration: 4000, repeat: 20, amplitude: 100);
        // await Alarm.set(alarmSettings: alarmSettings);
        // await Alarm.setNotificationOnAppKillContent("Interval", "body");
        FlutterRingtonePlayer.play(looping: true, volume: 1, asAlarm: true, fromAsset: 'assets/note_alarm.mp3');

        Future.delayed(Duration(seconds: second ?? 0)).then((value) {
          print("Future.delayed");
          // Alarm.stop(42);
          FlutterRingtonePlayer.stop();
          Vibration.cancel();
          secondTimer?.cancel();
          setSecondIntervalRemainder(
            minutes: int.parse(minutesController.text),
            second: int.parse(secondController.text),
          );
          // secondTimer!.cancel();
        });

        // secondTimer?.cancel();
      }
    });
  }

  Future<void> getRingtones() async {
    try {
      final temp = await FlutterSystemRingtones.getRingtoneSounds();
      ringtones.value = temp;
    } on PlatformException {
      debugPrint('Failed to get platform version.');
    }
  }
}
