import 'package:get/get.dart';

import '../../ui/therapy/matchTherapy/match_therapy_controller.dart';

class MatchTherapyBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(MatchTherapyController());
  }
}