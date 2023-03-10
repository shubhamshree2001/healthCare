import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/otpScreen/otp_controller.dart';

import '../../repository/authRepo/auth_repo_impl.dart';

class OtpBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(OtpController(authRepo: Get.put(AuthRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}