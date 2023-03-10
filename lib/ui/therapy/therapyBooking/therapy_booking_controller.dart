
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/doctor_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/request/therapy_session_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/schedule_list_response.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';

import '../../../data/models/authModel/country_code_list_response.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/models/therapyModel/request/create_order_request.dart';
import '../../../data/queryMutation/therapy_query_mutation.dart';
import '../../../repository/therapyRepo/therapy_repo.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class TherapyBookingController extends GetxController
{
  final TherapyRepo therapyRepo;
  TherapyBookingController({required this.therapyRepo});
  final guardianNameController=TextEditingController();
  final guardianEmailController=TextEditingController();
  final guardianPhoneController=TextEditingController();
  final descriptionController=TextEditingController();
  final GlobalKey<FormState>therapyBookingFormKey=GlobalKey<FormState>();
  var countryCodeList=<CountryCodeItem>[].obs;
  var selectedCountryCode=CountryCodeItem().obs;
  var modeList = <String>['Video', 'Phone', 'Chat'].obs;
  var defaultModeSelectedIndex=4.obs;
  var defaultSelectedTimeSlotIndex=4.obs;
  var availableTimeSlotSelectedIndex=4.obs;
  var dob="".obs;
  var doctorItem=DoctorItem().obs;
  var scheduleList=<Schedule>[].obs;
  var selectedSlotList=<Schedule>[].obs;
  var availableTimeSlotList=<Schedule>[].obs;
  var availableSelectedDate="".obs;
  var initialSelectedDate;
  var isAdult=false.obs;
  var userData=GetUser().obs;
  var isShowDobPicker=false.obs;
  var receivedParams=NavigationParamsModel().obs;
  var readOnly=false.obs;

  @override
  void onInit() {
    super.onInit();
    initEasyLoading();

    if(Get.arguments!=null)
      {
        receivedParams.value=Get.arguments;
        if(receivedParams.value.routes==Routes.bookSession || receivedParams.value.routes==Routes.doctorDetails)
          {
            doctorItem.value=receivedParams.value.doctorItem!;
            getSchedulesList();
            readOnly.value=false;
          }
        else if(receivedParams.value.routes==Routes.myBooking)
          {
            var sessionId=receivedParams.value.sessionId!;
            readOnly.value=true;
            getTherapySessionById(sessionId);
          }
      }


    userData.value=LocalStorage.getUserData();
    checkDobAvailable();

    CountryCodeListResponse countryCodeListResponse=LocalStorage.getCountryListData();
    if(countryCodeListResponse!=null && countryCodeListResponse.countryCodeList!=null && countryCodeListResponse.countryCodeList!.isNotEmpty)
      {
        countryCodeList.value=countryCodeListResponse.countryCodeList!;
        selectedCountryCode.value = countryCodeList[0];
      }
  }

  Future<void> getSchedulesList() async {
    try {

      final either = await therapyRepo.getSchedulesList(
          TherapyQueryMutation.getSchedulesList(doctorItem.value.user!.id!));
      either.fold((l) {
      }, (r) {
        if (r.auth?.scheduleList != null && r.auth!.scheduleList!.isNotEmpty) {
          scheduleList.value=r.auth!.scheduleList!;
          int year=int.parse(DateFormat("yyyy").format(DateTime.parse(scheduleList[0].startDate!)));
          int month=int.parse(DateFormat("MM").format(DateTime.parse(scheduleList[0].startDate!)));
          int day=int.parse(DateFormat("dd").format(DateTime.parse(scheduleList[0].startDate!)));
          setAvailableSlots(DateTime(year,month,day));
          initialSelectedDate= DateTime(year,month,day);
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getTherapySessionById(String sessionId) async {
    try {
      final either = await therapyRepo.getTherapySessionById(sessionId);
      either.fold((l) {
      }, (r) {
        if (r.auth?.therapySession?.session!= null) {
          updateUi(r.auth!.therapySession!.session!);
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  void updateUi(Session session)
  {
    doctorItem.value.user=User(id: session.doctor?.id,name: session.doctor?.name);
    descriptionController.text=session.issues!;

    if(session.mode!=null && session.mode!.isNotEmpty)
      {
        defaultModeSelectedIndex.value=modeList.indexOf(CommunicationModeEnumValue.getValue(session.mode));
      }
    if(session.parent!=null)
      {
        guardianNameController.text=session.parent!.name!;
        guardianEmailController.text=session.parent!.email!;

        if(session.parent!.phone!=null)
          {
            guardianPhoneController.text=session.parent!.phone!.mobile!;
            try {
              var selectedList = countryCodeList.where((item) => item.code == session.parent!.phone!.code!).toList();
              if(selectedList!=null && selectedList.isNotEmpty)
                {
                  selectedCountryCode.value=selectedList[0];
                }
            } catch (e) {
              log(e.toString());
            }
          }
      }
    getSchedulesList();
  }


  Future<void> createTherapySessionOrder(CreateOrderRequest request) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either = await therapyRepo.createTherapyOrder(
          TherapyQueryMutation.createOrder(request));
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r) {
        if(r.authMutation?.therapyGiftOrder?.orderId!=null && r.authMutation!.therapyGiftOrder!.orderId.isNotEmpty)
        {
          redirectToTherapySlotDetailsScreen(r.authMutation!.therapyGiftOrder!.orderId);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> rescheduleSession(String scheduleId) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either = await therapyRepo.rescheduleSession(receivedParams.value.sessionId!,scheduleId);
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r) {
        if(r.authMutation?.update?.rescheduleSession!=null && r.authMutation!.update!.rescheduleSession!)
        {
          var sendParams=NavigationParamsModel(
              routes: Routes.therapyBooking
          );
          Get.toNamed(Routes.bookingConfirmed,arguments: sendParams);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }


  Future<void> selectDob()
  async {
    DateTime? dateTime=await showDatePickerDialog(Get.context!);
    if(dateTime!=null)
      {
        dob.value=AppUtil.convertDateTimeToMMMDYDateFormat(dateTime);
        isAdult.value=AppUtil.isAdult(dob.value);
      }
  }

  void checkDobAvailable()
  {
    if(userData.value.dob!=null && userData.value.dob?.date!=null)
      {
        isShowDobPicker.value=false;
        dob.value=AppUtil.convertStringToDateFormat(userData.value.dob!.date,format: AppUtil.dateTimeMMMDY);
        isAdult.value=AppUtil.isAdult(dob.value);
      }
    else
      {
        isShowDobPicker.value=true;
      }
  }

  void setAvailableSlots(DateTime dateTime)
  {
    String selectedDate=AppUtil.convertDateTimeToMMMDYDateFormat(dateTime);
    availableSelectedDate.value=selectedDate;
    availableTimeSlotList.clear();
    for(int i=0;i<scheduleList.length;i++)
      {
        String date=AppUtil.getMMMDYDateFormat(scheduleList[i].startDate);
        if(selectedDate==date)
          {
            availableTimeSlotList.add(scheduleList[i]);
          }
      }
  }

  void filterSelectedAvailableSlot(int index)
  {
     Schedule schedule=availableTimeSlotList[index];
     for(int i=0;i<availableTimeSlotList.length;i++)
       {
         if(i==index)
           {
             schedule.isChecked = !schedule.isChecked;

             if(schedule.isChecked)
               {
                 selectedSlotList.add(schedule);
               }
             else
               {
                 selectedSlotList.remove(schedule);
               }
             break;
           }
       }
     availableTimeSlotList[index]=schedule;
  }

  void checkAvailableSlotValidation(int index)
  {
    if(availableTimeSlotList[index].isChecked)
    {
     filterSelectedAvailableSlot(index);
    }
    else {
      if (receivedParams.value.routes == Routes.bookSession) {
        if (selectedSlotList.length < 2) {
         filterSelectedAvailableSlot(index);
        }
        else {
          showSnackBar(
              "Error", "You can't select more than 2 slots", true);
        }
      }
      else
      if (receivedParams.value.routes == Routes.myBooking) {
        if (selectedSlotList.isEmpty) {
          filterSelectedAvailableSlot(index);
        }
        else {
          showSnackBar(
              "Error", "You can't select more than 1 slots", true);
        }
      }
    }
  }

  void deleteSelectedSlotItem(int index)
  {
    Schedule schedule=selectedSlotList[index];

    for(int i=0;i<availableTimeSlotList.length;i++)
      {
        if(schedule.id==availableTimeSlotList[i].id)
          {
            Schedule item=availableTimeSlotList[i];
            item.isChecked=false;
            availableTimeSlotList[i]=item;
          }
      }
    selectedSlotList.removeAt(index);
  }

  @override
  void onClose() {
    guardianNameController.dispose();
    guardianEmailController.dispose();
    guardianPhoneController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void checkTherapyBookingValidation() {
    hideSoftKeyboard(Get.context!);

    if (dob.isEmpty) {
      showSnackBar("Error", "Date of Birth is Required*", true);
    }
    else {
      final isValid = therapyBookingFormKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      else if (defaultModeSelectedIndex.value == 4) {
        showSnackBar("Error", "Mode of Therapy is Required*", true);
      }
      else if (selectedSlotList.isEmpty) {
        showSnackBar("Error", "Please Book Therapy slots*", true);
      }
      else {
        therapyBookingFormKey.currentState!.save();

        var scheduleList = <String>[];
        for (int i = 0; i < selectedSlotList.length; i++) {
          scheduleList.add("\"${selectedSlotList[i].id!}\"");
        }
        var request = CreateOrderRequest(
            dob: dob.value,
            schedulesList: scheduleList,
            doctorId: doctorItem.value.user!.id!,
            mode: CommunicationModeEnum.values[defaultModeSelectedIndex.value].name,
            issues: descriptionController.text,
            name: guardianNameController.text,
            email: guardianEmailController.text,
            code:  selectedCountryCode.value.code!,
            phone: guardianPhoneController.text,
            type: TherapyPlanEnum.SESSION.name,
            isAdult: isAdult.value,
        );

        if(receivedParams.value.routes==Routes.bookSession)
          {
            createTherapySessionOrder(request);
          }
        else if(receivedParams.value.routes==Routes.myBooking)
          {
            rescheduleSession(scheduleList[0]);
          }

      }
    }
  }

  void redirectToTherapySlotDetailsScreen(String orderId)
  {
    Get.toNamed(Routes.therapySlotDetails,arguments: [orderId,doctorItem,selectedSlotList]);
  }
}