import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';
import '../../ui/authentication/settings/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController(
        settingRepo: Get.put(SettingRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
  }
}
