import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/getSignedUrlResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/listPlansbytype_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/login_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/signup_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/submitFeedback_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/deleteUser_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/feedback_questionsList.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/listMyPlans_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/reedemGiftResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/updatePassword_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/updateUser_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/exception/failure.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';

class SettingRepoImpl extends SettingRepo {
  final GraphQLConfiguration graphQLConfiguration;
  SettingRepoImpl({required this.graphQLConfiguration});

  @override
  Future<Either<Failure, CommonResponse>> submitEnquiry(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(CommonResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, CountryCodeListResponse>> getCountryCodeList(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CountryCodeListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, LoginResponse>> sendLinkForgotPass(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(LoginResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, UpdatePasswordResponse>> updatePassword(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(UpdatePasswordResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, UpdateUserResponse>> updateUser(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(UpdateUserResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, FeedbackQuestionsListResponse>>
      getFeedbackQuestionsList(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(FeedbackQuestionsListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, ListMyPlansResponse>> getActivePlansList(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(ListMyPlansResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, ListMyPlansResponse>> getPastPlansList(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(ListMyPlansResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, TherapyGiftPlanResponse>> getTherapyPlanListByType(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(TherapyGiftPlanResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, UpdateUserResponse>> submitUserFeedback(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(UpdateUserResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, DeleteUserResponse>> deleteUser(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(DeleteUserResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, UserResponse>> getUser(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(UserResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, SubmitGiftCouponResponse>> reedemGift(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(SubmitGiftCouponResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, SubmitGiftCouponResponse>> logOut(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(SubmitGiftCouponResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, GetSignedUrlResponse>> getSignedUrl(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(GetSignedUrlResponse.fromJson(r));
    });
  }
}
