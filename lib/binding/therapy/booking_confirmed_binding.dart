import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/dashboard/dashboard_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/bookingConfirmed/booking_confirmed_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/doctorDetails/doctor_details_controller.dart';

import '../../repository/therapyRepo/therapy_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';

class BookingConfirmedBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(BookingConfirmedController(therapyRepo: Get.put(TherapyRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}