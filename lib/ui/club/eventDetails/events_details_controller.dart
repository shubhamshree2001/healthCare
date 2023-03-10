import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/boat_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/request/community_list_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import '../../../appUtils/app_util.dart';
import '../../../constants/strings_constant.dart';
import '../../../data/models/clubModels/community_info_response.dart';
import '../../../data/models/clubModels/vent_list_response.dart';
import '../../../data/models/therapyModel/doctor_list_response.dart';
import '../../../data/queryMutation/club_query_mutation.dart';
import '../../../repository/clubRepo/club_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class EventDetailsController extends GetxController {
  final ClubRepo clubRepo;

  EventDetailsController({required this.clubRepo});

  var boatApiStatus = ApiCallStatus.holding.obs;
  var boat = Boat().obs;

  @override
  void onInit() {
    super.onInit();

    if(Get.arguments!=null) {
      NavigationParamsModel receivedParams = Get.arguments;
      if(receivedParams.routes ==Routes.events)
      {
        var slug = receivedParams.slug!;
        getBoat(slug);
      }
    }

  }

  Future<void> getBoat(String slug) async {
    try {
      boatApiStatus.value = ApiCallStatus.loading;
      final either = await clubRepo
          .getBoat(ClubQueryMutation.getBoat(slug));
      either.fold((l) {
        boatApiStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.boat != null) {
          boatApiStatus.value = ApiCallStatus.success;
          boat.value = r.auth!.boat!;
        }
        else
          {
            boatApiStatus.value = ApiCallStatus.error;
          }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      boatApiStatus.value = ApiCallStatus.error;
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> notifyEvent(String id) async {
    try {
      final either = await clubRepo
          .notifyEvent(ClubQueryMutation.notifyEvent(id));
      either.fold((l) {
      }, (r) {
        if (r.authMutation?.create?.eventNotify != null) {
          showEventNotifyConfirmDialog();
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getMeetLink(String eventId) async {
    try {
      final either = await clubRepo.getMeetLink(
          eventId, TherapyPlanEnum.BOAT.name);
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null) {

        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  void redirectToPlanScreen()
  {
    Get.toNamed(Routes.plan);
  }

  void redirectToExpandPostScreen(String ventId)
  {
    NavigationParamsModel navigationParamsModel = NavigationParamsModel(
        routes: Routes.vents,
        ventId: ventId
    );
    Get.toNamed(Routes.expandPost,arguments: navigationParamsModel);
  }


  void shareData(Share? share) {
    if(share!=null)
      {
        shareSocial(
            context: Get.context!,
            title: share.title!,
            description: share.text!,
            url: share.url!);
      }
  }

  void showEventNotifyConfirmDialog()
  {
    showCustomActionDialog(context: Get.context!, posBtnCallback: (){
      googleMeet();
      Navigator.pop(Get.context!);
    },
        negBtnCallback: (){
          Navigator.pop(Get.context!);
        }
    );
  }

  googleMeet() async {
    if(boat.value.meeting!=null)
      {
        String startDate = AppUtil.convertStringToDateFormat(
            boat.value.startAt,
            format: AppUtil.dateTimeYYYYMMDDTHHMMSS);
        String endDate = AppUtil.convertStringToDateFormat(
            boat.value.endAt,
            format: AppUtil.dateTimeYYYYMMDDTHHMMSS);
        var url =
            '${StringsConstant.googleCalenderUrl}?dates=$startDate/$endDate&location=${boat.value.meeting}&text=${boat.value.title}';
        launchWebUrl(url);
      }
  }

}
