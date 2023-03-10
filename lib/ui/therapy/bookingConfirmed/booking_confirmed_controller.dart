import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_recommendations_response.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/models/therapyModel/recommend_friend_rating_response.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../enum/app_enum.dart';
import '../../../paymentGatway/razorpayService/razorpay_client.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class BookingConfirmedController extends GetxController
{
  final TherapyRepo therapyRepo;
  BookingConfirmedController({required this.therapyRepo});
  var receiveParams=NavigationParamsModel().obs;
  var paymentApiCallStatus = ApiCallStatus.holding.obs;
  var recommendedRatingList=<RecommendFriendRating>[].obs;
  var selectedRatingIndex=12.obs;
  var therapyRecommendApiCallStatus= ApiCallStatus.holding.obs;
  var therapyRecommendations=TherapyRecommendations().obs;
  var recommendationList=<Recommendation>[].obs;
  var isHideRecommendation=true.obs;

  @override
  void onInit() {
    initEasyLoading();
    makingRatingList();
    if(Get.arguments!=null)
      {
        receiveParams.value=Get.arguments;
        if(receiveParams.value.routes==Routes.therapyBooking)
         {
           Timer(const Duration(seconds: 3), ()=>redirectToTherapyScreen());
         }
        else if(receiveParams.value.routes==Routes.therapyPaymentSummary)
         {
           successPayment(TherapyPlanEnum.SESSION.name);
         }
        else if(receiveParams.value.routes==Routes.giftTherapyCheckout)
          {
            successPayment(TherapyPlanEnum.GIFT.name);
          }

      }
    super.onInit();
  }

  void makingRatingList()
  {
    recommendedRatingList.add(
        RecommendFriendRating(
        colorInactive: const Color(0XFFFFD3D3),
        colorActive: const Color(0XFFFFA7A7),
        colorBorder: const Color(0XFF720303),
        rating: 1));
    recommendedRatingList.add(
        RecommendFriendRating(
            colorInactive: const Color(0XFFFFD3D3),
            colorActive: const Color(0XFFFFA7A7),
            colorBorder: const Color(0XFF720303),
            rating: 2));
    recommendedRatingList.add(
        RecommendFriendRating(
            colorInactive: const Color(0XFFFFD3D3),
            colorActive: const Color(0XFFFFA7A7),
            colorBorder: const Color(0XFF720303),
            rating: 3));
    recommendedRatingList.add(
        RecommendFriendRating(
            colorInactive: const Color(0XFFFDF2BB),
            colorActive: const Color(0XFFFFE773),
            colorBorder: const Color(0XFF867109),
            rating: 4));
    recommendedRatingList.add(
        RecommendFriendRating(
            colorInactive: const Color(0XFFFDF2BB),
            colorActive: const Color(0XFFFFE773),
            colorBorder: const Color(0XFF867109),
            rating: 5));
    recommendedRatingList.add(
        RecommendFriendRating(
            colorInactive: const Color(0XFFFDF2BB),
            colorActive: const Color(0XFFFFE773),
            colorBorder: const Color(0XFF867109),
            rating: 6));
    recommendedRatingList.add(
        RecommendFriendRating(
            colorInactive: const Color(0XFFFDF2BB),
            colorActive: const Color(0XFFFFE773),
            colorBorder: const Color(0XFF867109),
            rating: 7));
    recommendedRatingList.add(
        RecommendFriendRating(
            colorInactive: const Color(0XFFC8FDB5),
            colorActive: const Color(0XFF88F361),
            colorBorder: const Color(0XFF2FB100),
            rating: 8));
    recommendedRatingList.add(
        RecommendFriendRating(
            colorInactive: const Color(0XFFC8FDB5),
            colorActive: const Color(0XFF88F361),
            colorBorder: const Color(0XFF2FB100),
            rating: 9));
    recommendedRatingList.add(
        RecommendFriendRating(
            colorInactive: const Color(0XFFC8FDB5),
            colorActive: const Color(0XFF88F361),
            colorBorder: const Color(0XFF2FB100),
            rating: 10));
  }

  Future<void> successPayment(String type)
  async {
    paymentApiCallStatus.value=ApiCallStatus.loading;
    var variables={"body":receiveParams.value.razorPayResponse};
    try {
      final either=await therapyRepo.paymentSuccess(TherapyQueryMutation.successPayment(receiveParams.value.gateway!,type),variables);
      either.fold((l){
        paymentApiCallStatus.value=ApiCallStatus.error;
      }, (r){
        if(r.authMutation!=null && r.authMutation?.update?.success!=null && r.authMutation!.update!.success)
        {
          paymentApiCallStatus.value=ApiCallStatus.success;
          getTherapyRecommendation();
        }
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      paymentApiCallStatus.value=ApiCallStatus.error;
    }
  }

  Future<void> getTherapyRecommendation()
  async {
    therapyRecommendApiCallStatus.value=ApiCallStatus.loading;
    try {
      final either=await therapyRepo.getTherapyRecommendation(TherapyQueryMutation.therapyRecommendations(receiveParams.value.doctorItem!.user!.id!));
      either.fold((l){
        therapyRecommendApiCallStatus.value=ApiCallStatus.error;
      }, (r){
        if(r.auth!=null && r.auth?.therapyRecommendations!=null)
        {
          therapyRecommendations.value=r.auth!.therapyRecommendations!;
          if(r.auth?.therapyRecommendations?.recommendations!=null && r.auth!.therapyRecommendations!.recommendations!.isNotEmpty)
            {
              recommendationList.value = r.auth!.therapyRecommendations!.recommendations!;
              therapyRecommendApiCallStatus.value=ApiCallStatus.success;
            }
        }
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      therapyRecommendApiCallStatus.value=ApiCallStatus.error;
    }
  }

  hideRecommendedView()
  {
    Timer(const Duration(seconds: 3), () {
     isHideRecommendation.value=false;
    });
  }

  Future<bool> redirectToTherapyScreen()async
  {
    var params=NavigationParamsModel(
        routes: Routes.bookingConfirmed,
    );
    Get.offAllNamed(Routes.dashboard,arguments: params);
    return true;
  }


  @override
  void onClose() {
  }
}