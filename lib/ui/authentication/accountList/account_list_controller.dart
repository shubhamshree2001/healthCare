import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/account_list_response.dart';
import 'package:mindpeers_mobile_flutter/repository/authRepo/auth_repo.dart';

import '../../../data/queryMutation/auth_query_mutation.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common_widget.dart';

class AccountListController extends GetxController {
  final AuthRepo authRepo;

  AccountListController({required this.authRepo});

  final passwordController = TextEditingController();
  var isObscureText = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  var accountList = <AccountItem>[].obs;
  var isIndividualAccount = false;
  var email = "".obs;
  var isShowPasswordError = false.obs;

  @override
  void onInit() {
    initEasyLoading();
    AccountListResponse accountListResponse = Get.arguments;
    email.value = Get.parameters[StringsConstant.emailKey]!;
    accountList.value = accountListResponse.accountList!;
    checkIndividualContainedOrNot();
    super.onInit();
  }

  Future<void> loginApiCall(String email) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo.userLogin(
          AuthQueryMutation.userLogin(email, passwordController.text));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.login != null) {
          if (r.login!.verifyToken != null &&
              r.login!.verifyToken!.isNotEmpty) {
            Get.toNamed(Routes.otp, arguments: [email, r.login!.verifyToken]);
          } else {
            LocalStorage.setAccessToken(r.login!.accessToken!);
            LocalStorage.setRefreshToken(r.login!.refreshToken!);
            LocalStorage.setIsLogin(true);
            LocalStorage.setEmail(email);
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

  void checkIndividualContainedOrNot() {
    try {
      if ((accountList.singleWhere(
              (it) => it.orgName == StringsConstant.individualAccount)) !=
          null) {
        isIndividualAccount = true;
      }
    } catch (e) {
      print(e);
    }
  }

  void redirectToSignUpScreen() {
    Get.toNamed(
        "${Routes.signup}?${StringsConstant.userTypeKey}=${isIndividualAccount ? StringsConstant.corporateAccount : StringsConstant.anyUser}&${StringsConstant.emailKey}${email.value}");
  }

  void checkLoginValidation(String email) {
    hideSoftKeyboard(Get.context!);
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
    loginApiCall(email);
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    passwordController.dispose();
    super.onClose();
  }
}
