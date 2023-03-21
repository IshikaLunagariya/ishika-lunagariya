import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxString timeString = "".obs;

  @override
  void onInit() {
    timeString.value = DateFormat('hh:mm:ss a').format(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.onInit();
  }

  void _getCurrentTime() {
    timeString.value = DateFormat('hh:mm:ss a').format(DateTime.now());
  }
}
