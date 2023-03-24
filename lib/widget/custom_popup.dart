import 'package:clock_simple/utils/app_color.dart';
import 'package:clock_simple/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomCategoriesDropDown extends StatelessWidget {
  Widget title;
  final Function(String?) onSelected;
  List<PopupMenuEntry<String>> popUpMenuItem;

  CustomCategoriesDropDown({
    Key? key,
    required this.title,
    required this.onSelected,
    required this.popUpMenuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeUtils.verticalBlockSize * 30,
      decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: title),
            PopupMenuButton<String>(
                color: AppColor.whiteColor,
                icon: const Icon(Icons.arrow_drop_down),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                onSelected: onSelected,
                itemBuilder: (BuildContext context) => popUpMenuItem),
          ],
        ),
      ),
    );
  }
}
