import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/exception/failure.dart';
import 'package:mindpeers_mobile_flutter/repository/dashboardRepo/dashboard_repo.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import '../../data/models/authModel/country_code_list_response.dart';
import '../../data/models/authModel/user_response.dart';
import '../../data/models/clubModels/community_config_response.dart';


class DashboardRepoImpl extends DashBoardRepo
{
  final GraphQLConfiguration graphQLConfiguration;
  DashboardRepoImpl({required this.graphQLConfiguration});


  @override
  Future<Either<Failure, CountryCodeListResponse>> getCountryCodeList(String query) async {
    var response=await graphQLConfiguration.callQuery(query);
    return response.fold((l){
      return left(l);
    }, (r){
      return right(CountryCodeListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, UserResponse>> getUser(String query) async {
    var response=await graphQLConfiguration.callQuery(query);
    return response.fold((l){
      return left(l);
    }, (r){
      return right(UserResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommunityConfigResponse>> getCommunityConfig(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommunityConfigResponse.fromJson(r));
    });
  }

}

