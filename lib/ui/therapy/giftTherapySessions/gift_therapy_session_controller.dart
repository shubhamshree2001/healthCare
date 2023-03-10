import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../repository/therapyRepo/therapy_repo.dart';
import '../../../routes/app_pages.dart';

class GiftTherapySessionController extends GetxController
    with StateMixin<List<TherapyGiftPlan>> {
  final TherapyRepo therapyRepo;
  GiftTherapySessionController({required this.therapyRepo});

  var therapyGiftPlanList = <TherapyGiftPlan>[].obs;
  var selectedPlanIndex = 0.obs;
  @override
  void onInit() {
    getTherapyGiftPlanByType();
    super.onInit();
  }

  Future<void> getTherapyGiftPlanByType() async {
    try {
      change(null, status: RxStatus.loading());
      final either = await therapyRepo.getTherapyGiftPlans(
          TherapyQueryMutation.getPlanListByType(
              LocalStorage.getAccessToken(), TherapyPlanEnum.GIFT.name));
      either.fold((l) {
        change(null, status: RxStatus.error(l.errorMessage));
      }, (r) {
        if (r.auth?.therapyGiftPlanList != null &&
            r.auth!.therapyGiftPlanList!.isNotEmpty) {
          therapyGiftPlanList.value = r.auth!.therapyGiftPlanList!;
          change(therapyGiftPlanList.value, status: RxStatus.success());
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      change(null, status: RxStatus.error());
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  void redirectToTherapyRecipientScreen() {
    Get.toNamed(
        "${Routes.giftRecipientDetails}?${StringsConstant.planIdKey}=${therapyGiftPlanList[selectedPlanIndex.value].id}");
  }
}
