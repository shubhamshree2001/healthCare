import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/club/eventDetails/events_details_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/expandPost/expand_post_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/more_clubs/more_club_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/newPost/new_post_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/plan/plan_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/worksheets/worksheet_controller.dart';

import '../../repository/clubRepo/club_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';
import '../../ui/club/myVents/my_vents_controller.dart';

class PlanBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(PlansController(clubRepo: Get.put(ClubRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}