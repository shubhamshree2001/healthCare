import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_config_response.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import '../../../data/models/authModel/user_response.dart';
import '../../../data/models/clubModels/vent_list_response.dart';
import '../../../data/models/clubModels/vents_replies_list_response.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/models/therapyModel/doctor_list_response.dart';
import '../../../data/queryMutation/club_query_mutation.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../repository/clubRepo/club_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../service/server_exception_code.dart';
import '../../../widgets/common_widget.dart';

class ExpandPostController extends GetxController {
  final ClubRepo clubRepo;

  ExpandPostController({required this.clubRepo});

  final postController=TextEditingController();
  var anonymousSwitch=false.obs;
  var isEnablePostButton = false.obs;
  var replyList = <Reply>[].obs;
  var ventRepliesListApiStatus = ApiCallStatus.holding.obs;
  var ventApiStatus = ApiCallStatus.holding.obs;
  var scrollController = ScrollController();
  var vent = Vent().obs;
  var communityConfig = CommunityConfig().obs;
  String communityId = "";
  String ventId = "";
  var userName = "".obs;
  String planId ="";

  @override
  void onInit() {
    super.onInit();
    initEasyLoading();
    GetUser user = LocalStorage.getUserData();
    if(user!=null && user.name!=null)
    {
      userName.value = user.name!;
    }

    communityConfig.value = LocalStorage.getCommunityConfig();

    if(Get.arguments!=null) {
      NavigationParamsModel receivedParams = Get.arguments;
      if(receivedParams.routes ==Routes.vents)
      {
        ventId = receivedParams.ventId!;
        getVent(ventId);
        getVentRepliesList(ventId);
      }
    }
  }

  Future<void> getVentRepliesList(String ventId) async {
    try {
      ventRepliesListApiStatus.value = ApiCallStatus.loading;
      final either = await clubRepo.getVentRepliesList(ClubQueryMutation.getVentRepliesList(ventId));
      either.fold((l) {
        ventRepliesListApiStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.listVentReplies != null) {
          if(r.auth?.listVentReplies?.replies != null && r.auth!.listVentReplies!.replies!.isNotEmpty)
          {
            replyList.value = r.auth!.listVentReplies!.replies!;
          }
          if(r.auth?.listVentReplies?.lastFetchedTime!=null && r.auth!.listVentReplies!.lastFetchedTime!.isNotEmpty)
            {
              checkVentStatus(ventId, r.auth!.listVentReplies!.lastFetchedTime!);
            }
          ventRepliesListApiStatus.value = ApiCallStatus.success;
        } else {
          ventRepliesListApiStatus.value = ApiCallStatus.error;
        }
      });
    } catch (e, stacktrace) {
      ventRepliesListApiStatus.value = ApiCallStatus.error;
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> checkVentStatus(String ventId,String lastFetchedTime) async {
    try {
      final either = await clubRepo
          .checkVentStatus(ClubQueryMutation.checkVentStatus(ventId,lastFetchedTime));
      either.fold((l) {}, (r) {
        if (r.auth?.checkVentStatus != null) {

        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getVent(String ventId) async {
    ventApiStatus.value = ApiCallStatus.loading;
    try {
      final either = await clubRepo
          .getVent(ClubQueryMutation.getVent(ventId));
      either.fold((l) {
        ventApiStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.vent != null) {
          vent.value = r.auth!.vent!;
          ventApiStatus.value = ApiCallStatus.success;
        }
        else
          {
            ventApiStatus.value = ApiCallStatus.error;
          }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
      ventApiStatus.value = ApiCallStatus.error;
    }
  }

  Future<void> updateVent(String ventId,bool isMark) async {
    handleLikeStatus();
    try {
      final either = await clubRepo.updateVent(
          ClubQueryMutation.updateVent(ventId, isMarked: isMark));
      either.fold((l) {
        handleLikeStatus();
      }, (r) {
        if (r.authMutation?.update?.communityFollow!=null) {
         // final body = json.decode(r.authMutation!.update!.communityFollow!);
         // String message =  body["message"];
          // handleLikeStatus();
        //  showSnackBar("Success", message, false);
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
      handleLikeStatus();
    }
  }

  Future<void> postVent() async {
    try {
      final either = await clubRepo.updateVent(
          ClubQueryMutation.replyVent(postController.text.toString(),anonymousSwitch.value,ventId));
      either.fold((l) {
        if(l.serverCode == ServerExceptionCode.PAID_FEATURE_ACCESS_ERROR)
        {
          Get.toNamed(Routes.plan);
        }
      }, (r) {
        if (r.authMutation?.update?.communityFollow!=null) {
          // final body = json.decode(r.authMutation!.update!.communityFollow!);
          // String message =  body["message"];
         //  showSnackBar("Success", message, false);
          getVentRepliesList(ventId);
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
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
    if(vent.userName!=null && vent.id!=null)
      {
        showSendGiftDialog(message: communityConfig.value.sendGiftMessage!.replaceAll("{NAME}",vent.userName!),context: Get.context!, sendGiftCallBack: (){
          Navigator.pop(Get.context!);
          createOrder(vent.id!);
        });
      }
  }

  void handleLikeStatus()
  {

    var ventItem = vent.value;

    if(ventItem.isLiked!)
    {
      ventItem.isLiked=false;
      ventItem.likesCount =ventItem.likesCount!-1;
    }
    else
    {
      ventItem.isLiked=true;
      ventItem.likesCount = ventItem.likesCount!+1;
    }

    vent.value = ventItem;
  }

  void redirectToPlanScreen()
  {
    Get.toNamed(Routes.plan);
  }

  void shareData(Share? share) {
    if(share!=null)
      {
        shareSocial(
            context: Get.context!,
            title: share.title!,
            description: "${share.text}",
            url: share.url!);
      }
  }

  void sendPost()
  {
    if(postController.text.isNotEmpty)
      {
        postVent();
      }
  }

  @override
  void onClose() {
    postController.dispose();
    super.onClose();
  }

}
