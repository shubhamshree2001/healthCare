import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/login/login_controller.dart';

import '../../repository/authRepo/auth_repo_impl.dart';
import '../../ui/authentication/signup/signup_controller.dart';

class SignupBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(SignupController(authRepo: Get.put(AuthRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}