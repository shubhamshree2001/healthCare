import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';

import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/models/therapyModel/doctor_list_response.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../enum/app_enum.dart';
import '../../../repository/therapyRepo/therapy_repo.dart';
import '../../../routes/app_pages.dart';


class BookSessionController extends GetxController
{

  final TherapyRepo therapyRepo;
  BookSessionController({required this.therapyRepo});

  var selectedIndex=0.obs;
  var doctorList = <DoctorItem>[].obs;
  var doctorLimit = 10;
  var doctorOffset=0;
  var doctorTotal=0.obs;
  var doctorListApiCallStatus = ApiCallStatus.holding.obs;
  ScrollController scrollController =ScrollController();
  @override
  void onInit() {
    doctorListPagination();
    getDoctorList(doctorLimit,doctorOffset);
    super.onInit();
  }
  Future<void> getDoctorList(int limit,int offset) async {
    try {
      if(offset==0)
        {
          doctorList.clear();
        }
      doctorListApiCallStatus.value=ApiCallStatus.loading;

      final either = await therapyRepo.getDoctorList(
          TherapyQueryMutation.getDoctorList(limit:doctorLimit,offset: offset));
      either.fold((l) {
        doctorListApiCallStatus.value=ApiCallStatus.error;
      }, (r) {
        if (r.auth?.doctorList != null && r.auth!.doctorList!.isNotEmpty) {
          doctorList.addAll(r.auth!.doctorList!);
          doctorTotal.value = r.doctorTotal!;
          doctorOffset = r.doctorOffset!+r.doctorLimit!;
        }
        doctorListApiCallStatus.value=ApiCallStatus.success;
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      doctorListApiCallStatus.value=ApiCallStatus.error;
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  String getDegrees(DoctorItem doctorItem)
  {
    String degree="";
    if(doctorItem.degrees!=null && doctorItem.degrees!.isNotEmpty)
    {
      for(int i=0;i<doctorItem.degrees!.length;i++)
      {
        if(i==0)
        {
          degree = "${doctorItem.degrees![i].name}";
        }
        else if(i<doctorItem.degrees!.length-1)
        {
          degree = "$degree,${doctorItem.degrees![i].name}";
        }
        else
        {
          degree = "$degree and ${doctorItem.degrees![i].name}";
        }
      }
    }

    return degree;
  }

  void doctorListPagination()
  {
     scrollController.addListener(() {
       if(scrollController.position.pixels==scrollController.position.maxScrollExtent)
         {
           print("Reached====");
           if(doctorTotal>doctorList.length)
             {
               getDoctorList(10,doctorOffset);
             }
         }
     });
  }

  void redirectToDoctorDetails(String slug)
  {
    Get.toNamed("${Routes.doctorDetails}?${StringsConstant.slugKey}=$slug");
  }

  void redirectToTherapyBookingScreen(DoctorItem doctorItem)
  {
    var sendParams=NavigationParamsModel(
        doctorItem: doctorItem,
        routes: Routes.bookSession
    );
    Get.toNamed(Routes.therapyBooking,arguments: sendParams);
  }
}