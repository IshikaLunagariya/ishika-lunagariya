import 'package:clock_simple/modules/home_screen/controller/home_controller.dart';
import 'package:clock_simple/modules/setting_screen/controller/setting_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<SettingController>(SettingController());
  } 
}
