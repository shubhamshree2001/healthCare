import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_config_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/request/community_list_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/setting_query_Mutation.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import '../../../constants/strings_constant.dart';
import '../../../data/models/clubModels/community_info_response.dart';
import '../../../data/models/clubModels/vent_list_response.dart';
import '../../../data/models/settingModel/requestSetting/submitFeedback_request.dart';
import '../../../data/models/therapyModel/doctor_list_response.dart';
import '../../../data/queryMutation/club_query_mutation.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../repository/clubRepo/club_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class VentsController extends GetxController {
  final ClubRepo clubRepo;

  VentsController({required this.clubRepo});

  var feedbackController = TextEditingController();
  var communityList = <Community>[].obs;
  var ventList = <Vent>[].obs;
  var communityListApiStatus = ApiCallStatus.holding.obs;
  var ventListApiStatus = ApiCallStatus.holding.obs;
  var moreClubIcon = "".obs;
  var community = Community().obs;
  var scrollController = ScrollController(initialScrollOffset: 0);
  var selectedVentIndex= 0.obs;
  var communityInfo=CommunityInfo().obs;
  var isHaveMyVents = false.obs;
  var communityConfig = CommunityConfig().obs;
  var follow =false.obs;
  var isCommunityLocked = false.obs;

  var ventTotal = 0;
  var ventLimit = 25;
  var ventOffset = 0;
  var isIntervalStart =false.obs;
  var planId ="";

  ScrollController ventScrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    initEasyLoading();
    getCommunityConfig();
    isIntervalStart.value = false;
    getCommunityList("");
  }

  Future<void> getCommunityConfig() async {
    try {
      final either = await clubRepo
          .getCommunityConfig(ClubQueryMutation.getCommunityConfig());
      either.fold((l) {}, (r) {
        if (r.auth?.communityConfig != null) {
           communityConfig.value = r.auth!.communityConfig!;
           LocalStorage.setCommunityConfig(r.auth!.communityConfig!);
           checkHasNewPost();
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getCommunityInfo(String slug) async {
    try {
      final either = await clubRepo
          .getCommunityInfo(ClubQueryMutation.getCommunityInfo(slug));
      either.fold((l) {}, (r) {
        if (r.auth?.communityInfo != null) {
          communityInfo.value = r.auth!.communityInfo!;
          if(communityInfo.value.locked!=null)
            {
              isCommunityLocked.value =  communityInfo.value.locked!;
            }

        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getCommunityList(String inclusive) async {
    try {
      CommunityListRequest communityListRequest = CommunityListRequest(
        screen: "HOME",
        inclusive: [inclusive],
        exclusive: [],
      );
      if(!isIntervalStart.value)
        {
          communityListApiStatus.value = ApiCallStatus.loading;
        }

      final either = await clubRepo.getCommunityList(
          ClubQueryMutation.getCommunityList(),communityListRequest.toMap());
      either.fold((l) {
        communityListApiStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.communitiesList != null &&
            r.auth!.communitiesList!.isNotEmpty) {
          communityList.value = r.auth!.communitiesList!;
          moreClubIcon.value = LocalStorage.getCommunityConfig().clubListCtaIcon!;
          communityList.insert(0, Community(name: "More Clubs", image: ImageData(icon: moreClubIcon.value)));
          if(inclusive.isEmpty)
            {
              handleClubList(1);
            }
          else
            {
              int index = communityList.indexWhere((item) => item.slug == inclusive);
              handleClubList(index);
            }
          communityListApiStatus.value = ApiCallStatus.success;

        } else {
          communityListApiStatus.value = ApiCallStatus.error;
        }
      });
    } catch (e, stacktrace) {
      communityListApiStatus.value = ApiCallStatus.error;
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }


  Future<void> getVentList(String community) async {
    try {
      if (ventOffset == 0) {
        ventList.clear();
        ventListApiStatus.value = ApiCallStatus.loading;
      }
      final either = await clubRepo.getVentList(ClubQueryMutation.listVents("ALL", community,limit: ventLimit,offset: ventOffset));
      either.fold((l) {
        ventListApiStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.listVents?.ventList != null && r.auth!.listVents!.ventList!.isNotEmpty) {
       //   ventList.value = r.auth!.listVents!.ventList!;
          ventList.addAll(r.auth!.listVents!.ventList!);
          ventTotal = r.ventOutWallMessagesTotal;
          ventOffset = r.ventOutWallMessagesOffset + r.ventOutWallMessagesLimit;
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

  Future<void> updateVent(String ventId,bool isMark) async {
    handleLikeStatus();
    try {
      final either = await clubRepo.updateVent(
          ClubQueryMutation.updateVent(ventId,isMarked: isMark));
      either.fold((l) {
        handleLikeStatus();
      }, (r) {
        if (r.authMutation?.update?.communityFollow!=null) {
          final body = json.decode(r.authMutation!.update!.communityFollow!);
          String message =  body["message"];
         // handleLikeStatus();
          showSnackBar("Success", message, false);
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
      handleLikeStatus();
    }
  }

  Future<void> getMyVentList(String id) async {
    try {
      final either = await clubRepo.getVentList(ClubQueryMutation.listVents("MY_VENTS", id));
      either.fold((l) {
      }, (r) {
        if (r.auth?.listVents?.ventList != null && r.auth!.listVents!.ventList!.isNotEmpty) {
           isHaveMyVents.value =true;
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> updateFollowStatus(String communityId,bool isFollow) async {

    handleUpdateFollowStatus();

    try {
      final either = await clubRepo.updateFollowStatus(
          ClubQueryMutation.updateFollowStatus(communityId, isFollow));
      either.fold((l) {
        handleUpdateFollowStatus();
      }, (r) {
        if (r.authMutation?.update?.communityFollow!=null) {
          final body = json.decode(r.authMutation!.update!.communityFollow!);
          String message =  body["message"];
          showSnackBar("Success", message, false);
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
      handleUpdateFollowStatus();
    }
  }

  Future<void> submitUserFeedback(String query,Map<String,dynamic> variable) async {
    try {
      final either = await clubRepo.submitUserFeedback(query,variable);
      either.fold((l) {
        showSnackBar("error", l.errorMessage, true);
      }, (r) {
        if (r.authMutation?.create?.submitFeedbackV2 != null) {
          final body = json.decode(r.authMutation!.create!.submitFeedbackV2!);
          String message =  body["message"];
          showSnackBar("Success", message, false);
          feedbackController.text ="";
          //Get.back();
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
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


  void handleUpdateFollowStatus()
  {
    if (community.value.follow!) {
      community.value.follow=false;
      community.value.follower?.followerCount =   community.value.follower!.followerCount!-1;
    } else {
      community.value.follow=true;
      community.value.follower?.followerCount =   community.value.follower!.followerCount!+1;
    }

    follow.value = community.value.follow!;

    print(community.value.follow);
  }

  void checkHasNewPost()
  {
    if(communityConfig.value.syncTime!=null && communityConfig.value.syncTime!=0)
      {
        Timer.periodic(Duration(milliseconds: communityConfig.value.syncTime!), (timer) {
          getCommunityList(community.value.slug!);
        });
      }
  }


  void handleLikeStatus()
  {
    var vent = ventList[selectedVentIndex.value];

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
   ventList[selectedVentIndex.value] = vent;
  }

  void handleClubList(int index) {
    for (int i = 0; i < communityList.length; i++) {
      Community community = communityList[i];
      if (index == i) {
        community.isSelected = true;
        communityList[i] = community;
      } else {
        community.isSelected = false;
        communityList[i] = community;
      }
    }

    animateClubItem(index-1);
    community.value = communityList[index];

    follow.value =  community.value.follow!;
    ventOffset = 0;
    ventLimit = 25;
    isCommunityLocked.value =false;
    isHaveMyVents.value = false;
    if(!isIntervalStart.value)
      {
        getVentList(community.value.id!);
        getCommunityInfo(community.value.slug!);
        getMyVentList(community.value.id!);
      }

  }

  void redirectToWorksheetScreen()
  {
    NavigationParamsModel navigationParamsModel = NavigationParamsModel(
      routes: Routes.vents,
      resourceList: communityInfo.value.resources
    );
    Get.toNamed(Routes.worksheets,arguments: navigationParamsModel);
  }
  void redirectToExpandPostScreen(String ventId)
  {
    NavigationParamsModel navigationParamsModel = NavigationParamsModel(
        routes: Routes.vents,
        ventId: ventId,
        communityId: community.value.id
    );
    Get.toNamed(Routes.expandPost,arguments: navigationParamsModel);
  }

  void redirectToPostVentScreen()
  {
    NavigationParamsModel navigationParamsModel = NavigationParamsModel(
        routes: Routes.vents,
        communityId: community.value.id
    );
    Get.toNamed(Routes.newPost,arguments: navigationParamsModel)?.then((value){
      getCommunityList(community.value.slug!);
    });
  }

  void redirectToMyVentScreen()
  {
    NavigationParamsModel navigationParamsModel = NavigationParamsModel(
        routes: Routes.vents,
        communityId: community.value.id
    );
    Get.toNamed(Routes.myVents,arguments: navigationParamsModel)?.then((value){
      getCommunityList(community.value.slug!);
    });
  }

  void animateClubItem(int index) {
    scrollController = ScrollController(initialScrollOffset: index * 80);
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

  void redirectToMoreClubScreen()
  {
    Get.toNamed(Routes.moreClub)?.then((value){
      if(value!=null)
        {
          Community community= value as Community;
          getCommunityList(community.slug!);
        }
    });
  }


  void sendFeedback()
  {
    if(communityConfig.value.feedback!=null && feedbackController.text.isNotEmpty)
      {

        var answers={
          "answer":feedbackController.text,
          "question":communityConfig.value.feedback!.id
        };
        var variable = {
          "answers":[answers]
        };
        submitUserFeedback(ClubQueryMutation.submitFeedback(communityConfig.value.feedback!.id!,communityConfig.value.feedback!.kind!,feedbackController.text),variable);
      }

  }

  void ventPagination() {
    ventScrollController.addListener(() {
      if (ventScrollController.position.pixels ==
          ventScrollController.position.maxScrollExtent) {
        if (ventTotal > ventList.length) {
          getVentList(community.value.id!);
        }
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    feedbackController.dispose();
  }

}
