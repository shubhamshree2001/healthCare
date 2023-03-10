import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/request/create_gift_therapy_order_request.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/therapy_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import 'package:mindpeers_mobile_flutter/repository/therapyRepo/therapy_repo.dart';

import '../../../data/models/authModel/country_code_list_response.dart';
import '../../../data/models/navigationParamsModel/navigation_params_model.dart';
import '../../../data/queryMutation/auth_query_mutation.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class GiftRecipientsDetailsController extends GetxController
{

  final TherapyRepo therapyRepo;
  GiftRecipientsDetailsController({required this.therapyRepo});

  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final confirmEmailController=TextEditingController();
  final phoneController=TextEditingController();
  final GlobalKey<FormState>giftRecipientFormKey=GlobalKey<FormState>();
  var countryCodeList=<CountryCodeItem>[].obs;
  var selectedCountryCode=CountryCodeItem().obs;
  var readOnly=false.obs;
  var planId="";

  @override
  void onReady() {
    planId=Get.parameters[StringsConstant.planIdKey]!;

    initEasyLoading();
    getCountryCodeList();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getCountryCodeList()
  async {
    try {
      final either=await therapyRepo.getCountryCodeList(AuthQueryMutation.getCountryCodeList(""));
      either.fold((l){
        readOnly.value=true;
        showSnackBar("Error", l.errorMessage, true);
      }, (r){
        if(r.countryCodeList!=null && r.countryCodeList!=null &&  r.countryCodeList!.isNotEmpty)
        {
          selectedCountryCode.value = r.countryCodeList![0];
          countryCodeList.value=r.countryCodeList!;
          readOnly.value=false;
        }

      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> createTherapyGiftOrder(CreateGiftTherapyOrderRequest request)
  async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either=await therapyRepo.createTherapyOrder(TherapyQueryMutation.createGiftTherapyOrder(request));
      either.fold((l){
        readOnly.value=true;
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r){
        if(r.authMutation?.therapyGiftOrder?.orderId!=null && r.authMutation!.therapyGiftOrder!.orderId.isNotEmpty)
        {
          getGiftTherapyOrder(r.authMutation!.therapyGiftOrder!.orderId);
        }
        EasyLoading.dismiss();
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> getGiftTherapyOrder(String orderId)
  async {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    try {
      final either=await therapyRepo.getGiftTherapyOrder(TherapyQueryMutation.getTherapyGiftOrder(orderId));
      either.fold((l){
        readOnly.value=true;
        showSnackBar("Error", l.errorMessage, true);
        EasyLoading.dismiss();
      }, (r){
        if(r.auth?.getOrder?.id!=null && r.auth!.getOrder!.id.isNotEmpty)
        {
          if(!(r.auth!.getOrder!.completed) && !(r.auth!.getOrder!.timedout))
            {
              var navigationParamsModel = NavigationParamsModel(
                  planId: planId,
                  orderId: r.auth!.getOrder!.id,
                  routes: Routes.giftRecipientDetails
              ) ;
              Get.toNamed(Routes.giftTherapyCheckout,arguments: navigationParamsModel);
            }
          else if(r.auth!.getOrder!.completed)
            {
              showSnackBar("Error", "Already Completed", true);
            }
          else if(r.auth!.getOrder!.timedout)
            {
              showSnackBar("Error", "Timeout Error", true);
            }
        }
        EasyLoading.dismiss();
      });
    } catch (e,stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    confirmEmailController.dispose();
    phoneController.dispose();
    EasyLoading.dismiss();
    super.onClose();
  }

  void checkTherapyRecipientValidation()
  {
    hideSoftKeyboard(Get.context!);
    final isValid=giftRecipientFormKey.currentState!.validate();
    if(!isValid)
    {
     return;
    }
    else
      {
        giftRecipientFormKey.currentState!.save();

       var request=CreateGiftTherapyOrderRequest(
           code: selectedCountryCode.value.code!,
           mobileNo: phoneController.text,
           email: emailController.text,
           name: nameController.text,
           type: TherapyPlanEnum.GIFT.name
       );
       createTherapyGiftOrder(request);
      }
  }
}