import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../appUtils/validation_util.dart';
import 'reset_password_controller.dart';

class ResetPasswordDarkModeScreen extends GetView<ResetPasswordController> {
  const ResetPasswordDarkModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBlueMci,
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
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
                Text(
                  "Phew, ${StringsConstant.resetPassTitle}",
                  style: AppTheme.boldChinesewhite21spTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 33.28.h),
                newPasswordInputField(),
                SizedBox(height: 33.28.h),
                confirmPasswordInputField(),
                SizedBox(height: 33.3.h),
                passwordValidationViewLetters(),
                SizedBox(height: 17.h),
                passwordValidationViewNumberAndLetter(),
                SizedBox(height: 17.h),
                passwordValidationViewSpecialCharacters(),
                // newPasswordValidationView(),
                // SizedBox(height: 21.h),
                SizedBox(height: 17.h),
                confirmPasswordValidationView(),
                SizedBox(height: 268.h),
                matchParentCustomButtonDarkMode(() {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget newPasswordInputField() {
    return Column(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          StringsConstant.newPassword,
          style: AppTheme.text16blackStyle,
        ),
      ),
      SizedBox(height: 10.h),
      SizedBox(
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
                    color: AppColors.colorBackground),
                onPressed: () {
                  controller.isObscureText.value =
                      !controller.isObscureText.value;
                },
              ),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              border: AppTheme.inputFieldDarkModeBorder,
              //enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
              focusedBorder: AppTheme.textFieldFocusedBottomBorder,
              errorBorder: AppTheme.textFieldErrorBottomBorder,
              filled: true,
              fillColor: AppColors.colorTextBox),
          onChanged: (value) {
            controller.isValidatePass.value =
                ValidationUtil.isValidatePassword(value)!;
            controller.isChanged.value = true;
          },
        ),
      ),
    ]);
  }

  Widget confirmPasswordInputField() {
    return Column(children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          StringsConstant.confirmPassword,
          style: AppTheme.text16blackStyle,
        ),
      ),
      SizedBox(height: 10.h),
      SizedBox(
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
                    color: AppColors.colorBackground),
                onPressed: () {
                  controller.isObscureText.value =
                      !controller.isObscureText.value;
                },
              ),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              border: AppTheme.inputFieldDarkModeBorder,
              //enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
              focusedBorder: AppTheme.textFieldFocusedBottomBorder,
              errorBorder: AppTheme.textFieldErrorBottomBorder,
              filled: true,
              fillColor: AppColors.colorTextBox),
          onChanged: (value) {
            controller.matchPassword();
            controller.isChanged.value = true;
          },
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

  Widget matchParentCustomButtonDarkMode(VoidCallback voidCallback) {
    return SizedBox(
        width: 1.sw,
        height: 61.h,
        child: InkWell(
          onTap: voidCallback,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: Color(0XFFFFFFFF),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xff16A9B1),
                  offset: Offset(
                    0.0,
                    3.0,
                  ),
                  blurRadius: 0.5,
                  spreadRadius: 0.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                "Change password & Log In",
                style: AppTheme.boldColorRangoonGreen16sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  Widget passwordValidationViewLetters() {
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
                  "At least 8 characters",
                  style: TextStyle(
                      color: controller.isValidatePass.value
                          ? AppColors.colorSubText
                          : AppColors.colorSubText,
                      fontFamily: FontsConstant.avenirRegular,
                      fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ));
  }

  Widget passwordValidationViewSpecialCharacters() {
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
                  "One symbol eg: @#!\$%^&*",
                  style: TextStyle(
                      color: controller.isValidatePass.value
                          ? AppColors.colorSubText
                          : AppColors.colorSubText,
                      fontFamily: FontsConstant.avenirRegular,
                      fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ));
  }

  Widget passwordValidationViewNumberAndLetter() {
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
                  "One number & One capital letter",
                  style: TextStyle(
                      color: controller.isValidatePass.value
                          ? AppColors.colorSubText
                          : AppColors.colorSubText,
                      fontFamily: FontsConstant.avenirRegular,
                      fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ));
  }
}
