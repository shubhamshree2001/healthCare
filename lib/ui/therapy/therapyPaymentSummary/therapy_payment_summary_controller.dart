import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/callback/payment_callback.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/credit_history_response.dart';
import 'package:mindpeers_mobile_flutter/paymentGatway/razorpayService/razorpay_client.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/models/therapyModel/therapy_gift_plan_response.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../enum/app_enum.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class TherapyPaymentSummaryController extends GetxController
    with StateMixin, PaymentCallBack {
  final TherapyRepo therapyRepo;
  TherapyPaymentSummaryController({required this.therapyRepo});
  final couponController = TextEditingController();
  var couponCodeText = "".obs;
  final GlobalKey<FormState> couponFormKey = GlobalKey<FormState>();
  var receiveParams = NavigationParamsModel().obs;
  var therapyPlan = TherapyGiftPlan().obs;
  var discount = 0.0.obs;
  var premiumDiscount = 0.0.obs;
  var countX = 1.obs;
  var gst = 0.0.obs;
  var totalAfterDiscount = 0.0.obs;
  var subtotal = 0.0.obs;
  var grandTotal = 0.0.obs;
  var session = 0.obs;
  var usedCredit = 0.obs;
  var currencySymbol = "₹".obs;
  var creditHistoryList = <CreditHistory>[].obs;
  var creditHistoryApiCallStatus = ApiCallStatus.holding.obs;
  var therapyPlanApiCallStatus = ApiCallStatus.holding.obs;

  @override
  void onInit() {
    initEasyLoading();
    if (Get.arguments != null) {
      receiveParams.value = Get.arguments;
      if (receiveParams.value.planId!.isNotEmpty) {
        getTherapyGiftPlanById();
      }
      if (receiveParams.value.credit! > 0) {
        getCreditHistory(receiveParams.value.selectedSlotList!.length);
      }
    }
    super.onInit();
  }

  Future<void> getTherapyGiftPlanById() async {
    therapyPlanApiCallStatus.value = ApiCallStatus.loading;
    try {
      final either = await therapyRepo.getTherapyGiftPlanById(
          TherapyQueryMutation.getTherapyGiftPlanById(
              receiveParams.value.planId!));
      either.fold((l) {
        therapyPlanApiCallStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.therapyGiftPlan != null) {
          therapyPlan.value = r.auth!.therapyGiftPlan!;
          calculatePaymentSummary();
          therapyPlanApiCallStatus.value = ApiCallStatus.success;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      therapyPlanApiCallStatus.value = ApiCallStatus.error;
    }
  }

  Future<void> getCreditHistory(int credit) async {
    creditHistoryApiCallStatus.value = ApiCallStatus.loading;
    try {
      final either = await therapyRepo
          .getCreditHistory(TherapyQueryMutation.getCreditHistory(credit));
      either.fold((l) {
        creditHistoryApiCallStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth != null &&
            r.auth?.creditHistoryList != null &&
            r.auth!.creditHistoryList!.isNotEmpty) {
          creditHistoryList.value = r.auth!.creditHistoryList!;
          creditHistoryApiCallStatus.value = ApiCallStatus.success;
        } else {
          creditHistoryApiCallStatus.value = ApiCallStatus.error;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      creditHistoryApiCallStatus.value = ApiCallStatus.error;
    }
  }

  Future<void> cancelOrder() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either = await therapyRepo.cancelOrder(
          TherapyQueryMutation.cancelOrder(
              receiveParams.value.orderId!, TherapyPlanEnum.SESSION.name));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r) {
        if (r.authMutation?.update?.cancelOrder != null &&
            r.authMutation!.update!.cancelOrder) {
          Navigator.pop(Get.context!);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> applyCoupon() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await therapyRepo
          .applyCoupon(TherapyQueryMutation.applyCoupon(couponController.text));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r) {
        if (r.auth != null) {}
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      log("Exception==$e");
      log("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> checkout() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either = await therapyRepo.checkout(TherapyQueryMutation.checkout(
          receiveParams.value.orderId!, receiveParams.value.planId!));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r) {
        if (r.authMutation?.update?.checkout != null) {
          if (r.authMutation!.update!.checkout!.gateway ==
              RazorPayClient.RAZORPAY) {
            Get.find<RazorPayClient>()
                .razorPayCheckout(r.authMutation!.update!.checkout!, this);
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

  /// Calculation of payment summary
  void calculatePaymentSummary() {
    if (therapyPlan.value.standard!) {
      countX.value = receiveParams.value.selectedSlotList!.length;
      if (therapyPlan.value.discount != null &&
          therapyPlan.value.discount! > 0) {
        discount.value = countX.value * therapyPlan.value.discount!.toDouble();
      }
      if (therapyPlan.value.summary?.premium?.value != null &&
          therapyPlan.value.summary!.premium!.value! > 0) {
        premiumDiscount.value = countX.value *
            therapyPlan.value.summary!.premium!.value!.toDouble();
      }
      if (therapyPlan.value.summary?.tax != null &&
          therapyPlan.value.summary!.tax! > 0) {
        gst.value = countX.value * therapyPlan.value.summary!.tax!.toDouble();
      }
      if (therapyPlan.value.summary?.total?.sub != null &&
          therapyPlan.value.summary!.total!.sub! > 0) {
        totalAfterDiscount.value =
            countX.value * therapyPlan.value.summary!.total!.sub!.toDouble();
        subtotal.value =
            countX.value * therapyPlan.value.summary!.total!.sub!.toDouble();
      }
      if (therapyPlan.value.summary?.total != null &&
          therapyPlan.value.summary!.total!.grand > 0) {
        grandTotal.value =
            countX.value * therapyPlan.value.summary!.total!.grand.toDouble();
      }
      if (therapyPlan.value.units?.session != null &&
          therapyPlan.value.units!.session! > 0) {
        session.value = therapyPlan.value.units!.session!;
      }
      if (therapyPlan.value.region?.currency?.symbol != null) {
        currencySymbol.value = therapyPlan.value.region!.currency!.symbol!;
      }
    } else {
      countX.value = 1;
      if (therapyPlan.value.discount != null &&
          therapyPlan.value.discount! > 0) {
        discount.value = countX.value * therapyPlan.value.discount!.toDouble();
      }
      if (therapyPlan.value.summary?.premium?.value != null &&
          therapyPlan.value.summary!.premium!.value! > 0) {
        premiumDiscount.value = countX.value *
            therapyPlan.value.summary!.premium!.value!.toDouble();
      }
      if (therapyPlan.value.summary?.tax != null &&
          therapyPlan.value.summary!.tax! > 0) {
        gst.value = countX.value * therapyPlan.value.summary!.tax!.toDouble();
      }
      if (therapyPlan.value.summary?.total?.sub != null &&
          therapyPlan.value.summary!.total!.sub! > 0) {
        totalAfterDiscount.value =
            countX.value * therapyPlan.value.summary!.total!.sub!.toDouble();
        subtotal.value =
            countX.value * therapyPlan.value.summary!.total!.sub!.toDouble();
      }
      if (therapyPlan.value.summary?.total != null &&
          therapyPlan.value.summary!.total!.grand > 0) {
        grandTotal.value =
            countX.value * therapyPlan.value.summary!.total!.grand.toDouble();
      }
      if (therapyPlan.value.units?.session != null &&
          therapyPlan.value.units!.session! > 0) {
        session.value = therapyPlan.value.units!.session!;
      }
      if (therapyPlan.value.region?.currency?.symbol != null) {
        currencySymbol.value = therapyPlan.value.region!.currency!.symbol!;
      }
    }
  }

  void calculateRemainingCredits() {
    if (receiveParams.value.selectedSlotList?.length == 2 &&
        creditHistoryList.length == 2) {
      usedCredit.value = 1;
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    final result = await showCustomDialog(
        context: context,
        posBtnCallBack: () {
          cancelOrder();
          Get.back();
        },
        negBtnCallBack: () => Get.back(),
        removeBtnCallBack: () => Get.back());

    if (result == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void onClose() {
    couponController.dispose();
  }

  void checkCouponValidation() {
    hideSoftKeyboard(Get.context!);
    /*final isValid = couponFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    couponFormKey.currentState!.save();*/
    if (couponController.text.isEmpty) {
      showSnackBar("Error", "Please Enter Promo Code", true);
    } else {
      applyCoupon();
    }
  }

  @override
  void onPaymentFailed(response, String type) {}

  @override
  void onPaymentSuccess(response, String type) {
    if (type == RazorPayClient.RAZORPAY) {
      PaymentSuccessResponse paymentSuccessResponse =
          response as PaymentSuccessResponse;
      HashMap<String, dynamic> map = HashMap.from({
        "\"razorpay_payment_id\"": "\"${paymentSuccessResponse.paymentId}\"",
        "\"razorpay_order_id\"": "\"${paymentSuccessResponse.orderId}\"",
        "\"razorpay_signature\"": "\"${paymentSuccessResponse.signature}\"",
      });

      var params = NavigationParamsModel(
          doctorItem: receiveParams.value.doctorItem,
          razorPayResponse: map.toString(),
          gateway: RazorPayClient.RAZORPAY,
          routes: Routes.therapyPaymentSummary);
      Get.toNamed(Routes.bookingConfirmed, arguments: params);
    }
  }

  void redirectToBookingConfirmedScreen() {
    if (receiveParams.value.planId!.isNotEmpty) {
      checkout();
    } else {
      HashMap<String, dynamic> map = HashMap.from({
        "\"order\"": "\"${receiveParams.value.orderId}\"",
      });
      var params = NavigationParamsModel(
          doctorItem: receiveParams.value.doctorItem,
          razorPayResponse: map.toString(),
          gateway: TherapyPlanEnum.WALLET.name,
          routes: Routes.therapyPaymentSummary,
          orderId: receiveParams.value.orderId);
      Get.toNamed(Routes.bookingConfirmed, arguments: params);
    }
  }
}
