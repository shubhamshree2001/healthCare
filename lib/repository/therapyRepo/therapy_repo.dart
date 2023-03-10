import 'dart:collection';

import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_auth_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/checkout_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/doctor_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/get_gift_therapy_order_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/homework_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/homework_session_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/schedule_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_session_response.dart';
import '../../data/models/authModel/country_code_list_response.dart';
import '../../data/models/commonResponse/common_auth_mutation_response.dart';
import '../../data/models/commonResponse/session_cancel_response.dart';
import '../../data/models/commonResponse/transaction_expiry_status_response.dart';
import '../../data/models/therapyModel/cancel_order_response.dart';
import '../../data/models/therapyModel/create_therapy_order.dart';
import '../../data/models/therapyModel/credit_history_response.dart';
import '../../data/models/therapyModel/doctor_details_response.dart';
import '../../data/models/therapyModel/get_gift_therapy_plan_by_id.dart';
import '../../data/models/therapyModel/payment_success_response.dart';
import '../../data/models/therapyModel/request/therapy_session_list_response.dart';
import '../../data/models/therapyModel/resource_list_response.dart';
import '../../data/models/therapyModel/therapy_recommendations_response.dart';
import '../../data/models/therapyModel/therapy_reviews_response.dart';
import '../../exception/failure.dart';

abstract class TherapyRepo {
  Future<Either<Failure, DoctorListResponse>> getDoctorList(String query);
  Future<Either<Failure, DoctorDetailsResponse>> getDoctorDetails(String query);
  Future<Either<Failure, TherapyReviewsResponse>> getTherapyReviews(
      String query);
  Future<Either<Failure, TherapyGiftPlanResponse>> getTherapyGiftPlans(
      String query); //
  Future<Either<Failure, CountryCodeListResponse>> getCountryCodeList(
      String query);
  Future<Either<Failure, CreateTherapyOrderResponse>> createTherapyOrder(
      String query);
  Future<Either<Failure, GetTherapyGiftOrderResponse>> getGiftTherapyOrder(
      String query);
  Future<Either<Failure, GetTherapyGiftPlanByIdResponse>>
      getTherapyGiftPlanById(String query);
  Future<Either<Failure, CancelOrderResponse>> cancelOrder(String query);
  Future<Either<Failure, CheckoutResponse>> checkout(String query);
  Future<Either<Failure, ScheduleListResponse>> getSchedulesList(String query);
  Future<Either<Failure, UserResponse>> getUser(String query);
  Future<Either<Failure, UserResponse>> redeemGift(String query);
  Future<Either<Failure, UserResponse>> applyCoupon(String query);
  Future<Either<Failure, TherapySessionListResponse>> getTherapySessionList(
      String query);
  Future<Either<Failure, CreditHistoryResponse>> getCreditHistory(String query);
  Future<Either<Failure, TherapyRecommendationsResponse>>
      getTherapyRecommendation(String query);
  Future<Either<Failure, PaymentSuccessResponse>> paymentSuccess(
      String query, Map<String, dynamic> variables);
  Future<Either<Failure, TransactionExpiryStatusResponse>>
      getTransactionExpiryStatus(String sessionId);
  Future<Either<Failure, SessionCancelResponse>> cancelSession(
      String sessionId, String sessionType);
  Future<Either<Failure, CommonAuthResponse>> canRescheduleSession(
      String sessionId);
  Future<Either<Failure, TherapySessionResponse>> getTherapySessionById(
      String sessionId);
  Future<Either<Failure, CommonAuthMutationResponse>> rescheduleSession(
      String sessionId, String scheduleId);
  Future<Either<Failure, ResourceListResponse>> listResources();
  Future<Either<Failure, HomeworkSessionResponse>> getHomeworkSession(
      String date);
  Future<Either<Failure, HomeworkResponse>> getHomework(String sessionId);
  Future<Either<Failure, CommonAuthResponse>> getMeetLink(String sessionId,String type);
}
