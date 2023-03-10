import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/homework_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/homework_session_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/resource_list_response.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo.dart';
import '../../../enum/app_enum.dart';
import '../../../widgets/common_widget.dart';

class HomeworkController extends GetxController
{
  final TherapyRepo therapyRepo;
  HomeworkController({required this.therapyRepo});
  var resourceList = <Resource>[].obs;
  var homeWorkSessionList = <HomeWorkSessionItem>[].obs;
  var resourceApiCallStatus = ApiCallStatus.holding.obs;
  var homeWorkApiCallStatus = ApiCallStatus.holding.obs;
  var homeWorkSessionApiCallStatus = ApiCallStatus.holding.obs;
  var homework=Homework().obs;
  var fileList=<String>[].obs;
  var selectedHomeworkSession=HomeWorkSessionItem().obs;
  var receivedParams=NavigationParamsModel().obs;

  @override
  void onInit() {
    initEasyLoading();
    if(Get.arguments!=null)
      {
        receivedParams.value=Get.arguments;
        getHomeworkSession();
      }

    getResourceList();
    super.onInit();
  }

  Future<void> getResourceList()
  async {
    try {
      resourceApiCallStatus.value=ApiCallStatus.loading;
      final either=await therapyRepo.listResources();
      either.fold((l){
        resourceApiCallStatus.value=ApiCallStatus.error;
      }, (r){
        if(r.auth?.resourceList!=null && r.auth!.resourceList!.isNotEmpty)
        {
          resourceList.value=r.auth!.resourceList!;
          resourceApiCallStatus.value=ApiCallStatus.success;
        }
        else
        {
          resourceApiCallStatus.value=ApiCallStatus.empty;
        }
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      resourceApiCallStatus.value=ApiCallStatus.error;
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getHomeworkSession()
  async {
    try {
      homeWorkSessionApiCallStatus.value=ApiCallStatus.loading;
      final either=await therapyRepo.getHomeworkSession(receivedParams.value.sessionTime!);
      either.fold((l){
        homeWorkSessionApiCallStatus.value=ApiCallStatus.error;
      }, (r){
        if(r.auth?.getHomeworkSessions!=null && r.auth!.getHomeworkSessions!.isNotEmpty)
        {
          for(int i=0;i<r.auth!.getHomeworkSessions!.length;i++)
          {
             homeWorkSessionList.addAll(r.auth!.getHomeworkSessions![i].sessions!);
          }
          homeWorkSessionApiCallStatus.value=ApiCallStatus.success;
          selectedHomeworkSession.value=homeWorkSessionList[0];
          getHomework(homeWorkSessionList[0].session!);
        }
        else
        {
          homeWorkSessionApiCallStatus.value=ApiCallStatus.error;
        }
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      homeWorkSessionApiCallStatus.value=ApiCallStatus.error;
      print("Stacktrace==${stacktrace.toString()}");
    }
  }


  Future<void> getHomework(String sessionId)
  async {
    homeWorkApiCallStatus.value=ApiCallStatus.loading;
    fileList.clear();
    try {
      final either=await therapyRepo.getHomework(sessionId);
      either.fold((l){
        homeWorkApiCallStatus.value=ApiCallStatus.error;
      }, (r){
        if(r.auth?.homeWorkList!=null && r.auth!.homeWorkList!.isNotEmpty)
        {
          homework.value=r.auth!.homeWorkList![0];
          if(homework.value.files!=null && homework.value.files!.isNotEmpty)
            {
              fileList.value=homework.value.files!;
            }
          homeWorkApiCallStatus.value=ApiCallStatus.success;
        }
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      homeWorkApiCallStatus.value=ApiCallStatus.error;
    }
  }

  @override
  void onClose() {
    super.onClose();
    EasyLoading.dismiss();
  }
}
