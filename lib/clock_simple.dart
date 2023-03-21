import 'package:clock_simple/utils/app_binding.dart';
import 'package:clock_simple/utils/app_color.dart';
import 'package:clock_simple/utils/navigation_utils/routes.dart';
import 'package:clock_simple/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'modules/home_screen/presentation/home_screen.dart';

class ClockSimple extends StatefulWidget {
  const ClockSimple({Key? key}) : super(key: key);

  @override
  State<ClockSimple> createState() => _ClockSimpleState();
}

class _ClockSimpleState extends State<ClockSimple> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      theme: ThemeData(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
            thickness: MaterialStateProperty.all(5),
          ),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          brightness: Brightness.dark,
          splashColor: Colors.transparent,
          disabledColor: Colors.transparent,
          scaffoldBackgroundColor: AppColor.blackColor),
      initialRoute: Routes.homeScreen,
      unknownRoute: GetPage(
        name: Routes.homeScreen,
        page: () => HomeScreen(),
      ),
    );
  }
}
