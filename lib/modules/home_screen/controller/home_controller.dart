import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screen_brightness/screen_brightness.dart';

class HomeController extends GetxController {
  RxDouble currentSliderValue = 1.0.obs;

  String currentTime = DateFormat('hh:mm:ss').format(DateTime.now());
  String current = DateTime.now().timeZoneName;

  Future<double> get currentBrightness async {
    try {
      print(await ScreenBrightness().current);
      return await ScreenBrightness().current;
    } catch (e) {
      print(e);
      throw 'Failed to get current brightness';
    }
  }
}
