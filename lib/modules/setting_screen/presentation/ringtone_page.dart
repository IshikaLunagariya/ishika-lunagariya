import 'package:clock_simple/modules/setting_screen/controller/setting_controller.dart';
import 'package:clock_simple/utils/app_color.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:clock_simple/widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RingtonePage extends StatefulWidget {
  RingtonePage({Key? key}) : super(key: key);

  @override
  State<RingtonePage> createState() => _RingtonePageState();
}

class _RingtonePageState extends State<RingtonePage> {
  final SettingController settingController = Get.find();

  String ringtoneGroup = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blackColor,
        elevation: 0.0,
        title: const AppText(
          text: "Ringtone",
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            right: SizeUtils.horizontalBlockSize * 5,
            left: SizeUtils.horizontalBlockSize * 5,
            top: SizeUtils.verticalBlockSize * 2,
            bottom: SizeUtils.verticalBlockSize * 4,
          ),
          child: Theme(
            data: ThemeData(unselectedWidgetColor: AppColor.lightGrey),
            child: Container(
              height: SizeUtils.screenHeight,
              width: SizeUtils.screenWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeUtils.verticalBlockSize * 3), color: AppColor.darkGrey),
              child: Obx(
                () => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: settingController.ringtones.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        // FlutterRingtonePlayer.play(
                        //   // android: AndroidSounds.notification,
                        //   // ios: const IosSound(1023),
                        //   looping: false,
                        //
                        //   volume: 0.1,
                        //   fromAsset: settingController.ringtones[index].uri,
                        // );
                      },
                      title: AppText(
                        text: settingController.ringtones[index].title,
                        color: AppColor.whiteColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      trailing: Radio(
                        activeColor: MaterialStateColor.resolveWith((states) => Colors.white),
                        value: settingController.ringtones[index].title,
                        groupValue: ringtoneGroup,
                        onChanged: (value) {
                          setState(() {
                            ringtoneGroup = value.toString();
                          });
                        },
                      ),
                      // subtitle: AppText(
                      //   text: settingController.ringtones[index].uri,
                      //   color: AppColor.whiteColor,
                      // ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
