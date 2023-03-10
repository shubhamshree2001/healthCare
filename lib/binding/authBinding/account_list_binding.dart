import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/accountList/account_list_controller.dart';

import '../../repository/authRepo/auth_repo_impl.dart';

class AccountListBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(AccountListController(authRepo: Get.put(AuthRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}