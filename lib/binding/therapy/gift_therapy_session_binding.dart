import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/giftTherapySessions/gift_therapy_session_controller.dart';
import '../../repository/therapyRepo/therapy_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';

class GiftTherapySessionBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(GiftTherapySessionController(therapyRepo: Get.put(TherapyRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}