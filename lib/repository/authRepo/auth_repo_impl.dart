import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/account_list_response.dart';
import 'package:mindpeers_mobile_flutter/exception/failure.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import '../../data/models/authModel/country_code_list_response.dart';
import '../../data/models/authModel/login_response.dart';
import '../../data/models/authModel/organization_response.dart';
import '../../data/models/authModel/otp_verify_response.dart';
import '../../data/models/authModel/signup_response.dart';
import 'auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final GraphQLConfiguration graphQLConfiguration;
  AuthRepoImpl({required this.graphQLConfiguration});

  @override
  Future<Either<Failure, AccountListResponse>> getAllAccountList(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(AccountListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, SignupResponse>> userSignup(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(SignupResponse.fromJson(r));
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
  Future<Either<Failure, LoginResponse>> userLogin(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(LoginResponse.fromJson(r));
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
  Future<Either<Failure, OtpVerifyResponse>> verifyOtp(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(OtpVerifyResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, OrganizationResponse>> getOrganization(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(OrganizationResponse.fromJson(r));
    });
  }

}
