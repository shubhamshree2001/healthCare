import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/club/more_clubs/more_club_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/newPost/new_post_controller.dart';

import '../../repository/clubRepo/club_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';
import '../../ui/club/myVents/my_vents_controller.dart';

class MyVentsBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(MyVentController(clubRepo: Get.put(ClubRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}