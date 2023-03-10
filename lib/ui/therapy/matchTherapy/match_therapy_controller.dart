import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchTherapyController extends GetxController
{

  PageController pageController=PageController(initialPage: 0);
  OverlayState? overlayState;
  OverlayEntry? overlayEntry;

  @override
  void onInit() {

    super.onInit();
  }

  void animateToPage(int index)
  {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

}