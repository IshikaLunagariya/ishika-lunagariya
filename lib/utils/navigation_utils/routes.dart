import 'package:clock_simple/modules/setting_screen/presentation/ringtone_page.dart';
import 'package:clock_simple/modules/setting_screen/presentation/setting_screen.dart';
import 'package:get/get.dart';

import '../../modules/home_screen/presentation/home_screen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;
  static const defaultTransitionDuration = Duration(milliseconds: 200);

  static const String splash = '/splash';
  static const String homeScreen = '/homeScreen';
  static const String settingScreen = '/SettingScreen';
  static const String ringtonePage = '/RingtonePage';

  static bool isAdminArgument = false;

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: homeScreen,
      page: () => HomeScreen(),
      transition: Transition.fade,
      transitionDuration: defaultTransitionDuration,
    ),
    GetPage<dynamic>(
      name: settingScreen,
      page: () => SettingScreen(),
      transition: Transition.fade,
      transitionDuration: defaultTransitionDuration,
    ),
    GetPage<dynamic>(
      name: ringtonePage,
      page: () => RingtonePage(),
      transition: Transition.fade,
      transitionDuration: defaultTransitionDuration,
    ),
  ];
}
