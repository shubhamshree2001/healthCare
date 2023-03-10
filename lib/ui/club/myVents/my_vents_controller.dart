import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import '../../../data/localStorage/local_storage.dart';
import '../../../data/models/clubModels/community_config_response.dart';
import '../../../data/models/clubModels/vent_list_response.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/models/therapyModel/doctor_list_response.dart';
import '../../../data/queryMutation/club_query_mutation.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../repository/clubRepo/club_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class MyVentController extends GetxController {
  final ClubRepo clubRepo;

  MyVentController({required this.clubRepo});

  var ventList = <Vent>[].obs;
  var ventListApiStatus = ApiCallStatus.holding.obs;
  var selectedVentIndex= 0.obs;
  var scrollController = ScrollController();
  var communityConfig = CommunityConfig().obs;
  var planId ="";

  @override
  void onInit() {
    super.onInit();
    initEasyLoading();
    communityConfig.value = LocalStorage.getCommunityConfig();
    if(Get.arguments!=null) {
      NavigationParamsModel receivedParams = Get.arguments;
      if(receivedParams.routes ==Routes.vents)
      {
        var communityId = receivedParams.communityId!;
        getVentList(communityId);
      }
    }

  }

  
  Future<void> getVentList(String community) async {
    try {
      ventListApiStatus.value = ApiCallStatus.loading;
      final either = await clubRepo.getVentList(ClubQueryMutation.listVents("MY_VENTS", community));
      either.fold((l) {
        ventListApiStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.listVents?.ventList != null && r.auth!.listVents!.ventList!.isNotEmpty) {
          ventList.value = r.auth!.listVents!.ventList!;
          ventListApiStatus.value = ApiCallStatus.success;
        } else {
          ventListApiStatus.value = ApiCallStatus.error;
        }
      });
    } catch (e, stacktrace) {
      ventListApiStatus.value = ApiCallStatus.error;
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> updateVent(String ventId,bool? isMark,bool? isAnonymous,bool? isSensitive ,bool? isDeactivate) async {
    if(isDeactivate==null)
      {
        handleUpdateVentStatus(isMark,isAnonymous,isSensitive);
      }

    try {
      final either = await clubRepo.updateVent(
          ClubQueryMutation.updateVent(ventId, isMarked: isMark,isAnonymous: isAnonymous,isSensitive: isSensitive,isDeactivate:isDeactivate));
      either.fold((l) {
        if(isDeactivate==null)
        {
          handleUpdateVentStatus(isMark,isAnonymous,isSensitive);
        }
      }, (r) {
        if (r.authMutation?.update?.updateVent!=null) {
          if(isDeactivate == null)
            {
              final body = json.decode(r.authMutation!.update!.updateVent!);
              String message =  body["message"];
              showSnackBar("Success", message, false);
            }
          else
            {
              getVentList("");
            }
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
      if(isDeactivate==null)
      {
        handleUpdateVentStatus(isMark,isAnonymous,isSensitive);
      }
    }
  }

  Future<void> getPlanList(Vent vent) async {
    try {
      final either = await clubRepo.getPlanList(TherapyQueryMutation.getPlanListByType("",TherapyPlanEnum.VENT_GIFT.name));
      either.fold((l) {
      }, (r) {
        if (r.auth?.therapyGiftPlanList != null && r.auth!.therapyGiftPlanList!.isNotEmpty) {
          planId =  r.auth!.therapyGiftPlanList![0].id!;
          showGiftDialog(vent);
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> createOrder(String ventId) async {
    try {
      final either = await clubRepo.createOrder(ClubQueryMutation.createOrder(ventId));
      either.fold((l) {
        showSnackBar("error", l.errorMessage, true);
      }, (r) {
        if (r.authMutation != null) {
          getTherapyOrder(r.authMutation!.therapyGiftOrder!.orderId);
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getTherapyOrder(String orderId)
  async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either=await clubRepo.getTherapyOrder(TherapyQueryMutation.getTherapyGiftOrder(orderId));
      either.fold((l){
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r){
        if(r.auth?.getOrder?.id!=null && r.auth!.getOrder!.id.isNotEmpty)
        {
          if(!(r.auth!.getOrder!.completed) && !(r.auth!.getOrder!.timedout))
          {
            var navigationParamsModel = NavigationParamsModel(
                planId: planId,
                orderId: r.auth!.getOrder!.id,
                routes: Routes.vents
            ) ;
            Get.toNamed(Routes.giftTherapyCheckout,arguments: navigationParamsModel);
          }
          else if(r.auth!.getOrder!.completed)
          {
            showSnackBar("Error", "Already Completed", true);
          }
          else if(r.auth!.getOrder!.timedout)
          {
            showSnackBar("Error", "Timeout Error", true);
          }
        }
        EasyLoading.dismiss();
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void showGiftDialog(Vent vent)
  {
    showSendGiftDialog(message: communityConfig.value.sendGiftMessage!.replaceAll("{NAME}",vent.userName!),context: Get.context!, sendGiftCallBack: (){
      Navigator.pop(Get.context!);
      createOrder(vent.id!);
    });
  }

  void handleUpdateVentStatus(bool? isMark,bool? isAnonymous,bool? isSensitive)
  {

    var vent = ventList[selectedVentIndex.value];

    if(isMark!=null)
      {
        if(vent.isLiked!)
        {
          vent.isLiked=false;
          vent.likesCount =vent.likesCount!-1;
        }
        else
        {
          vent.isLiked=true;
          vent.likesCount =vent.likesCount!+1;
        }
      }
    else if(isAnonymous!=null)
      {
        if(vent.isAnonymous!)
        {
          vent.isAnonymous=false;
        }
        else
        {
          vent.isAnonymous=true;
        }
      }
    else if(isSensitive!=null)
    {
      if(vent.isSensitive!)
      {
        vent.isSensitive=false;
      }
      else
      {
        vent.isSensitive=true;
      }
    }


    ventList[selectedVentIndex.value] = vent;
  }

  void redirectToExpandPostScreen(String ventId)
  {
    NavigationParamsModel navigationParamsModel = NavigationParamsModel(
        routes: Routes.vents,
        ventId: ventId,
        //communityId: community.value.id
    );
    Get.toNamed(Routes.expandPost,arguments: navigationParamsModel);
  }

  void shareData(Share share) {
    shareSocial(
        context: Get.context!,
        title: share.title!,
        description: "${share.text}",
        url: share.url!);
  }

  void deleteVentConfirmationDialog(Vent vent)
  {
    showCustomActionDialog(
      message: "Are you sure you want to delete this vent?",
        context: Get.context!, posBtnCallback: (){
        Get.back();
        updateVent(vent.id!, null, null, null, true);
    }, negBtnCallback: (){
       Get.back();
    });
  }

}
