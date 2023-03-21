import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool preventLocking = false.obs;
  RxBool dimmer = false.obs;
  RxBool hourFormate = false.obs;
  RxBool leadingZero = true.obs;
}
