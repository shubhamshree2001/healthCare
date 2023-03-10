import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/auth_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/authRepo/auth_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';

import '../../../widgets/common_widget.dart';

class ResetPasswordController extends GetxController {
  final AuthRepo authRepo;

  ResetPasswordController({required this.authRepo});

  final nameController = TextEditingController();
  final corporateAccessCodeController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  var isPasswordMatch = false.obs;
  var isObscureText = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> settingResetPasswordFormKey =
      GlobalKey<FormState>();
  var corporateSwitch = false.obs;
  var isValidatePass = false.obs;
  var selectedCountryCode = CountryCodeItem().obs;
  var countryCodeList = <CountryCodeItem>[].obs;
  var isChanged = false.obs;

  @override
  void onInit() {
    initEasyLoading();
    getCountryCodeList();
    super.onInit();
  }

  Future<void> getCountryCodeList() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo
          .getCountryCodeList(AuthQueryMutation.getCountryCodeList(""));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.countryCodeList != null &&
            r.countryCodeList != null &&
            r.countryCodeList!.isNotEmpty) {
          selectedCountryCode.value = r.countryCodeList![0];
          countryCodeList.value = r.countryCodeList!;
        }

        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void checkLoginValidation() {
    hideSoftKeyboard(Get.context!);
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
    //authRepo.userSignup(AuthQueryMutation.userSignup("email"));
  }

  void matchPassword() {
    if (newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        (newPasswordController.text == confirmPasswordController.text)) {
      isPasswordMatch.value = true;
    } else {
      isPasswordMatch.value = false;
    }
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
