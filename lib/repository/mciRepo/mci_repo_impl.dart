import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/commonMciResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/listMciQuestion.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/mciCOnfigResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/mvciResultResponse.dart';
import 'package:mindpeers_mobile_flutter/exception/failure.dart';
import 'package:mindpeers_mobile_flutter/repository/mciRepo/mci_repo.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';

class MciRepoImpl extends MciRepo {
  final GraphQLConfiguration graphQLConfiguration;
  MciRepoImpl({required this.graphQLConfiguration});

  @override
  Future<Either<Failure, GetMciConfigResponse>> getMciConfig(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(GetMciConfigResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, GetListOfMciQuestionResponse>> getlistMciQuestions(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(GetListOfMciQuestionResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, SubmitMciResponse>> submitMci(
      String query, Map<String, dynamic> variable) async {
    var response =
        await graphQLConfiguration.callMutation(query, variables: variable);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(SubmitMciResponse.fromJson(r));
      },
    );
  }

  @override
  Future<Either<Failure, GetMciResultResponse>> getMciResult(
      String query) async {
    var response = await graphQLConfiguration.callMutation(query);
    return response.fold(
      (l) {
        return left(l);
      },
      (r) {
        return right(GetMciResultResponse.fromJson(r));
      },
    );
  }
}
