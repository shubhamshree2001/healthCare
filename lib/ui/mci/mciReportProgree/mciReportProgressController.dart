import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/listMciQuestion.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/mciCOnfigResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/request/submitMciRequest.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/mvciResultResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/mci_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import 'package:mindpeers_mobile_flutter/repository/mciRepo/mci_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';

class MciReportProgressController extends GetxController {
  final MciRepo mciRepo;
  MciReportProgressController({required this.mciRepo});

  var receiveParams = NavigationParamsModel().obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      print("fhfkhkhgfytdtfhgjhkjl");
      receiveParams.value = Get.arguments;
      if (receiveParams.value.routes == Routes.mciQuestionScreen) {
        if (receiveParams.value.isMciReportReady!) {
          var mciParams = NavigationParamsModel(routes: Routes.reportProgress);
          Timer(const Duration(seconds: 6), () {
            Get.offAndToNamed(Routes.mciReportScreen, arguments: mciParams);
          });
        } else {
          var mciParams = NavigationParamsModel(
              mciQuestionList: receiveParams.value.mciQuestionList,
              routes: Routes.reportProgress);
          Timer(const Duration(seconds: 6), () {
            Get.offAndToNamed(Routes.mciQuestionScreen, arguments: mciParams);
          });
        }
      }
    }
    super.onInit();
  }
}
