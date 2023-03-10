import 'package:dartz/dartz.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/boat_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_info_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/event_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/event_notify_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/post_vent_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/vent_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/vent_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_auth_mutation_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/commonResponse/common_auth_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/create_therapy_order.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/exception/failure.dart';
import 'package:mindpeers_mobile_flutter/repository/clubRepo/club_repo.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import '../../data/models/clubModels/community_config_response.dart';
import '../../data/models/clubModels/community_list_response.dart';
import '../../data/models/clubModels/vents_replies_list_response.dart';
import '../../data/models/commonResponse/auth_mutation_create_response.dart';
import '../../data/models/settingModel/responseSetting/updateUser_response.dart';
import '../../data/models/therapyModel/get_gift_therapy_order_response.dart';
import '../../data/queryMutation/therapy_query_mutation.dart';


class ClubRepoImpl extends ClubRepo {
  final GraphQLConfiguration graphQLConfiguration;

  ClubRepoImpl({required this.graphQLConfiguration});

  @override
  Future<Either<Failure, CommunityConfigResponse>> getCommunityConfig(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommunityConfigResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommunityListResponse>> getCommunityList(String query,Map<String,dynamic> variable) async {
    var response = await graphQLConfiguration.callMutation(query,variables: variable);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommunityListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, VentListResponse>> getVentList(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(VentListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommonAuthMutationResponse>> updateFollowStatus(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommonAuthMutationResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommonAuthMutationResponse>> updateVent(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommonAuthMutationResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommunityInfoResponse>> getCommunityInfo(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommunityInfoResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, VentRepliesListResponse>> getVentRepliesList(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(VentRepliesListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommonAuthResponse>> checkVentStatus(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommonAuthResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, VentResponse>> getVent(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(VentResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, PostVentResponse>> postVent(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(PostVentResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, EventListResponse>> getEventList(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
    return left(l);
    }, (r) {
    return right(EventListResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommonAuthResponse>> getBoatAvailability(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommonAuthResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, BoatResponse>> getBoat(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(BoatResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, EventNotifyResponse>> notifyEvent(String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(EventNotifyResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommonAuthResponse>> getMeetLink(String sessionId, String type) async {
    var response = await graphQLConfiguration
        .callQuery(TherapyQueryMutation.getMeetLink(sessionId,type));
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommonAuthResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, TherapyGiftPlanResponse>> getPlanList(String query) async {
    var response = await graphQLConfiguration
        .callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(TherapyGiftPlanResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CommonAuthMutationResponse>> subscribe(String query) async {
    var response = await graphQLConfiguration
        .callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CommonAuthMutationResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, AuthMutationCreateResponse>> submitUserFeedback(
      String query,Map<String,dynamic> variable) async {
    var response = await graphQLConfiguration.callMutation(query,variables: variable);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(AuthMutationCreateResponse.fromJson(r));
    });
  }

  @override
  Future<Either<Failure, CreateTherapyOrderResponse>> createOrder(String query) async {
    var response = await graphQLConfiguration
        .callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(CreateTherapyOrderResponse.fromJson(r));
    });
  }


  @override
  Future<Either<Failure, GetTherapyGiftOrderResponse>> getTherapyOrder(
      String query) async {
    var response = await graphQLConfiguration.callQuery(query);
    return response.fold((l) {
      return left(l);
    }, (r) {
      return right(GetTherapyGiftOrderResponse.fromJson(r));
    });
  }

}
