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

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorGhostWhite,
      appBar: CustomAppbar(voidCallback: () => Get.back()),
      body: resetPasswordBody(),
    );
  }

  Widget resetPasswordBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w, vertical: 27.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Phew, ${StringsConstant.resetPassTitle}",
                  style: AppTheme.titleChineseBlackBoldTextStyle,
                ),
              ),
              SizedBox(height: 38.5.h),
              newPasswordInputField(),
              SizedBox(height: 12.28.h),
              confirmPasswordInputField(),
              SizedBox(height: 46.h),
              newPasswordValidationView(),
              SizedBox(height: 21.h),
              confirmPasswordValidationView(),
              SizedBox(height: 46.h),
              matchParentCustomButton(StringsConstant.resetPassword, () {}),
            ],
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
          style: AppTheme.subTitleRegularTextStyle,
        ),
      ),
      SizedBox(height: 10.h),
      Obx(() => SizedBox(
            height: 45.h,
            child: TextFormField(
              controller: controller.passwordController,
              keyboardType: TextInputType.text,
              obscureText: controller.isObscureText.value,
              style: AppTheme.inputFieldTextStyle,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        controller.isObscureText.value
                            ? Icons.visibility
                            : Icons.visibility_off,
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
      Obx(() => SizedBox(
            height: 45.h,
            child: TextFormField(
              controller: controller.passwordController,
              keyboardType: TextInputType.text,
              obscureText: controller.isObscureText.value,
              style: AppTheme.inputFieldTextStyle,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        controller.isObscureText.value
                            ? Icons.visibility
                            : Icons.visibility_off,
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
              },
            ),
          )),
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
                  StringsConstant.passwordMatch,
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
}
