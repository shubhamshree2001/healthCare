import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_list_response.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import '../../../data/models/clubModels/request/community_list_request.dart';
import '../../../data/queryMutation/club_query_mutation.dart';
import '../../../repository/clubRepo/club_repo.dart';

class MoreClubController extends GetxController {
  final ClubRepo clubRepo;

  MoreClubController({required this.clubRepo});

  var communityList = <Community>[].obs;
  var communityListApiStatus = ApiCallStatus.holding.obs;
  var community = Community().obs;
  var communityTotal = 0;
  var communityLimit = 3;
  var communityOffset = 0;
  var selectedIndex =0.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    moreClubPagination();
    getCommunityList();
  }

  Future<void> getCommunityList() async {
    try {
      if (communityOffset == 0) {
        communityList.clear();
        communityListApiStatus.value = ApiCallStatus.loading;
      }

      CommunityListRequest communityListRequest = CommunityListRequest(
        screen: "OTHER",
        limit: communityLimit,
        offset: communityOffset
      );
      final either = await clubRepo.getCommunityList(
          ClubQueryMutation.getCommunityList(),communityListRequest.toMap());
      either.fold((l) {
        communityListApiStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.communitiesList != null &&
            r.auth!.communitiesList!.isNotEmpty) {
          communityTotal = r.communityTotal!;
          communityOffset = r.communityOffset! + r.communityLimit!;
          communityList.addAll(r.auth!.communitiesList!);
          communityListApiStatus.value = ApiCallStatus.success;
        }
        else {
          communityListApiStatus.value = ApiCallStatus.error;
        }
      });
    } catch (e, stacktrace) {
      communityListApiStatus.value = ApiCallStatus.error;
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

  void moreClubPagination() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (communityTotal > communityList.length) {
          getCommunityList();
        }
      }
    });
  }

  void handleUpdateFollowStatus()
  {
    if (communityList[selectedIndex.value].follow!) {
      Community community = communityList[selectedIndex.value];
      community.follow=false;
      community.follower!.followerCount =   community.follower!.followerCount!-1;
      communityList[selectedIndex.value] = community;
    } else {
      Community community = communityList[selectedIndex.value];
      community.follow=true;
      community.follower!.followerCount =   community.follower!.followerCount!+1;
      communityList[selectedIndex.value] = community;
    }
  }


  void backToVentScreen(Community community)
  {
    if(community.slug!=null && community.slug!.isNotEmpty)
      {
        Get.back(result: community);
      }
  }
}