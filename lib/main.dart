import 'package:alarm/alarm.dart';
import 'package:clock_simple/clock_simple.dart';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

import 'utils/preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().initialAppPreference();
  await Alarm.init();
  // await SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  ScreenBrightness();
  runApp(const ClockSimple());
}
