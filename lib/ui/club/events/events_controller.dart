import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/event_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/request/community_list_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import '../../../data/models/clubModels/community_info_response.dart';
import '../../../data/models/clubModels/vent_list_response.dart';
import '../../../data/models/therapyModel/doctor_list_response.dart';
import '../../../data/queryMutation/club_query_mutation.dart';
import '../../../repository/clubRepo/club_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class EventsController extends GetxController {
  final ClubRepo clubRepo;

  EventsController({required this.clubRepo});

  var eventList = <CommunityEvent>[].obs;
  var eventListApiStatus = ApiCallStatus.holding.obs;
  var scrollController = ScrollController(initialScrollOffset: 0);
  var selectedEventIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getEventList();
  }


  Future<void> getEventList() async {
    try {
      eventListApiStatus.value = ApiCallStatus.loading;
      final either = await clubRepo.getEventList(
          ClubQueryMutation.listCommunityEvents(""));
      either.fold((l) {
        eventListApiStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.eventList!= null && r.auth!.eventList!.isNotEmpty) {
          eventList.value = r.auth!.eventList!;
          eventListApiStatus.value = ApiCallStatus.success;
        } else {
          eventListApiStatus.value = ApiCallStatus.error;
        }
      });
    } catch (e, stacktrace) {
      eventListApiStatus.value = ApiCallStatus.error;
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getBoatAvailability(String slug) async {
    try {
      final either = await clubRepo.getBoatAvailability(
          ClubQueryMutation.getBoatAvailability(slug));
      either.fold((l) {
       showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth?.getBoatAvailability!= null && r.auth!.getBoatAvailability!) {
          redirectToEventDetailsScreen(slug);
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

  void redirectToEventDetailsScreen(String slug)
  {
    NavigationParamsModel navigationParamsModel = NavigationParamsModel(
        routes: Routes.events,
        slug: slug
    );
    Get.toNamed(Routes.eventsDetails,arguments: navigationParamsModel);
  }

  void shareData(Share? share) {
    if (share != null) {
      shareSocial(
          context: Get.context!,
          title: "",
          description: share.text!,
          url: share.url!);
    }
  }

}
