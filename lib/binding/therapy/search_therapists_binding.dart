import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo_impl.dart';

import '../../service/graph_ql_configuration.dart';
import '../../ui/therapy/search/search_therapist_controller.dart';

class SearchTherapistsBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(SearchTherapistsController(therapyRepo: Get.put(TherapyRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}