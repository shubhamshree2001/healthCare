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

class MciReportGeneratedController extends GetxController {
  final MciRepo mciRepo;
  MciReportGeneratedController({required this.mciRepo});

  var getReport = <Report>[].obs;
  var mciQuestionList = <Question>[].obs;
  var receiveParams = NavigationParamsModel().obs;

  @override
  void onInit() {
    // if (Get.arguments != null) {
    //   receiveParams.value = Get.arguments;
    //   if(receiveParams.value.routes == ){}
    // }
  }

  Future<void> getMciReportResult() async {
    try {
      //getConfigApiStatus.value = ApiCallStatus.loading;
      final either =
          await mciRepo.getMciResult(MciQueryMutation.getMciResult());
      either.fold((l) {
        //getConfigApiStatus.value = ApiCallStatus.error;
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null && r.auth?.getMciResult != null) {
          if (r.auth?.getMciResult?.ready == true &&
              r.auth?.getMciResult?.report != null &&
              r.auth?.getMciResult?.questions == null) {
            //getConfigApiStatus.value = ApiCallStatus.success;
            //Get.toNamed(Routes.Mci);
            getReport.value = r.auth!.getMciResult!.report!;
          }
          if (r.auth?.getMciResult?.ready == false &&
              r.auth?.getMciResult?.report == null &&
              r.auth?.getMciResult?.questions != null &&
              mciQuestionList.isNotEmpty) {
            mciQuestionList.value = r.auth!.getMciResult!.questions!;
            //getMciQuestions(); //type:demographic
          }
        } else {
          //getConfigApiStatus.value = ApiCallStatus.empty;
        }
      });
    } catch (e, stacktrace) {
      //getConfigApiStatus.value = ApiCallStatus.error;
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }
}
