import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import '../../data/models/authModel/country_code_list_response.dart';
import '../../data/models/clubModels/community_config_response.dart';
import '../../exception/failure.dart';

abstract class DashBoardRepo {
  Future<Either<Failure,CountryCodeListResponse>> getCountryCodeList(String query);
  Future<Either<Failure,UserResponse>> getUser(String query);
  Future<Either<Failure, CommunityConfigResponse>> getCommunityConfig(String query);

}