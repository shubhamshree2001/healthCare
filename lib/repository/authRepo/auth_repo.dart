import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/account_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/login_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/organization_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/otp_verify_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/signup_response.dart';

import '../../data/models/authModel/country_code_list_response.dart';
import '../../exception/failure.dart';

abstract class AuthRepo
{
  Future<Either<Failure,AccountListResponse>> getAllAccountList(String query);
  Future<Either<Failure,SignupResponse>> userSignup(String query);
  Future<Either<Failure,LoginResponse>> userLogin(String query);
  Future<Either<Failure,CountryCodeListResponse>> getCountryCodeList(String query);
  Future<Either<Failure,LoginResponse>> sendLinkForgotPass(String query);
  Future<Either<Failure,OtpVerifyResponse>> verifyOtp(String query);
  Future<Either<Failure,OrganizationResponse>> getOrganization(String query);

}