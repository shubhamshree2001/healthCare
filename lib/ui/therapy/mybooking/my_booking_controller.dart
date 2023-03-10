import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/models/therapyModel/request/therapy_session_list_response.dart';
import '../../../data/models/therapyModel/therapy_gift_plan_response.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../enum/app_enum.dart';
import '../../../routes/app_pages.dart';
import '../../../service/server_exception_code.dart';
import '../../../widgets/common_widget.dart';

class MyBookingController extends GetxController {
  final TherapyRepo therapyRepo;
  MyBookingController({required this.therapyRepo});
  var therapyPlanList = <TherapyGiftPlan>[].obs;
  var upcomingTherapySessionList = <ListTherapySession>[].obs;
  var pastTherapySessionList = <ListTherapySession>[].obs;
  var upcomingApiCallStatus = ApiCallStatus.holding.obs;
  var passApiCallStatus = ApiCallStatus.holding.obs;
  var therapySession = ListTherapySession().obs;
  var therapySessionPastTotal = 0.obs;
  var therapySessionPastOffset = 0;
  var pastLimit = 0.obs;
  var isShowLastTherapistCard=false.obs;

  @override
  void onInit() {
    initEasyLoading();
    getUpcomingTherapySessionList();
    super.onInit();
  }

  Future<void> getUpcomingTherapySessionList() async {
    try {
      upcomingApiCallStatus.value = ApiCallStatus.loading;
      final either = await therapyRepo.getTherapySessionList(
          TherapyQueryMutation.getTherapySessionList(
              TherapySessionEnum.UPCOMING.name));
      either.fold((l) {
        upcomingApiCallStatus.value = ApiCallStatus.error;
        getPastTherapySessionList(3, 0);
        pastTherapySessionList.clear();
      }, (r) {
        if (r.auth?.listTherapySessions != null &&
            r.auth!.listTherapySessions!.isNotEmpty) {
          upcomingTherapySessionList.value = r.auth!.listTherapySessions!;
          upcomingApiCallStatus.value = ApiCallStatus.success;
        } else {
          upcomingApiCallStatus.value = ApiCallStatus.empty;
        }

        getPastTherapySessionList(3, 0);
        pastTherapySessionList.clear();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      upcomingApiCallStatus.value = ApiCallStatus.error;
      print("Stacktrace==${stacktrace.toString()}");
      getPastTherapySessionList(3, 0);
      pastTherapySessionList.clear();
    }
  }

  Future<void> getPastTherapySessionList(int limit, int offset) async {
    try {
      pastLimit.value = limit;
      if (pastLimit.value == 3) {
        passApiCallStatus.value = ApiCallStatus.loading;
        pastTherapySessionList.clear();
      }
      passApiCallStatus.value = ApiCallStatus.loading;
      final either = await therapyRepo.getTherapySessionList(
          TherapyQueryMutation.getTherapySessionList(
              TherapySessionEnum.PAST.name,
              limit: limit,
              offset: offset));
      either.fold((l) {
        passApiCallStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.listTherapySessions != null &&
            r.auth!.listTherapySessions!.isNotEmpty) {
          therapySessionPastOffset =
              r.therapySessionPastOffset! + r.therapySessionPastLimit!;
          therapySessionPastTotal.value = r.therapySessionPastTotal!;
          pastTherapySessionList.addAll(r.auth!.listTherapySessions!);
          handleIsLastTherapist();
          passApiCallStatus.value = ApiCallStatus.success;
        } else {
          passApiCallStatus.value = ApiCallStatus.empty;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      passApiCallStatus.value = ApiCallStatus.error;
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getTransactionExpiryStatus(String sessionId) async {
    try {
      final either = await therapyRepo.getTransactionExpiryStatus(sessionId);
      either.fold((l) {}, (r) {
        if (r.auth != null && r.auth!.transactionExpiryStatus != null) {
          if (r.auth!.transactionExpiryStatus!.creditExpired != null &&
              r.auth!.transactionExpiryStatus!.creditExpired!) {
            showCustomDialog(
                context: Get.context!,
                message:
                    "The credit used to book this session has expired, you can only reschedule this session.",
                posBtnLabel: "No",
                negBtnLabel: "Reschedule",
                posBtnCallBack: () {
                  Get.back();
                },
                negBtnCallBack: () {
                  Get.back();
                  canRescheduleSession(sessionId);
                },
                removeBtnCallBack: () {
                  Get.back();
                });
          } else if (r.auth!.transactionExpiryStatus!.daysLeft != null &&
              r.auth!.transactionExpiryStatus!.daysLeft! < 3) {
            showCustomDialog(
                context: Get.context!,
                message:
                    "Your credit will expire in ${r.auth!.transactionExpiryStatus!.daysLeft} day(s). Do you want to cancel your appointment?",
                posBtnLabel: "No",
                negBtnLabel: "Yes",
                posBtnCallBack: () {
                  Get.back();
                },
                negBtnCallBack: () {
                  Get.back();
                  cancelSession(sessionId);
                },
                removeBtnCallBack: () {
                  Get.back();
                });
          } else {
            showCustomDialog(
                context: Get.context!,
                message: "Are you sure you want to cancel your appointment?",
                posBtnLabel: "Yes",
                negBtnLabel: "Reschedule Instead",
                posBtnCallBack: () {
                  Get.back();
                  cancelSession(sessionId);
                },
                negBtnCallBack: () {
                  Get.back();
                  canRescheduleSession(sessionId);
                },
                removeBtnCallBack: () {
                  Get.back();
                });
          }
        } else {
          showCustomDialog(
              context: Get.context!,
              message: "Are you sure you want to cancel your appointment?",
              posBtnLabel: "Yes",
              negBtnLabel: "Reschedule Instead",
              posBtnCallBack: () {
                Get.back();
                cancelSession(sessionId);
              },
              negBtnCallBack: () {
                Get.back();
                canRescheduleSession(sessionId);
              },
              removeBtnCallBack: () {
                Get.back();
              });
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> cancelSession(String sessionId) async {
    try {
      final either = await therapyRepo.cancelSession(
          sessionId, TherapyPlanEnum.SESSION.name);
      either.fold((l) {}, (r) {
        if (r.authMutation?.update?.cancel != null &&
            r.authMutation!.update!.cancel!) {
          getUpcomingTherapySessionList();
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> canRescheduleSession(String sessionId) async {
    try {
      final either = await therapyRepo.canRescheduleSession(sessionId);
      either.fold((l) {
        if (l.serverCode == ServerExceptionCode.sessionRescheduleLimitReached) {
          simpleMessageDialogWithoutTitle(
              context: Get.context!,
              message: "You have exhausted your Session Reschedule Limit.");
        }
      }, (r) {
        if (r.auth?.canRescheduleSession != null &&
            r.auth!.canRescheduleSession!) {
          var sendParams = NavigationParamsModel(
              sessionId: sessionId, routes: Routes.myBooking);
          Get.toNamed(Routes.therapyBooking, arguments: sendParams);
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getMeetLink(String sessionId) async {
    try {
      final either = await therapyRepo.getMeetLink(
          sessionId, TherapyPlanEnum.SESSION.name);
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

  Future<void> cancelAppointment(ListTherapySession therapySession) async {
    if (AppUtil.is24HoursLeft(therapySession.session!.schedule!.startDate!)) {
      showCustomMsgDialog(
          context: Get.context!,
          negBtnCallBack: () {
            Get.back();
          });
    } else {
      getTransactionExpiryStatus(therapySession.session!.id!);
    }
  }

  void rescheduleAppointment(ListTherapySession therapySession) {
    this.therapySession.value = therapySession;

    if (AppUtil.is24HoursLeft(therapySession.session!.schedule!.startDate!)) {
      showCustomMsgDialog(
          context: Get.context!,
          message:
              "Appointments cannot be rescheduled when less than 24 hours are remaining for the session.",
          negBtnCallBack: () {
            Get.back();
          });
    } else {
      canRescheduleSession(therapySession.session!.id!);
    }
  }

  void redirectToHomeWorkScreen(ListTherapySession therapySession) {
    var params = NavigationParamsModel(
        sessionTime: AppUtil.convertStringToDateFormat(
            therapySession.session!.schedule!.startDate,
            format: AppUtil.dateTimeYYYYMM),
        routes: Routes.myBooking);
    Get.toNamed(Routes.therapyHomework, arguments: params);
  }

  googleMeet(ListTherapySession therapySession) async {
    String startDate = AppUtil.convertStringToDateFormat(
        therapySession.session!.schedule!.startDate,
        format: AppUtil.dateTimeYYYYMMDDTHHMMSS);
    String endDate = AppUtil.convertStringToDateFormat(
        therapySession.session!.schedule!.endDate,
        format: AppUtil.dateTimeYYYYMMDDTHHMMSS);
    var url =
        '${StringsConstant.googleCalenderUrl}?dates=$startDate/$endDate&location=${therapySession.session!.meeting}&text=Therapy+session+with ${therapySession.session!.doctor!.name}';
    launchWebUrl(url);
  }


  /// This method is used for checking last therapist
  /// If Upcoming session is empty and past session have some data then
  /// we get last therapist info from 0 index of past session list
  void handleIsLastTherapist()
  {
    if(upcomingTherapySessionList.isEmpty)
      {
        if(pastTherapySessionList.isNotEmpty)
          {
            isShowLastTherapistCard.value=true;
          }
      }
  }

  @override
  void onClose() {
    super.onClose();
    EasyLoading.dismiss();
  }
}
