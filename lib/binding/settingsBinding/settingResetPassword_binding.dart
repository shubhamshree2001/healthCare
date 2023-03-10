import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/setingResetPassword/settingResetPassword_controller.dart';

class SettingResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingResetPasswordController(
        settingRepo: Get.put(SettingRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}
