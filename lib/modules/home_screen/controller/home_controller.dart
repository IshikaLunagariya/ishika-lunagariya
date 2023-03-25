import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxString timeString = "".obs;
  RxString timeString24 = "".obs;
  RxDouble currentSliderValue = 1.0.obs;
  RxDouble currentSliderValueForColor = 1.0.obs;
  RxBool isVisible = true.obs;
  RxBool isButtonVisible = true.obs;
  RxBool showAppBar = true.obs;

  @override
  void onInit() {
    timeString.value = DateFormat('hh:mm:ss a').format(DateTime.now());
    timeString24.value = DateFormat('HH:mm:ss a').format(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.onInit();
  }

  void _getCurrentTime() {
    timeString.value = DateFormat('hh:mm:ss a').format(DateTime.now());
    timeString24.value = DateFormat('HH:mm:ss a').format(DateTime.now());
  }

  changeBrightness ({required bool dimmer,required DragUpdateDetails details}){
    if (dimmer) {
      if (details.delta.dy < 0 && details.delta.dx == 0) {
        isVisible.value = true;
        if (currentSliderValue.value.toDouble() < 1) {
          currentSliderValue.value += 0.01;
        } else if (currentSliderValue.value.isNegative ||
            currentSliderValue.value <= 0.9) {
          currentSliderValue.value = 1.0;
        }
      } else if (details.delta.dy > 0 && details.delta.dx == 0) {
        isVisible.value = true;
        if (currentSliderValue.value.toDouble() > 0.2) {
          currentSliderValue.value -= 0.01;
        } else if (currentSliderValue.value.isNegative &&
           currentSliderValue.value.toDouble() <= 0.2) {
         currentSliderValue.value = 0.2;
        }
      } else if (details.delta.dx > 0 && details.delta.dy == 0) {
        isVisible.value = false;
        if (currentSliderValueForColor.value.toDouble() < 1) {
          currentSliderValueForColor.value += 0.05;
        } else if (currentSliderValueForColor.value.isNegative ||
            currentSliderValueForColor.value <= 0.9) {
          currentSliderValueForColor.value = 1.0;
        }
      } else if (details.delta.dx < 0 && details.delta.dy == 0) {
        isVisible.value = false;
        if (currentSliderValueForColor.value.toDouble() > 0.1) {
          currentSliderValueForColor.value -= 0.05;
        } else if (currentSliderValueForColor.value.isNegative &&
            currentSliderValueForColor.value.toDouble() <= 0.1) {
          currentSliderValueForColor.value = 0.0;
        }
      }
    }
  }
}
