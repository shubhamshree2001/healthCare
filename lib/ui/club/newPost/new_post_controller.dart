import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';

import '../../../data/localStorage/local_storage.dart';
import '../../../data/models/clubModels/community_config_response.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/queryMutation/club_query_mutation.dart';
import '../../../repository/clubRepo/club_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../service/server_exception_code.dart';
import '../../../widgets/common_widget.dart';

class NewPostController extends GetxController
{

  final ClubRepo clubRepo;

  NewPostController({required this.clubRepo});

  var anonymousSwitch=false.obs;
  var isSensitive=false.obs;
  var communityConfig = CommunityConfig().obs;
  var communityId ="".obs;
  final postController=TextEditingController();
  var postFieldHint= "".obs;
  var isEnablePostButton = false.obs;
  var userName = "".obs;

  @override
  void onInit() {
    super.onInit();

    GetUser user = LocalStorage.getUserData();
    if(user!=null && user.name!=null)
      {
        userName.value = user.name!;
      }

    communityConfig.value = LocalStorage.getCommunityConfig();
    if(communityConfig.value.postVentPlaceholder!=null && communityConfig.value.postVentPlaceholder!.isNotEmpty)
      {
        postFieldHint.value = communityConfig.value.postVentPlaceholder!;
      }

    if(Get.arguments!=null) {
      NavigationParamsModel receivedParams = Get.arguments;
      if(receivedParams.routes ==Routes.vents)
      {
         communityId.value = receivedParams.communityId!;
      }
    }

  }

  Future<void> postVent() async {
    try {
      final either = await clubRepo.postVent(
          ClubQueryMutation.postVent(postController.text.toString(),anonymousSwitch.value,isSensitive.value,communityId.value));
      either.fold((l) {
        if(l.serverCode == ServerExceptionCode.PAID_FEATURE_ACCESS_ERROR)
          {
            Get.toNamed(Routes.plan);
          }
      }, (r) {
        Get.back();
          if (r.authMutation?.create?.postVent!=null) {
          final body = json.decode(r.authMutation!.create!.postVent!);
          String message =  body["message"];
          showSnackBar("Success", message, false);
          Get.back();
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  @override
  void onClose() {
    postController.dispose();
    super.onClose();
  }
}