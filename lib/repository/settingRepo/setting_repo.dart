import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/getSignedUrlResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/listPlansbytype_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/login_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/signup_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/deleteUser_response.dart';

import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/feedback_questionsList.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/listMyPlans_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/reedemGiftResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/updatePassword_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/updateUser_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';

import 'package:mindpeers_mobile_flutter/exception/failure.dart';

abstract class SettingRepo {
  Future<Either<Failure, CommonResponse>> submitEnquiry(String query);
  Future<Either<Failure, CountryCodeListResponse>> getCountryCodeList(
      String query);
  Future<Either<Failure, LoginResponse>> sendLinkForgotPass(String query);
  Future<Either<Failure, UpdatePasswordResponse>> updatePassword(String query);
  Future<Either<Failure, UpdateUserResponse>> updateUser(String query);
  Future<Either<Failure, FeedbackQuestionsListResponse>>
      getFeedbackQuestionsList(String query);
  Future<Either<Failure, ListMyPlansResponse>> getActivePlansList(String query);
  Future<Either<Failure, ListMyPlansResponse>> getPastPlansList(String query);
  Future<Either<Failure, TherapyGiftPlanResponse>> getTherapyPlanListByType(
      String query);
  Future<Either<Failure, DeleteUserResponse>> deleteUser(String query);
  Future<Either<Failure, UserResponse>> getUser(String query);
  Future<Either<Failure, UpdateUserResponse>> submitUserFeedback(String query);
  Future<Either<Failure, SubmitGiftCouponResponse>> reedemGift(String query);
  Future<Either<Failure, SubmitGiftCouponResponse>> logOut(String query);
  Future<Either<Failure, GetSignedUrlResponse>> getSignedUrl(String query);
}
