import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/doctor_list_response.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';

import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../enum/app_enum.dart';
import '../../../repository/therapyRepo/therapy_repo.dart';
import '../../../routes/app_pages.dart';

class DoctorDetailsController extends GetxController
    with StateMixin<DoctorItem> {
  final TherapyRepo therapyRepo;
  DoctorDetailsController({required this.therapyRepo});
  var doctorItem = DoctorItem().obs;
  var limit = 3.obs;
  var reviewList = <String>[].obs;
  var reviewListApiCallStatus = ApiCallStatus.holding.obs;
  var reviewTotal = 0.obs;
  var reviewOffset = 0.obs;
  var reviewLimit = 3;

  @override
  void onInit() {
    var slug = Get.parameters[StringsConstant.slugKey]!;
    getDoctorDetails(slug);
    super.onInit();
  }

  Future<void> getDoctorDetails(String slug) async {
    try {
      change(null, status: RxStatus.loading());
      final either = await therapyRepo
          .getDoctorDetails(TherapyQueryMutation.getDoctorDetails(slug));
      either.fold((l) {
        change(null, status: RxStatus.error(l.errorMessage));
      }, (r) {
        if (r.auth?.doctorItem != null) {
          doctorItem.value = r.auth!.doctorItem!;
          change(doctorItem.value, status: RxStatus.success());
          getTherapyReviews(doctorItem.value.user!.id!, slug, reviewLimit,
              reviewOffset.value);
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      change(null, status: RxStatus.error());
    }
  }

  Future<void> getTherapyReviews(
      String doctorId, String slug, int reviewLimit, int offset) async {
    try {
      if (offset == 0) {
        reviewListApiCallStatus.value = ApiCallStatus.loading;
        reviewList.clear();
      }
      final either = await therapyRepo.getTherapyReviews(
          TherapyQueryMutation.getTherapyReviews(
              doctorId, slug, reviewLimit, offset));
      either.fold((l) {
        reviewListApiCallStatus.value = ApiCallStatus.error;
      }, (r) {
        if (r.auth?.reviewList != null && r.auth!.reviewList!.isNotEmpty) {
          reviewOffset.value = r.reviewOffset! + r.reviewLimit!;
          reviewTotal.value = r.reviewTotal!;
          reviewList.addAll(r.auth!.reviewList!);
          reviewListApiCallStatus.value = ApiCallStatus.success;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      reviewListApiCallStatus.value = ApiCallStatus.error;
    }
  }

  String getDegrees(DoctorItem doctorItem) {
    String degree = "";
    if (doctorItem.degrees != null && doctorItem.degrees!.isNotEmpty) {
      for (int i = 0; i < doctorItem.degrees!.length; i++) {
        if (i == 0) {
          degree = "${doctorItem.degrees![i].name}";
        } else if (i < doctorItem.degrees!.length - 1) {
          degree = "$degree,${doctorItem.degrees![i].name}";
        } else {
          degree = "$degree and ${doctorItem.degrees![i].name}";
        }
      }
    }

    return degree;
  }

  void redirectToTherapyBookingScreen() {
    var sendParams = NavigationParamsModel(
        doctorItem: doctorItem.value, routes: Routes.doctorDetails);
    Get.toNamed(Routes.therapyBooking, arguments: sendParams);
  }

  void shareData() {
    shareSocial(
        context: Get.context!,
        title: doctorItem.value.share!.title!,
        description: "${doctorItem.value.share!.text}",
        url: doctorItem.value.share!.url!);
  }
}
