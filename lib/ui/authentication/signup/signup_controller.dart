import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/request/signup_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/auth_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/authRepo/auth_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';

import '../../../data/localStorage/local_storage.dart';
import '../../../widgets/common_widget.dart';

class SignupController extends GetxController {
  final AuthRepo authRepo;

  SignupController({required this.authRepo});

  final nameController = TextEditingController();
  final corporateAccessCodeController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  var isObscureText = false.obs;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  var corporateSwitch = false.obs;
  var isValidatePass = false.obs;
  var selectedCountryCode = CountryCodeItem().obs;
  var countryCodeList = <CountryCodeItem>[].obs;
  var email = "".obs;
  var isShowCorporateSwitch = true.obs;
  var termAndConditionCheckBox = false.obs;
  var readOnly = false.obs;
  FocusNode focusNode = FocusNode();
  var receiveParams = NavigationParamsModel().obs;

  final emailController = TextEditingController();

  @override
  void onInit() {
    receiveParams.value = Get.arguments;
    // var userType = Get.parameters[StringsConstant.userTypeKey]!;
    // email.value = Get.parameters[StringsConstant.emailKey]!;

    // if (userType == StringsConstant.anyUser) {
    //   isShowCorporateSwitch.value = true;
    // } else {
    //   corporateSwitch.value = true;
    //   isShowCorporateSwitch.value = false;
    // }

    // focusNode.addListener(() {
    //   print('1:  ${focusNode.hasFocus}');
    //   if (!focusNode.hasFocus) {
    //     getCountryCodeList(corporateAccessCodeController.text);
    //   }
    // });
    // if (!corporateSwitch.value) {
    //   getCountryCodeList("");
    // }
    initEasyLoading();
    getCountryCodeList("");
    super.onInit();
  }

  Future<void> getCountryCodeList(String accessCode) async {
    try {
      final either = await authRepo
          .getCountryCodeList(AuthQueryMutation.getCountryCodeList(accessCode));
      either.fold((l) {
        readOnly.value = true;
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.countryCodeList != null &&
            r.countryCodeList != null &&
            r.countryCodeList!.isNotEmpty) {
          selectedCountryCode.value = r.countryCodeList![0];
          countryCodeList.value = r.countryCodeList!;
          readOnly.value = false;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> signUpApiCall(String query) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo.userSignup(query);
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.signup != null) {
          if (r.signup!.verifyToken != null &&
              r.signup!.verifyToken!.isNotEmpty) {
            Get.toNamed(Routes.otp,
                arguments: [email.value, r.signup!.verifyToken]);
          } else {
            LocalStorage.setAccessToken(r.signup!.accessToken!);
            LocalStorage.setRefreshToken(r.signup!.refreshToken!);
            LocalStorage.setIsLogin(true);
            Get.offAllNamed(Routes.dashboard);
          }
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> getOrganization(SignupRequest signupRequest) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo.getOrganization(
          AuthQueryMutation.getOrganization(
              corporateAccessCodeController.text));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.organisation != null) {
          signupRequest.org = r.organisation!.id;
          signUpApiCall(AuthQueryMutation.userSignupCorporate(signupRequest));
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void corporateSwitchOnChange(bool value) {
    if (value) {
      readOnly.value = true;
    } else {
      readOnly.value = false;
      getCountryCodeList("");
    }
  }

  void checkSignupValidation() {
    hideSoftKeyboard(Get.context!);
    final isValid = signupFormKey.currentState!.validate();
    if (!isValid) {
      return;
      // } else if (!termAndConditionCheckBox.value) {
      //   showSnackBar("Error", "Please agree to the terms & conditions", true);
    } else {
      Get.toNamed(Routes.privacyPolicyScreen); //added by shubham
      signupFormKey.currentState!.save();

      var signupRequest = SignupRequest(
          code: selectedCountryCode.value.code!,
          mobileNo: mobileController.text.toString(),
          email: email.value,
          name: nameController.text.toString(),
          password: passwordController.text.toString(),
          org: "");

      if (corporateSwitch.value) {
        getOrganization(signupRequest);
      } else {
        signUpApiCall(AuthQueryMutation.userSignup(signupRequest));
      }
    }
  }

  void redirectToWebView(String url) {
    Get.toNamed('${Routes.webView}?${StringsConstant.urlKey}=$url');
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    nameController.dispose();
    corporateAccessCodeController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    super.onClose();
  }
}
