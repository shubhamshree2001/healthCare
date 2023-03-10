import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../data/models/errorResponse/error_response.dart';

abstract class Failure implements Exception {
  final String serverCode;
  final String errorMessage;
  Failure(this.serverCode, this.errorMessage);
}

// server failure class
class ServerFailure extends Failure {
  ServerFailure(serverCode, errorMessage) : super(serverCode, errorMessage);
}

class NetworkFailure extends Failure {
  NetworkFailure(serverCode, errorMessage) : super(serverCode, errorMessage);
}

class NoDataFoundFailure extends Failure {
  NoDataFoundFailure(serverCode, errorMessage)
      : super(serverCode, errorMessage);
}

class UnAuthorized extends Failure {
  UnAuthorized(serverCode, errorMessage) : super(serverCode, errorMessage);
}

// cache failure
class CacheFailure extends Failure {
  CacheFailure(serverCode, String errorMessage)
      : super(serverCode, errorMessage);
}

Either<Failure, T> handleApiErrors<T>(Exception? exception,
    ErrorResponse? errorResponse, String baseUrl, String query) {
  if (errorResponse?.errors != null && errorResponse!.errors!.isNotEmpty) {
    logFailedPrint(baseUrl, query, errorResponse.errors![0].code,
        errorResponse.errors![0].message);
    return Left(ServerFailure(
        errorResponse.errors![0].code, errorResponse.errors![0].message));
  } else {
    logFailedPrint(baseUrl, query, "OTHER", "Something went wrong!!");
    return Left(ServerFailure("OTHER", "Something went wrong!!"));
  }
}

Either<Failure, T> handleApiErrors2<T>(
    Exception e, String baseUrl, String query) {
  var exception = e as OperationException;

  if (exception.linkException is NetworkException) {
    var networkException = exception.linkException as NetworkException;
    return Left(NetworkFailure("NETWORK_FAILED", networkException.message));
  } else if (exception.graphqlErrors != null &&
      exception.graphqlErrors.isNotEmpty) {
    logFailedPrint(
        baseUrl,
        query,
        exception.graphqlErrors[0].extensions!["code"],
        exception.graphqlErrors[0].message);
    return Left(ServerFailure(exception.graphqlErrors[0].extensions!["code"],
        exception.graphqlErrors[0].message));
  } else {
    logFailedPrint(baseUrl, query, "", exception.toString());
    return Left(ServerFailure("OTHER", "Something went wrong!!"));
  }
}

void logFailedPrint(String baseUrl, String query, String code, String message) {
  log("BaseUrl: $baseUrl");
  log("Request Data: $query");
  log("Code: $code");
  log("Message: $message");
}
