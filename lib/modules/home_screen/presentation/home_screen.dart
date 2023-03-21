import 'package:clock_simple/modules/home_screen/controller/home_controller.dart';
import 'package:clock_simple/utils/navigation_utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_color.dart';
import '../../../utils/navigation_utils/navigation.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        splashColor: Colors.transparent,
        onPressed: (){
          Navigation.pushNamed(Routes.settingScreen);
        },
        icon: Icon(Icons.settings, color: AppColor.whiteColor),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
