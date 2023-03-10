import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/auth_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/authRepo/auth_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';

import '../../../widgets/common_widget.dart';

class LoginController extends GetxController {
  final AuthRepo authRepo;

  LoginController({required this.authRepo});

  final emailController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  var isObscureText = false.obs;
  var readOnly = false.obs;
  var isValidatePass = false.obs;
  var receiveParams = NavigationParamsModel().obs;

  @override
  void onInit() {
    receiveParams.value = Get.arguments;
    emailController.text = "";
    initEasyLoading();
    super.onInit();
  }

  Future<void> loginApiCall(String email) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo.userLogin(AuthQueryMutation.userLogin(
          emailController.text, passwordController.text));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.login != null) {
          if (r.login!.verifyToken != null &&
              r.login!.verifyToken!.isNotEmpty) {
            Get.toNamed(Routes.otp,
                arguments: [emailController.text, r.login!.verifyToken]);
          } else {
            LocalStorage.setAccessToken(r.login!.accessToken!);
            LocalStorage.setRefreshToken(r.login!.refreshToken!);
            LocalStorage.setIsLogin(true);
            LocalStorage.setEmail(emailController.text);
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

  Future<void> getAllAccountList() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo.getAllAccountList(
          AuthQueryMutation.getListOfAllAccounts(emailController.text));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.accountList != null && r.accountList!.isNotEmpty) {
          Get.toNamed(
              "${Routes.accountList}?${StringsConstant.emailKey}==${emailController.text}",
              arguments: r);
        } else {
          /// Redirect to signup screen
          Get.toNamed(
              "${Routes.signup}?${StringsConstant.userTypeKey}=${StringsConstant.anyUser}&"
              "${StringsConstant.emailKey}=${emailController.text}");
        }

        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
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

  // void checkLoginValidation() {
  //   hideSoftKeyboard(Get.context!);
  //   final isValid = loginFormKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   loginFormKey.currentState!.save();
  //   //getAllAccountList();
  // }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }
}
