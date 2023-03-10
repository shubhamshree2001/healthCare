import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/mypalns_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/settingScreen/setting_controller.dart';

class MyPlansBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyPlansController(
        settingRepo: Get.put(SettingRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}
