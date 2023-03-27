import 'package:clock_simple/utils/app_color.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:clock_simple/widget/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatelessWidget {
  const CustomSwitchWidget({Key? key, required this.value, required this.onChange, required this.title, this.subTitle}) : super(key: key);

  final bool value;
  final Function(bool)? onChange;
  final Widget title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          width: 35,
          child: Transform.scale(
            scale: SizeUtils.screenHeight < 300 ? 0.4 : 1,
            child: CupertinoSwitch(
              value: value,
              onChanged: onChange,
              thumbColor: Colors.white,
              activeColor: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: SizeUtils.screenHeight < 300 ? 4 : 0, horizontal: SizeUtils.screenHeight < 300 ? 8 : 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              // AppText(
              //   text: title,
              //   color: AppColor.whiteColor,
              //   fontSize: SizeUtils.fSize_17(),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: AppText(
                  text: subTitle ?? "",
                  color: AppColor.gray,
                  fontSize: SizeUtils.screenHeight < 300 ? SizeUtils.fSize_12() : 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
