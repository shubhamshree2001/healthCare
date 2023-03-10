import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/sendResetLink/send_reset_link_controller.dart';

import '../../repository/authRepo/auth_repo_impl.dart';

class SendResetLinkBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(SendResetLinkController(authRepo: Get.put(AuthRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}