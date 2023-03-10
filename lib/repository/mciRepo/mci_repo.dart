import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/commonMciResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/listMciQuestion.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/mciCOnfigResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/mvciResultResponse.dart';
import 'package:mindpeers_mobile_flutter/exception/failure.dart';

abstract class MciRepo {
  Future<Either<Failure, GetMciConfigResponse>> getMciConfig(String query);
  Future<Either<Failure, GetListOfMciQuestionResponse>> getlistMciQuestions(
      String query);
  Future<Either<Failure, SubmitMciResponse>> submitMci(
      String query, Map<String, dynamic> variable);
  Future<Either<Failure, GetMciResultResponse>> getMciResult(String query);
}
