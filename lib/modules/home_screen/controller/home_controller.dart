import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxString timeString = "".obs;
  RxString timeString24 = "".obs;
  RxDouble currentSliderValue = 1.0.obs;
  RxDouble currentSliderValueForColor = 1.0.obs;
  RxBool isVisible = true.obs;
  RxBool isButtonVisible = true.obs;

  @override
  void onInit() {
    timeString.value = DateFormat('hh:mm:ss a').format(DateTime.now());
    timeString24.value = DateFormat('HH:mm:ss a').format(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.onInit();
  }

  void _getCurrentTime() {
    timeString.value = DateFormat('hh:mm:ss a').format(DateTime.now());
    timeString24.value = DateFormat('HH:mm:ss a').format(DateTime.now());
  }
}
