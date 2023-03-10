import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/guidesRepo/guides_repo_implementation.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideBreathing/guideBreathingController.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guides_controller.dart';

class GuidesBreathingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GuidesBreathingController(
        guidesRepo: Get.put(GuidesRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}
