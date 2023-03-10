import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/bookSessions/book_session_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/mybooking/my_booking_controller.dart';

import '../../data/models/therapyModel/doctor_list_response.dart';
import '../../data/queryMutation/therapy_query_mutation.dart';
import '../../repository/therapyRepo/therapy_repo.dart';

class TherapyController extends GetxController with GetSingleTickerProviderStateMixin,StateMixin<List<DoctorItem>>
{

  final TherapyRepo therapyRepo;
  TherapyController({required this.therapyRepo});

  late TabController tabController;
  var selectedIndex=0.obs;
  var doctorList = <DoctorItem>[].obs;
  var doctorLimit = 10;
  var doctorOffset=0;
  ScrollController scrollController =ScrollController();
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    getDoctorList(doctorLimit,doctorOffset);
    super.onInit();
  }

  Future<void> getDoctorList(int limit,int offset) async {
    try {
      change(null,status: RxStatus.loading());
      final either = await therapyRepo.getDoctorList(
          TherapyQueryMutation.getDoctorList(limit: limit,offset: offset));
      either.fold((l) {
        change(null,status: RxStatus.error(l.errorMessage));
       // showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth?.doctorList != null && r.auth!.doctorList!.isNotEmpty) {
          offset= offset+limit;
          doctorList.clear();
          doctorList.addAll(r.auth!.doctorList!);
          change(doctorList,status: RxStatus.success());
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      change(null,status: RxStatus.error());
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

  void onTabListeners(int index)
  {
     if(index==0)
       {
         Get.find<MyBookingController>().getUpcomingTherapySessionList();
       }
     else if(index==1)
       {
         if( Get.find<BookSessionController>()!=null)
           {
             Get.find<BookSessionController>().getDoctorList(10,0);
             Get.find<BookSessionController>().doctorListPagination();
           }
       }
  }
}