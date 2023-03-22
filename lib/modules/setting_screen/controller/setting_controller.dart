import 'package:clock_simple/utils/preferences.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get to => SettingController();
  RxBool preventLocking = false.obs;
  RxBool dimmer = false.obs;
  RxBool hourFormate = false.obs;
  RxBool leadingZero = true.obs;

  @override
  void onInit() {
    preventLocking.value = Preferences.instance.prefs?.getBool("preventLocking") ?? false;
    dimmer.value = Preferences.instance.prefs?.getBool("dimmer") ?? false;
    hourFormate.value = Preferences.instance.prefs?.getBool("hourFormate") ?? false;
    leadingZero.value = Preferences.instance.prefs?.getBool("leadingZero") ?? false;
    super.onInit();
  }
}
