import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/dashboardRepo/dashboard_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/ui/dashboard/dashboard_controller.dart';

import '../../service/graph_ql_configuration.dart';

class DashboardBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(DashboardController(dashBoardRepo: Get.put(DashboardRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}