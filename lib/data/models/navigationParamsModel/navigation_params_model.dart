import 'package:mindpeers_mobile_flutter/data/models/mciModel/listMciQuestion.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/mvciResultResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/doctor_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/schedule_list_response.dart';

import '../clubModels/community_info_response.dart';

class NavigationParamsModel {
  String? mobileNo;
  String? email;
  String? name;
  String? orderId;
  String? planId;
  List<Schedule>? selectedSlotList;
  DoctorItem? doctorItem;
  int? credit = 0;
  String? razorPayResponse;
  String? gateway;
  String? routes;
  String? sessionId;
  String? sessionTime;
  List<Question>? mciQuestionList;
  List<Report>? mciReportList;
  bool? isMciReportReady;
  List<ResourceItem>? resourceList;
  String? ventId;
  String? communityId;
  String? slug;
  bool? isAccessWithOrg;

  NavigationParamsModel({
    this.mobileNo,
    this.email,
    this.name,
    this.orderId,
    this.planId,
    this.selectedSlotList,
    this.doctorItem,
    this.credit,
    this.razorPayResponse,
    this.gateway,
    this.routes,
    this.sessionId,
    this.sessionTime,
    this.mciQuestionList,
    this.mciReportList,
    this.isMciReportReady,
    this.resourceList,
    this.ventId,
    this.communityId,
    this.slug,
    this.isAccessWithOrg,
  });
}
