import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/clubRepo/club_repo.dart';
import 'package:mindpeers_mobile_flutter/ui/club/events/events_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/vents/vents_controller.dart';
import '../../data/localStorage/local_storage.dart';
import '../../data/models/clubModels/community_config_response.dart';
import '../../data/queryMutation/club_query_mutation.dart';
class ClubController extends GetxController with GetSingleTickerProviderStateMixin
{
  final ClubRepo clubRepo;
  ClubController({required this.clubRepo});

  late TabController tabController;
  var selectedIndex=0.obs;
  var isShowNewClubDialog=false.obs;
  var featureInfoScreen = FeatureInfoScreen().obs;
  var selectedNewClubItem=0.obs;
  var isPaid=false.obs;
  @override
  void onInit() {
    handleCommunityConfig();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.onInit();
  }

  Future<void> getCommunityConfig() async {
    try {
      final either = await clubRepo.getCommunityConfig(
          ClubQueryMutation.getCommunityConfig());
      either.fold((l) {
      }, (r) {
        if (r.auth?.communityConfig!=null) {
          LocalStorage.setCommunityConfig(r.auth!.communityConfig!);
        }
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  void onTabListeners(int index)
  {
    if(index==0)
    {
      if(Get.find<VentsController>()!=null)
        {
          Get.find<VentsController>().getCommunityConfig();
         // Get.find<VentsController>().animateClubItem(0);
        }
    }
    else if(index == 1)
      {
        if( Get.find<EventsController>()!=null)
          {
            Get.find<EventsController>().getEventList();
          }
      }
  }

  void handleCommunityConfig()
  {
    var communityConfig = LocalStorage.getCommunityConfig();
    if(communityConfig.featureInfoScreen!=null && communityConfig.featureInfoScreen!.asset!.isNotEmpty)
      {
        if(LocalStorage.getIsShowNewClubSliderView())
          {
            featureInfoScreen.value = communityConfig.featureInfoScreen!;
            isShowNewClubDialog.value=true;
          }
      }

      isPaid.value = communityConfig.isPaid!;
  }
}