import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/repository/dashboardRepo/dashboard_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import '../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../data/queryMutation/auth_query_mutation.dart';
import '../../data/queryMutation/club_query_mutation.dart';

class DashboardController extends GetxController with GetSingleTickerProviderStateMixin
{
  final DashBoardRepo dashBoardRepo;
  DashboardController({required this.dashBoardRepo});
  late TabController tabController;
  var selectedIndex=0.obs;
  var receivedParams=NavigationParamsModel().obs;

  @override
  void onInit() {

    if(Get.arguments!=null)
      {
        receivedParams.value=Get.arguments;
        if(receivedParams.value.routes==Routes.bookingConfirmed)
          {
            selectedIndex.value=1;
          }
      }
    tabController = TabController(length: 5, vsync: this, initialIndex: selectedIndex.value);
    getCountryCodeList();
    getUser();
    getCommunityConfig();
    super.onInit();
  }
  Future<void> getCountryCodeList()
  async {
    try {
      final either=await dashBoardRepo.getCountryCodeList(AuthQueryMutation.getCountryCodeList(""));
      either.fold((l){
      }, (r){
        if(r.countryCodeList!=null && r.countryCodeList!=null &&  r.countryCodeList!.isNotEmpty)
        {
          LocalStorage.setCountryListData(r);
        }
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }
  Future<void> getUser()
  async {
    try {
      final either=await dashBoardRepo.getUser(AuthQueryMutation.getUser());
      either.fold((l){
      }, (r){
        if(r.auth?.getUser!=null)
        {
          LocalStorage.setUserData(r.auth!.getUser!);
        }
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getCommunityConfig() async {
    try {
      final either = await dashBoardRepo.getCommunityConfig(
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
}