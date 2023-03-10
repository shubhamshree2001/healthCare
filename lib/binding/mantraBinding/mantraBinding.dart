import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/mantraToolRepo/mantra_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/mantraTool/mantraController.dart';

class MantraBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MantraController(
        mantraRepo: Get.put(MantraRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}
