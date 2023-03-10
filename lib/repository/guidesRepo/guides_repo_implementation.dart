import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/getModuleLstSessionResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/getModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleFIlterResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/request/submitModuleStatisticsResponse.dart';
import 'package:mindpeers_mobile_flutter/exception/failure.dart';
import 'package:mindpeers_mobile_flutter/repository/guidesRepo/guides_repo.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';

class GuidesRepoImpl extends GuidesRepo {
  final GraphQLConfiguration graphQLConfiguration;
  GuidesRepoImpl({required this.graphQLConfiguration});

  @override
  Future<Either<Failure, ListModuleFilterResponse>> getListModulesFilters(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(ListModuleFilterResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, ListModuleResponse>> getListModules(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(ListModuleResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, GetModuleLastSessionResponse>> getModulesLastSession(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(GetModuleLastSessionResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, GetModuleResponse>> getModules(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(GetModuleResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, SubmitModuleStatisticsResponse>>
      submitModuleStatistics(String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(SubmitModuleStatisticsResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, SubmitModuleStatisticsResponse>> submitModuleResponse(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(SubmitModuleStatisticsResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, SubmitModuleStatisticsResponse>> submitModuleFeedback(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(SubmitModuleStatisticsResponse.fromJson(r));
      },
    );
  }
}
