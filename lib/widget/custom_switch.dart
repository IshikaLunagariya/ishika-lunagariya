import 'package:clock_simple/utils/app_color.dart';
import 'package:clock_simple/widget/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/size_utils.dart';

class CustomSwitchWidget extends StatelessWidget {
  const CustomSwitchWidget({Key? key, required this.value, required this.onChange, required this.title, this.subTitle})
      : super(key: key);

  final bool value;
  final Function(bool)? onChange;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoSwitch(
          value: value,
          onChanged: onChange,
          thumbColor: Colors.white,
          activeColor: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: title,
                color: AppColor.whiteColor,
                fontSize: SizeUtils.fSize_17(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: AppText(
                  text: subTitle ?? "",
                  color: AppColor.gray,
                  fontSize: SizeUtils.fSize_12(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
