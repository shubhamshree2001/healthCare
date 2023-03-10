import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapyBooking/therapy_booking_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapyPaymentSummary/therapy_payment_summary_controller.dart';

import '../../repository/therapyRepo/therapy_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';

class TherapyPaymentSummaryBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(TherapyPaymentSummaryController(therapyRepo: Get.put(TherapyRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}