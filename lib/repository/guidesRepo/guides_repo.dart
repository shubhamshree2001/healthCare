import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/getModuleLstSessionResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/getModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleFIlterResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/request/submitModuleStatisticsResponse.dart';
import 'package:mindpeers_mobile_flutter/exception/failure.dart';

abstract class GuidesRepo {
  Future<Either<Failure, ListModuleFilterResponse>> getListModulesFilters(
      String query);
  Future<Either<Failure, ListModuleResponse>> getListModules(String query);
  Future<Either<Failure, GetModuleLastSessionResponse>> getModulesLastSession(
      String query);
  Future<Either<Failure, GetModuleResponse>> getModules(String query);
  Future<Either<Failure, SubmitModuleStatisticsResponse>>
      submitModuleStatistics(String query);
  Future<Either<Failure, SubmitModuleStatisticsResponse>> submitModuleFeedback(
      String query);
  Future<Either<Failure, SubmitModuleStatisticsResponse>> submitModuleResponse(
      String query);
}
