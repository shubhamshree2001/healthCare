import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/setingResetPassword/settingResetPassword_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class SettingResetPasswordScreen
    extends GetView<SettingResetPasswordController> {
  const SettingResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,

      //SettingCustomAppbar(voidCallback: () => Get.back()),
      appBar: AppBar(
          backgroundColor: AppColors.colorBlueChalk,
          elevation: 0,
          leading: Obx(
            () => controller.isChanged.value == true
                ? IconButton(
                    icon: Icon(Icons.close,
                        color: AppColors.colorBlack, size: 24),
                    onPressed: () => controller.isChanged.value = false,
                  )
                : IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back,
                        color: AppColors.colorBlack, size: 24),
                  ),
          ),
          actions: [
            Obx(() => Row(children: [
                  if (controller.isChanged.value) ...[
                    IconButton(
                      onPressed: () =>
                          controller.checkUpdatePasswordValidation(),
                      icon: Icon(Icons.check,
                          color: AppColors.colorBlack, size: 24),
                    ),
                  ]
                ])),
          ]),
      body: resetPasswordBody(),
    );
  }

  Widget resetPasswordBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w, vertical: 27.h),
          child: Form(
            key: controller.settingResetPasswordFormKey,
            child: Column(
              children: [
                SizedBox(height: 33.28.h),
                currentPasswordInputField(),
                SizedBox(height: 33.28.h),
                newPasswordInputField(),
                SizedBox(height: 33.28.h),
                confirmPasswordInputField(),
                SizedBox(height: 33.3.h),
                newPasswordValidationView(),
                SizedBox(height: 21.h),
                confirmPasswordValidationView(),
                // SizedBox(
                //   width: 172.09.w,
                //   child: ElevatedButton(
                //     style: AppTheme.matchParentButtonStyle,
                //     onPressed: () {
                //       controller.checkUpdatePasswordValidation();
                //     },
                //     child: Text(
                //       "Confirm",
                //       style: AppTheme.matchParentButtonTextStyle,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget currentPasswordInputField() {
    return Column(children: [
      Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              StringsConstant.oldPassword,
              style: AppTheme.subTitleRegularTextStyle,
            ),
          ),
          TextButton(
              onPressed: () {
                controller.sendLinkForgotPass();
                Get.toNamed(Routes.settingResetPassword);
              },
              child: Text(
                "(" + StringsConstant.forgot + ")",
                style: AppTheme.inputFieldUnderlineTextStyle,
              ))
        ],
      ),
      //SizedBox(height: 10.h),
      Obx(() => SizedBox(
            height: 45.h,
            child: TextFormField(
              controller: controller.currentPasswordController,
              keyboardType: TextInputType.text,
              obscureText: controller.isObscureText.value,
              style: AppTheme.inputFieldTextStyle,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        controller.isObscureText.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                        color: AppColors.colorPrimary),
                    onPressed: () {
                      controller.isObscureText.value =
                          !controller.isObscureText.value;
                    },
                  ),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  border: AppTheme.inputFieldBorder,
                  enabledBorder: AppTheme.inputFieldEnabledBorder,
                  focusedBorder: AppTheme.inputFieldFocusBorder,
                  filled: true,
                  fillColor: AppColors.colorWhite),
              onChanged: (value) {
                controller.isValidateCurrentPass.value =
                    ValidationUtil.isValidatePassword(value)!;
                controller.isChanged.value = true;
              },
            ),
          )),
    ]);
  }

  Widget newPasswordInputField() {
    return Column(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          StringsConstant.newPassword,
          style: AppTheme.subTitleRegularTextStyle,
        ),
      ),
      SizedBox(height: 10.h),
      Obx(() => SizedBox(
            height: 45.h,
            child: TextFormField(
              controller: controller.newPasswordController,
              keyboardType: TextInputType.text,
              obscureText: controller.isObscureText.value,
              style: AppTheme.inputFieldTextStyle,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        controller.isObscureText.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                        color: AppColors.colorPrimary),
                    onPressed: () {
                      controller.isObscureText.value =
                          !controller.isObscureText.value;
                    },
                  ),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                  border: AppTheme.inputFieldBorder,
                  enabledBorder: AppTheme.inputFieldEnabledBorder,
                  focusedBorder: AppTheme.inputFieldFocusBorder,
                  filled: true,
                  fillColor: AppColors.colorWhite),
              onChanged: (value) {
                controller.isValidatePass.value =
                    ValidationUtil.isValidatePassword(value)!;
                controller.isChanged.value = true;
              },
            ),
          )),
    ]);
  }

  Widget confirmPasswordInputField() {
    return Column(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          StringsConstant.confirmPassword,
          style: AppTheme.subTitleRegularTextStyle,
        ),
      ),
      SizedBox(height: 10.h),
      Obx(
        () => SizedBox(
          height: 45.h,
          child: TextFormField(
            controller: controller.confirmPasswordController,
            keyboardType: TextInputType.text,
            obscureText: controller.isObscureText.value,
            style: AppTheme.inputFieldTextStyle,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                      controller.isObscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 20,
                      color: AppColors.colorPrimary),
                  onPressed: () {
                    controller.isObscureText.value =
                        !controller.isObscureText.value;
                  },
                ),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                border: AppTheme.inputFieldBorder,
                enabledBorder: AppTheme.inputFieldEnabledBorder,
                focusedBorder: AppTheme.inputFieldFocusBorder,
                filled: true,
                fillColor: AppColors.colorWhite),
            onChanged: (value) {
              controller.matchPassword();
              controller.isChanged.value = true;
            },
          ),
        ),
      ),
    ]);
  }

  Widget newPasswordValidationView() {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 15.w,
                height: 15.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.isValidatePass.value
                      ? AppColors.colorPastelGreen
                      : const Color(0xFFD6D6D6),
                ),
                child: Center(
                  child: Icon(
                    controller.isValidatePass.value ? Icons.check : Icons.close,
                    color: AppColors.colorBlack,
                    size: 10,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  StringsConstant.passwordMessage,
                  style: TextStyle(
                      color: controller.isValidatePass.value
                          ? AppColors.colorSmokeyGrey
                          : Colors.red,
                      fontFamily: FontsConstant.avenirRegular,
                      fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ));
  }

  Widget confirmPasswordValidationView() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 15.w,
              height: 15.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.isPasswordMatch.value
                    //controller.isValidatePass.value
                    ? AppColors.colorPastelGreen
                    : const Color(0xFFD6D6D6),
              ),
              child: Center(
                child: Icon(
                  (controller.isPasswordMatch.value)
                      ? Icons.check
                      : Icons.close, //controller.isValidatePass.value
                  color: AppColors.colorBlack,
                  size: 10,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                StringsConstant.passwordMatch,
                style: TextStyle(
                    color: (controller.isPasswordMatch
                            .value) //controller.isValidatePass.value
                        ? AppColors.colorSmokeyGrey
                        : Colors.red,
                    fontFamily: FontsConstant.avenirRegular,
                    fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
