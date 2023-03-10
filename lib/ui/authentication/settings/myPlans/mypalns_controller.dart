import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/giftCouponRequest.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/listMyPlans_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/setting_query_Mutation.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/therapy_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';

class MyPlansController extends GetxController {
  final SettingRepo settingRepo;
  MyPlansController({required this.settingRepo});
  final giftCardController = TextEditingController();
  final GlobalKey<FormState> giftCouponFormKey = GlobalKey<FormState>();
  var plansList = <Plan>[].obs;
  var pastPlansList = <Plan>[].obs;
  var credits = Credits().obs;
  var therapyPlansList = <TherapyGiftPlan>[].obs;
  var communityPlansList = <TherapyGiftPlan>[].obs;
  var selectedPlanIndex = 0.obs;
  var summaryCardTypeList = <SummaryCard>[].obs;
  var isLoader = false.obs;
  var isSuccess = false.obs;

  var subHeading = "".obs;

  var readOnly = false.obs;
  @override
  void onInit() {
    initEasyLoading();
    getMyActivePlans();
    getMyPastPlans();
    getTherapyPlansToPurchase();
    getCommunityPlansToPurchase();

    super.onInit();
  }

  Future<void> getMyActivePlans() async {
    isLoader.value = true;
    try {
      final either = await settingRepo
          .getActivePlansList(SettingQueryMutation.getActivePlansList(
        LocalStorage.getAccessToken(),
      ));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        isLoader.value = false;
      }, (r) {
        if (r.auth?.listMyPlans?.plans != null &&
            r.auth!.listMyPlans!.plans!.isNotEmpty) {
          if (r.auth?.listMyPlans?.summaryCards != null &&
              r.auth!.listMyPlans!.summaryCards!.isNotEmpty) {
            summaryCardTypeList.value = r.auth!.listMyPlans!.summaryCards!;
          }
          plansList.value = r.auth!.listMyPlans!.plans!;
          isSuccess.value = true;
          //getMyPastPlans();
        }

        isLoader.value = false;
      });
    } catch (e, stacktrace) {
      isLoader.value = false;
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> submitRedeemGiftCoupon(String query) async {
    try {
      final either = await settingRepo.reedemGift(query);
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.authMutation != null && r.authMutation!.update != null) {
          showSnackBar("success", "gift code is valid", false);
          Get.back();
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getMyPastPlans() async {
    isLoader.value = true;
    try {
      final either = await settingRepo
          .getPastPlansList(SettingQueryMutation.getPastPlansList(
        LocalStorage.getAccessToken(),
      ));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        isLoader.value = false;
      }, (r) {
        if (r.auth?.listMyPlans?.plans != null &&
            r.auth!.listMyPlans!.plans!.isNotEmpty) {
          if (r.auth!.listMyPlans!.credits != null) {
            credits.value = r.auth!.listMyPlans!.credits!;
          }
          pastPlansList.value = r.auth!.listMyPlans!.plans!;
        }

        isLoader.value = false;
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> getTherapyPlansToPurchase() async {
    try {
      final either = await settingRepo.getTherapyPlanListByType(
          TherapyQueryMutation.getPlanListByType(
        LocalStorage.getAccessToken(),
        TherapyPlanEnum.SESSION.name,
      ));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth?.therapyGiftPlanList != null &&
            r.auth!.therapyGiftPlanList!.isNotEmpty) {
          therapyPlansList.value = r.auth!.therapyGiftPlanList!;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");

      EasyLoading.dismiss();
    }
  }

  Future<void> getCommunityPlansToPurchase() async {
    try {
      final either = await settingRepo.getTherapyPlanListByType(
          TherapyQueryMutation.getPlanListByType(
        LocalStorage.getAccessToken(),
        TherapyPlanEnum.COMMUNITY.name,
      ));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth?.therapyGiftPlanList != null &&
            r.auth!.therapyGiftPlanList!.isNotEmpty) {
          communityPlansList.value = r.auth!.therapyGiftPlanList!;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void sendRedeemCoupon() {
    hideSoftKeyboard(Get.context!);
    if (giftCardController.text.isNotEmpty) {
      var submitGiftCoupon =
          GiftCouponRequest(giftCode: giftCardController.text);
      submitRedeemGiftCoupon(SettingQueryMutation.redeemGift(submitGiftCoupon));
    }
  }

  void checkGiftVouponValidation() {
    hideSoftKeyboard(Get.context!);
    final isValid = giftCouponFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    giftCouponFormKey.currentState!.save();
    sendRedeemCoupon();
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    giftCardController.dispose();
  }
}
