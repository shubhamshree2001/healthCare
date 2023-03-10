import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_auth_mutation_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_auth_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/homework_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_session_response.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/common_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/homework_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/resource_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/therapy_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/exception/failure.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';

import '../../data/models/authModel/country_code_list_response.dart';
import '../../data/models/authModel/user_response.dart';
import '../../data/models/commonResponse/session_cancel_response.dart';
import '../../data/models/commonResponse/transaction_expiry_status_response.dart';
import '../../data/models/therapyModel/cancel_order_response.dart';
import '../../data/models/therapyModel/checkout_response.dart';
import '../../data/models/therapyModel/create_therapy_order.dart';
import '../../data/models/therapyModel/credit_history_response.dart';
import '../../data/models/therapyModel/doctor_details_response.dart';
import '../../data/models/therapyModel/doctor_list_response.dart';
import '../../data/models/therapyModel/get_gift_therapy_order_response.dart';
import '../../data/models/therapyModel/get_gift_therapy_plan_by_id.dart';
import '../../data/models/therapyModel/homework_session_response.dart';
import '../../data/models/therapyModel/payment_success_response.dart';
import '../../data/models/therapyModel/request/therapy_session_list_response.dart';
import '../../data/models/therapyModel/resource_list_response.dart';
import '../../data/models/therapyModel/schedule_list_response.dart';
import '../../data/models/therapyModel/therapy_recommendations_response.dart';
import '../../data/models/therapyModel/therapy_reviews_response.dart';

class TherapyRepoImpl extends TherapyRepo {
  final GraphQLConfiguration graphQLConfiguration;
  TherapyRepoImpl({required this.graphQLConfiguration});

  @override
  Future<Either<Failure, DoctorListResponse>> getDoctorList(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(DoctorListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, DoctorDetailsResponse>> getDoctorDetails(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(DoctorDetailsResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, TherapyReviewsResponse>> getTherapyReviews(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(TherapyReviewsResponse.fromJson(r));
    });
  }

//
  @override
  Future<Either<Failure, TherapyGiftPlanResponse>> getTherapyGiftPlans(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(TherapyGiftPlanResponse.fromJson(r));
    });
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
  Future<Either<Failure, CreateTherapyOrderResponse>> createTherapyOrder(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CreateTherapyOrderResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, GetTherapyGiftOrderResponse>> getGiftTherapyOrder(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(GetTherapyGiftOrderResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, GetTherapyGiftPlanByIdResponse>>
      getTherapyGiftPlanById(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(GetTherapyGiftPlanByIdResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CancelOrderResponse>> cancelOrder(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CancelOrderResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CheckoutResponse>> checkout(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CheckoutResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, ScheduleListResponse>> getSchedulesList(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(ScheduleListResponse.fromJson(r));
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
  Future<Either<Failure, UserResponse>> redeemGift(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(UserResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, UserResponse>> applyCoupon(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(UserResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, TherapySessionListResponse>> getTherapySessionList(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(TherapySessionListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CreditHistoryResponse>> getCreditHistory(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CreditHistoryResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, TherapyRecommendationsResponse>>
      getTherapyRecommendation(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(TherapyRecommendationsResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, PaymentSuccessResponse>> paymentSuccess(
      String query, Map<String, dynamic> variables) async {
    var response =
        await graphQLConfiguration.callMutation(query, variables: variables);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(PaymentSuccessResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, TransactionExpiryStatusResponse>>
      getTransactionExpiryStatus(String sessionId) async {
    var response = await graphQLConfiguration
        .callQuery(CommonQueryMutation.getTransactionExpiryStatus(sessionId));
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(TransactionExpiryStatusResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, SessionCancelResponse>> cancelSession(
      String sessionId, String sessionType) async {
    var response = await graphQLConfiguration.callMutation(
        CommonQueryMutation.cancelSession(sessionId, sessionType));
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(SessionCancelResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommonAuthResponse>> canRescheduleSession(
      String sessionId) async {
    var response = await graphQLConfiguration
        .callQuery(TherapyQueryMutation.canRescheduleSession(sessionId));
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommonAuthResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, TherapySessionResponse>> getTherapySessionById(
      String sessionId) async {
    var response = await graphQLConfiguration
        .callQuery(TherapyQueryMutation.getTherapySessionById(sessionId));
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(TherapySessionResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommonAuthMutationResponse>> rescheduleSession(
      String sessionId, String scheduleId) async {
    var map = {"schedule": scheduleId};
    var response = await graphQLConfiguration.callMutation(
        TherapyQueryMutation.rescheduleSession(sessionId, scheduleId));
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommonAuthMutationResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, ResourceListResponse>> listResources() async {
    var response = await graphQLConfiguration
        .callQuery(ResourceQueryMutation.listResources());
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(ResourceListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, HomeworkSessionResponse>> getHomeworkSession(
      String date) async {
    var response = await graphQLConfiguration
        .callQuery(HomeWorkQueryMutation.getHomeworkSessions(date));
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(HomeworkSessionResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, HomeworkResponse>> getHomework(
      String sessionId) async {
    var response = await graphQLConfiguration
        .callQuery(HomeWorkQueryMutation.getHomework(sessionId));
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(HomeworkResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommonAuthResponse>> getMeetLink(String sessionId, String type) async {
    var response = await graphQLConfiguration
        .callQuery(TherapyQueryMutation.getMeetLink(sessionId,type));
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommonAuthResponse.fromJson(r));
    });
  }
}
