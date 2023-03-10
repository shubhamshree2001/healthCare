import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapySlotDetails/therapy_slot_controller.dart';

import '../../repository/therapyRepo/therapy_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';

class TherapySlotDetailsBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(TherapySlotDetailsController(therapyRepo: Get.put(TherapyRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}