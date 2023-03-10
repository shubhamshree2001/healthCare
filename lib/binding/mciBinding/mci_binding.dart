import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/mciRepo/mci_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciBeginQuestion/mci_controller.dart';

class MciBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MciController(
        mciRepo: Get.put(MciRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}
