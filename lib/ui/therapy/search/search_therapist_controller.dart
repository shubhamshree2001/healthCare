import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/doctor_list_response.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../widgets/common_widget.dart';

class SearchTherapistsController extends GetxController {
  final TherapyRepo therapyRepo;
  SearchTherapistsController({required this.therapyRepo});

  final searchController = TextEditingController();
  var doctorList = <DoctorItem>[].obs;
  var filterText = "".obs;
  var searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    initEasyLoading();
    debounce(filterText, (callback) => getDoctorList(),
        time: const Duration(milliseconds: 300));
  }

  Future<void> getDoctorList() async {
    try {
      // EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await therapyRepo.getDoctorList(
          TherapyQueryMutation.getDoctorList(filter: filterText.value));
      either.fold((l) {
        // EasyLoading.dismiss();
      }, (r) {
        if (r.auth?.doctorList != null && r.auth!.doctorList!.isNotEmpty) {
          doctorList.clear();
          doctorList.addAll(r.auth!.doctorList!);
        } else {
          doctorList.clear();
        }
        // EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      //EasyLoading.dismiss();
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
}
