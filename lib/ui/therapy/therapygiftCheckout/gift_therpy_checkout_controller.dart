import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/request/create_gift_therapy_order_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/therapy_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../callback/payment_callback.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../paymentGatway/razorpayService/razorpay_client.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class GiftTherapyCheckoutController extends GetxController
    with StateMixin<TherapyGiftPlan>, PaymentCallBack {
  final TherapyRepo therapyRepo;
  GiftTherapyCheckoutController({required this.therapyRepo});

  var planId = "";
  var orderId = "";
  var routes = "";
  var planType = "";
  var therapyGiftPlan = TherapyGiftPlan().obs;

  @override
  void onInit() {
    super.onInit();
    initEasyLoading();

    if(Get.arguments!=null) {
      NavigationParamsModel receivedParams = Get.arguments;
      if(receivedParams.routes ==Routes.vents || receivedParams.routes ==Routes.giftRecipientDetails)
      {
        planId = receivedParams.planId!;
        orderId = receivedParams.orderId!;
        routes = receivedParams.routes!;
        if(routes == Routes.giftRecipientDetails)
          {
            planType = TherapyPlanEnum.GIFT.name;
          }
        else if(routes == Routes.vents)
          {
            planType = TherapyPlanEnum.VENT_GIFT.name;
          }
      }
    }

    getTherapyGiftPlanById();
  }

  Future<void> getTherapyGiftPlanById() async {
    change(null, status: RxStatus.loading());
    try {
      final either = await therapyRepo.getTherapyGiftPlanById(
          TherapyQueryMutation.getTherapyGiftPlanById(planId));
      either.fold((l) {
        change(null, status: RxStatus.error(l.errorMessage));
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth?.therapyGiftPlan != null) {
          therapyGiftPlan.value = r.auth!.therapyGiftPlan!;
          change(therapyGiftPlan.value, status: RxStatus.success());
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      change(null, status: RxStatus.error());
    }
  }

  Future<void> cancelOrder() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either = await therapyRepo.cancelOrder(
          TherapyQueryMutation.cancelOrder(orderId, planType));
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

  Future<void> checkout() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either = await therapyRepo
          .checkout(TherapyQueryMutation.checkout(orderId, planId));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r) {
        if (r.authMutation?.update?.checkout != null) {
          //  Get.toNamed(Routes.giftTherapyCheckoutSuccess);
          Get.find<RazorPayClient>()
              .razorPayCheckout(r.authMutation!.update!.checkout!, this);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void redirectToWebView(String url) {
    Get.toNamed('${Routes.webView}?${StringsConstant.urlKey}=$url');
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
          razorPayResponse: map.toString(),
          gateway: RazorPayClient.RAZORPAY,
          routes: Routes.giftTherapyCheckout);
      Get.toNamed(Routes.bookingConfirmed, arguments: params);
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }
}
