import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/settingScreen/setting_controller.dart';
import '../../service/graph_ql_configuration.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingController(
        settingRepo: Get.put(SettingRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}
