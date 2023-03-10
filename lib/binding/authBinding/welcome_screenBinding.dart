import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/login/login_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/welcomeScreen/welcomeScreenController.dart';

import '../../repository/authRepo/auth_repo_impl.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WelcomeScreenController(
        authRepo: Get.put(AuthRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}
