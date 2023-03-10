import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/doctor_list_response.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/models/therapyModel/schedule_list_response.dart';
import '../../../data/models/therapyModel/therapy_gift_plan_response.dart';
import '../../../data/queryMutation/auth_query_mutation.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../enum/app_enum.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class TherapySlotDetailsController extends GetxController with StateMixin {
  final TherapyRepo therapyRepo;
  TherapySlotDetailsController({required this.therapyRepo});
  final redeemController = TextEditingController();
  var user = GetUser().obs;
  var orderId;
  var selectedSlotList = <Schedule>[].obs;
  var doctorItem = DoctorItem().obs;
  var therapyPlanList = <TherapyGiftPlan>[].obs;
  var therapyPlanListCopy = <TherapyGiftPlan>[].obs;
  var selectedPlanIndex = 0.obs;
  var selectedPlanIndexCopy = 0.obs;
  var session = 0.obs;
  var selectedTherapyPlan = TherapyGiftPlan().obs;
  var addonChecked = false.obs;
  var btnPayNow = "Pay Now".obs;
  var btnPlanSheet = "Proceed To Pay".obs;
  var isShowBtnPlanSheet = true.obs;

  @override
  void onInit() {
    initEasyLoading();
    if (Get.arguments != null) {
      orderId = Get.arguments[0];
      doctorItem = Get.arguments[1];
      selectedSlotList = Get.arguments[2];
    }
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    try {
      change(null, status: RxStatus.loading());
      final either = await therapyRepo.getUser(AuthQueryMutation.getUser());
      either.fold((l) {
        change(null, status: RxStatus.error(l.errorMessage));
      }, (r) {
        if (r.auth?.getUser != null) {
          user.value = r.auth!.getUser!;
          if (user.value.units?.session != null) {
            session.value = user.value.units!.session!;
            updateUI();
          }
          getTherapyPlanByType();
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      change(null, status: RxStatus.error());
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getTherapyPlanByType() async {
    try {
      change(null, status: RxStatus.loading());
      final either = await therapyRepo.getTherapyGiftPlans(
          TherapyQueryMutation.getPlanListByType(
              LocalStorage.getAccessToken(),
              TherapyPlanEnum.SESSION.name));
      either.fold((l) {
        change(null, status: RxStatus.error(l.errorMessage));
      }, (r) {
        if (r.auth?.therapyGiftPlanList != null &&
            r.auth!.therapyGiftPlanList!.isNotEmpty) {
          if (session.value > 0 && session.value < 4) {
            for (int i = 0; i < r.auth!.therapyGiftPlanList!.length; i++) {
              if (r.auth!.therapyGiftPlanList![i].standard != null &&
                  !r.auth!.therapyGiftPlanList![i].standard!) {
                therapyPlanList.add(r.auth!.therapyGiftPlanList![i]);
              }
            }

            therapyPlanListCopy.value = List.from(therapyPlanList);
          } else {
            therapyPlanList.value = r.auth!.therapyGiftPlanList!;
            therapyPlanListCopy.value = List.from(therapyPlanList);
          }
          change(null, status: RxStatus.success());
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      change(null, status: RxStatus.error());
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getTherapyOrder() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either = await therapyRepo.getGiftTherapyOrder(
          TherapyQueryMutation.getTherapyGiftOrder(orderId));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r) {
        if (r.auth?.getOrder?.id != null && r.auth!.getOrder!.id.isNotEmpty) {
          if (!(r.auth!.getOrder!.completed) && !(r.auth!.getOrder!.timedout)) {
            redirectToPaymentSummaryScreen(r.auth!.getOrder!.id);
          } else if (r.auth!.getOrder!.completed) {
            showSnackBar("Error", "Already Completed", true);
          } else if (r.auth!.getOrder!.timedout) {
            showSnackBar("Error", "Timeout Error", true);
          }
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> redeemGift() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await therapyRepo
          .redeemGift(TherapyQueryMutation.redeemGift(redeemController.text));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r) {
        if (r.auth != null) {}
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void redirectToPaymentSummaryScreen(String orderId) {
    var sendParams = NavigationParamsModel(
        planId: selectedPlanIndex.value == -1 || session.value > 3
            ? ""
            : therapyPlanList[selectedPlanIndex.value].id,
        orderId: orderId,
        selectedSlotList: selectedSlotList,
        doctorItem: doctorItem.value,
        credit: user.value.units?.session);
    Get.offAndToNamed(Routes.therapyPaymentSummary, arguments: sendParams);
  }

  void checkRedeemValidation() {
    if (redeemController.text.isEmpty) {
      showSnackBar("Error", "Please enter the gift code", true);
    } else {
      redeemGift();
    }
  }

  @override
  void onClose() {
    redeemController.dispose();
    super.onClose();
  }

  void swappingTherapyPlan() {
    if (session.value > 0 && session.value < 4) {
      therapyPlanList[0] = therapyPlanListCopy[selectedPlanIndexCopy.value];
      selectedPlanIndex.value = 0;
    } else {
      if (selectedPlanIndexCopy.value != 0) {
        therapyPlanList[0] = therapyPlanListCopy[selectedPlanIndexCopy.value];
        therapyPlanList[1] = therapyPlanListCopy[0];
        selectedPlanIndex.value = 0;
      }
    }
  }

  void setSelectedItemForSheet() {
    if (session.value > 0 && session.value < 4) {
      if (selectedPlanIndex.value != -1) {
        for (int i = 0; i < therapyPlanList.length; i++) {
          TherapyGiftPlan item = therapyPlanList[selectedPlanIndex.value];
          TherapyGiftPlan itemCopy = therapyPlanListCopy[i];

          if (item.id == itemCopy.id) {
            selectedPlanIndexCopy.value = i;
            btnPlanSheet.value =
                "Continue with ${itemCopy.units!.session} Session Plan";
          }
        }
        isShowBtnPlanSheet.value = true;
      } else {
        selectedPlanIndexCopy.value = -1;
        isShowBtnPlanSheet.value = false;
      }
    } else {
      for (int i = 0; i < therapyPlanList.length; i++) {
        TherapyGiftPlan item = therapyPlanList[selectedPlanIndex.value];
        TherapyGiftPlan itemCopy = therapyPlanListCopy[i];
        if (item.id == itemCopy.id) {
          selectedPlanIndexCopy.value = i;
        }
      }
    }
  }

  void updateUI() {
    if (session.value > 0 && session.value < 4) {
      if (selectedPlanIndex.value != -1) {
        btnPayNow.value = "Recharge & Book";
      } else {
        btnPayNow.value = "Use Credits";
      }
    } else if (session.value > 3) {
      btnPayNow.value = "Use Credits";
    } else {
      btnPayNow.value = "Pay Now";
    }
  }
}
