import 'package:clock_simple/modules/setting_screen/controller/setting_controller.dart';
import 'package:clock_simple/modules/setting_screen/presentation/landscape_view.dart';
import 'package:clock_simple/modules/setting_screen/presentation/potrait_view.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return SizeUtils.screenHeight < 300
            ? PotraitView()
            : orientation == Orientation.portrait
                ? PotraitView()
                : LandscapeView();
      }),
    );
  }
}
