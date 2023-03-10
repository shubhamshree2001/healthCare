import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_info_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/resource_list_response.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';

import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../repository/clubRepo/club_repo.dart';

class WorksheetController extends GetxController
{
  final ClubRepo clubRepo;
  WorksheetController({required this.clubRepo});


  var resourceList = <ResourceItem>[].obs;

  @override
  void onInit() {
    super.onInit();

    if(Get.arguments!=null) {
      NavigationParamsModel receivedParams = Get.arguments;
      if(receivedParams.routes ==Routes.vents)
        {
           resourceList.value = receivedParams.resourceList!;
        }
    }
  }
}