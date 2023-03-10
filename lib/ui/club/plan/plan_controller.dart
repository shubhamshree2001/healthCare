import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_config_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/club_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/therapy_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import 'package:mindpeers_mobile_flutter/service/server_exception_code.dart';
import '../../../data/models/therapyModel/doctor_list_response.dart';
import '../../../data/models/therapyModel/therapy_gift_plan_response.dart';
import '../../../repository/clubRepo/club_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class PlansController extends GetxController {
  final ClubRepo clubRepo;

  PlansController({required this.clubRepo});

  var planListApiStatus = ApiCallStatus.holding.obs;
  var scrollController = ScrollController(initialScrollOffset: 0);
  var communityConfig = CommunityConfig().obs;
  var subscriptionCheckList = [].obs;
  var planList = <TherapyGiftPlan>[].obs;
  var subscriptionBenefitsType = "".obs;
  var selectedPlanIndex =0.obs;

  @override
  void onInit() {
    super.onInit();
    initEasyLoading();
    getPlanList();
    communityConfig.value = LocalStorage.getCommunityConfig();
    subscriptionBenefitsType.value = communityConfig.value.subscriptionBenefits!.type!;
    if(communityConfig.value.subscriptionBenefits!=null)
      {
        if(communityConfig.value.subscriptionBenefits?.asset!=null && communityConfig.value.subscriptionBenefits!.asset!.isNotEmpty)
          {
            subscriptionCheckList.value = communityConfig.value.subscriptionBenefits!.asset!;
          }

        subscriptionBenefitsType.value = communityConfig.value.subscriptionBenefits!.type!;
      }

  }


  Future<void> getPlanList() async {
    try {
      planListApiStatus.value = ApiCallStatus.loading;
      final either = await clubRepo.getPlanList(TherapyQueryMutation.getPlanListByType("",TherapyPlanEnum.COMMUNITY.name));
      either.fold((l) {
        planListApiStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.therapyGiftPlanList != null && r.auth!.therapyGiftPlanList!.isNotEmpty) {
          planList.value = r.auth!.therapyGiftPlanList!;
          planListApiStatus.value = ApiCallStatus.success;
        } else {
          planListApiStatus.value = ApiCallStatus.error;
        }
      });
    } catch (e, stacktrace) {
    planListApiStatus.value = ApiCallStatus.error;
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> subscribe() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await clubRepo.subscribe(ClubQueryMutation.subscribe(planList[selectedPlanIndex.value].id!,TherapyPlanEnum.COMMUNITY.name));
      either.fold((l) {
        if(l.serverCode == ServerExceptionCode.DEV_ERROR)
          {
            showSnackBar("Error", l.serverCode, true);
          }
        EasyLoading.dismiss();
        }, (r) {
        if (r.authMutation != null) {

        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
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
            title: "",
            description: share.text!,
            url: share.url!);
      }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }

}
