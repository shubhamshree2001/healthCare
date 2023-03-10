import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/update_password_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/updatePassword_response.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/auth_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/setting_query_Mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';

import '../../../../widgets/common_widget.dart';

class SettingResetPasswordController extends GetxController {
  final SettingRepo settingRepo;

  SettingResetPasswordController({required this.settingRepo});

  final nameController = TextEditingController();
  var isPasswordMatch = false.obs;

  final newPasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isChanged = false.obs;
  var isObscureText = true.obs;
  final GlobalKey<FormState> settingResetPasswordFormKey =
      GlobalKey<FormState>();
  var user = GetUser().obs;
  var isValidateNewPass = false.obs;
  var isValidatePass = false.obs;
  var isValidateCurrentPass = false.obs;
  var email = "".obs;

  @override
  void onInit() {
    //email.value = Get.arguments;
    getUser();
    initEasyLoading();
    super.onInit();
  }

  Future<void> sendLinkForgotPass() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await settingRepo.sendLinkForgotPass(
          AuthQueryMutation.sendLinkForgotPass(email.value));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r != null) {
          showSnackBar("", "Reset link sent to your email", false);
          //Get.offAllNamed(Routes.initial);
        }

        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> updatePasswordRequest(String query) async {
    try {
      final either = await settingRepo.updatePassword(query);
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.authMutation != null) {
          showSnackBar("success", "Thank you for changing us", false);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void checkUpdatePasswordValidation() {
    hideSoftKeyboard(Get.context!);
    final isValid = settingResetPasswordFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      settingResetPasswordFormKey.currentState!.save();
      var changePasswordRequest = ChangePasswordRequest(
        token: LocalStorage.getAccessToken(),
        current: currentPasswordController.text.toString(),
        update: newPasswordController.text.toString(), //as String,
      );
      updatePasswordRequest(
          SettingQueryMutation.updatePassword(changePasswordRequest));
      isChanged.value = false;
    }
  }

  Future<void> getUser() async {
    try {
      final either = await settingRepo.getUser(AuthQueryMutation.getUser());
      either.fold((l) {}, (r) {
        if (r.auth?.getUser != null) {
          user.value = r.auth!.getUser!;
          email.value = user.value.email!;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");

      print("Stacktrace==${stacktrace.toString()}");
    }
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

    //newPasswordController.dispose();
    currentPasswordController.dispose();

    super.onClose();
  }
}
