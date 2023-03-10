import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/club/more_clubs/more_club_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/newPost/new_post_controller.dart';

import '../../repository/clubRepo/club_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';

class MoreClubBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(MoreClubController(clubRepo: Get.put(ClubRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}