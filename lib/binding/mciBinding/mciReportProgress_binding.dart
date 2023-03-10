import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/mciRepo/mci_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciReportProgree/mciReportProgressController.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciBeginQuestion/mci_controller.dart';

class MciReportProgressBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MciReportProgressController(
        mciRepo: Get.put(MciRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}
