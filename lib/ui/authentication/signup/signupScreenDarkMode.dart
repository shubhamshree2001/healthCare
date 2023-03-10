import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/uppercase_textformatter.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/signup/signup_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class SignupDarkModeScreen extends GetView<SignupController> {
  const SignupDarkModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      backgroundColor: AppColors.colorDarkBackgroundScreen,
      body: signupBody(),
    );
  }

  Widget signupBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Form(
            key: controller.signupFormKey,
            child: Column(
              children: [
                SizedBox(height: 27.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Create your account",
                    style: AppTheme.boldChinesewhite21spTextStyle,
                  ),
                ),
                SizedBox(height: 36.71.h),
                emailInputField(),
                SizedBox(height: 33.h),
                fullNameInputField(),
                SizedBox(height: 33.h),
                mobileCodeDropdown(),
                SizedBox(height: 33.h),
                mobileInputField(),
                SizedBox(height: 33.h),
                passwordInputField(),
                SizedBox(height: 103.h),
                matchParentCustomButtonDarkMode(
                    () => controller.checkSignupValidation()),
                SizedBox(height: 33.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppTheme.text16blackStyle,
                    ),
                    SizedBox(width: 10.w),
                    InkWell(
                        onTap: () {
                          if (controller.receiveParams.value.isAccessWithOrg ==
                              true) {
                            Get.toNamed(Routes.signupDarkMode);
                          } else {
                            openLoginBottomSheet();
                          }
                        },
                        child: Text(
                          "Log In",
                          style: AppTheme.underlinePrimaryTextStyle,
                        ))
                  ],
                ),
                SizedBox(height: 49.h)
              ],
            ),
          ),
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
                "Sign Up",
                style: AppTheme.boldColorRangoonGreen16sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  Widget emailInputField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      style: AppTheme.inputFieldTextStyle,
      decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(color: AppColors.colorTextFieldText),
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          border: AppTheme.inputFieldDarkModeBorder,
          enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
          focusedBorder: AppTheme.textFieldBorder,
          errorBorder: AppTheme.textFieldErrorBorder,
          filled: true,
          fillColor: AppColors.colorDarkBackgroundScreen),
      validator: (value) {
        return ValidationUtil.validateEmail(value!);
      },
    );
  }

  Widget fullNameInputField() {
    return TextFormField(
      readOnly: controller.readOnly.value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller.nameController,
      keyboardType: TextInputType.emailAddress,
      style: AppTheme.inputFieldTextStyle,
      decoration: InputDecoration(
          labelText: "Name",
          labelStyle: TextStyle(color: AppColors.colorTextFieldText),
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          border: AppTheme.inputFieldDarkModeBorder,
          enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
          //disabledBorder: AppTheme.textFieldFocusedBottomBorder,
          focusedBorder: AppTheme.textFieldBorder,
          errorBorder: AppTheme.textFieldErrorBorder,
          filled: true,
          fillColor: controller.readOnly.value
              ? AppColors.colorDarkBackgroundScreen
              : AppColors.colorDarkBackgroundScreen),
      validator: (value) {
        return ValidationUtil.validateFullName(value!);
      },
    );
  }

  Widget mobileInputField() {
    return Column(
      children: [
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Text(
        //     StringsConstant.phone,
        //     style: AppTheme.boldColorwhite16sp,
        //   ),
        // ),
        // SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //mobileCodeDropdown(),
            //SizedBox(width: 15.w),
            Expanded(
              child: TextFormField(
                readOnly: controller.readOnly.value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.mobileController,
                keyboardType: TextInputType.phone,
                style: AppTheme.inputFieldTextStyle,
                decoration: InputDecoration(
                    errorMaxLines: 2,
                    labelText: "Phone",
                    labelStyle: TextStyle(color: AppColors.colorTextFieldText),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                    border: AppTheme.inputFieldDarkModeBorder,
                    enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
                    focusedBorder: AppTheme.textFieldBorder,
                    errorBorder: AppTheme.textFieldErrorBorder,
                    filled: true,
                    fillColor: controller.readOnly.value
                        ? AppColors.colorDarkBackgroundScreen
                        : AppColors.colorDarkBackgroundScreen),
                validator: (value) {
                  return ValidationUtil.validateMobileNo(value!);
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget mobileCodeDropdown() {
    return Obx(() => IgnorePointer(
          ignoring: controller.readOnly.value,
          child: Container(
            width: 1.sw, //90.w,
            height: 58.h, //58.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.colorPrimaryDark,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Color(0xff16A9B1),
              //     offset: Offset(
              //       0.0,
              //       2.0,
              //     ),
              //     blurRadius: 0.0,
              //     spreadRadius: 0.0,
              //   ),
              // ],
              color: controller.readOnly.value
                  ? AppColors.colorDarkBackgroundScreen
                  : AppColors.colorDarkBackgroundScreen,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<CountryCodeItem>(
                value: controller.selectedCountryCode.value,
                // isDense: true,
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 20,
                menuMaxHeight: 0.4.sh,
                onChanged: (CountryCodeItem? stateModel) {
                  controller.selectedCountryCode.value = stateModel!;
                },
                items: controller.countryCodeList.map((CountryCodeItem map) {
                  return DropdownMenuItem<CountryCodeItem>(
                      value: map,
                      child: Row(
                        children: [
                          SvgPicture.network(map.flag!),
                          Text(map.code!,
                              style: AppTheme.regularWhite10spTextStyle),
                        ],
                      ));
                }).toList(),
              ),
            ),
          ),
        ));
  }

  Widget passwordInputField() {
    return Column(children: [
      Obx(() => SizedBox(
            height: 58.h,
            child: TextFormField(
              readOnly: controller.readOnly.value,
              controller: controller.passwordController,
              keyboardType: TextInputType.text,
              obscureText: controller.isObscureText.value,
              style: AppTheme.inputFieldTextStyle,
              decoration: InputDecoration(
                  labelText: "Create Password",
                  labelStyle: TextStyle(color: AppColors.colorTextFieldText),
                  suffixIcon: IconButton(
                    icon: Icon(
                        controller.isObscureText.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                        color: AppColors.colorBackground),
                    onPressed: () {
                      controller.isObscureText.value =
                          !controller.isObscureText.value;
                    },
                  ),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                  border: AppTheme.inputFieldDarkModeBorder,
                  enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
                  focusedBorder: AppTheme.textFieldBorder,
                  //errorBorder: AppTheme.textFieldErrorBorder,
                  filled: true,
                  fillColor: controller.readOnly.value
                      ? AppColors.colorDarkBackgroundScreen
                      : AppColors.colorDarkBackgroundScreen),
              onChanged: (value) {
                controller.isValidatePass.value =
                    ValidationUtil.isValidatePassword(value)!;
              },
            ),
          )),
      SizedBox(height: 32.71.h),
      passwordValidationViewLetters(),
      SizedBox(height: 17.h),
      passwordValidationViewNumberAndLetter(),
      SizedBox(height: 17.h),
      passwordValidationViewSpecialCharacters(),
    ]);
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

  openLoginBottomSheet() {
    return Get.bottomSheet(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 13.5.h),
                Container(
                  height: 5.h,
                  width: 42.w,
                  decoration: BoxDecoration(color: Color(0xff707070)),
                ),
                // if (controller.receiveParams.value.isAccessWithOrg == true) ...[
                //   SizedBox(height: 20.47.h),
                //   Container(
                //     height: 87.h,
                //     width: 190.w,
                //     child: Image.asset(
                //       ImagesConstant.companyLogo,
                //     ),
                //   ),
                //   SizedBox(height: 14.h),
                // ],
                // if (controller.receiveParams.value.isAccessWithOrg ==
                //     false) ...[SizedBox(height: 29.h)],
                SizedBox(height: 23.h),
                Text(
                  "Log in to your account",
                  style: AppTheme.boldChinesewhite21spTextStyle,
                ),
                SizedBox(height: 32.h),
                if (GetPlatform.isAndroid) ...[
                  socialMediaButton(
                      StringsConstant.googleBtnLabel, ImagesConstant.googleIcon,
                      () {
                    //controller.googleLogin();
                    //controller.signIn();
                  }),
                  SizedBox(height: 24.h),
                  socialMediaEmailButton(
                      StringsConstant.emailBtnLabel, ImagesConstant.emailImg,
                      () {
                    Navigator.of(Get.context!).pop();
                    Get.toNamed(Routes.loginDarkModeScreen,
                        arguments: NavigationParamsModel(
                            isAccessWithOrg: controller
                                .receiveParams.value.isAccessWithOrg));
                  }),
                  //SizedBox(height: 59.h),
                ] else ...[
                  socialMediaButton(StringsConstant.googleBtnLabel,
                      ImagesConstant.googleIcon, () {}),
                  SizedBox(height: 24.h),
                  socialMediaAppleButton(StringsConstant.appleBtnLabel,
                      ImagesConstant.newAppleIcon, () {}),
                  SizedBox(height: 24.h),
                  socialMediaEmailButton(
                      StringsConstant.emailBtnLabel, ImagesConstant.emailImg,
                      () {
                    Navigator.of(Get.context!).pop();
                    Get.toNamed(Routes.loginDarkModeScreen);
                  }),
                  //SizedBox(height: 59.h),
                ],
                // if (controller.receiveParams.value.isAccessWithOrg ==
                //     false) ...[
                //   SizedBox(height: 59.h),
                // ],
                // if (controller.receiveParams.value.isAccessWithOrg == true) ...[
                //   SizedBox(height: 32.h),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "Don't have an account?",
                //         style: AppTheme.boldColorRangoonGreen16sp,
                //       ),
                //       SizedBox(width: 5.w),
                //       InkWell(
                //         onTap: () {
                //           Navigator.of(Get.context!).pop();
                //           //openSignInBottomSheet();
                //         },
                //         child: Text(
                //           "Sign Up",
                //           style: AppTheme.underlinePrimaryTextStyle,
                //         ),
                //       ),
                //     ],
                //   ),
                //   SizedBox(height: 42.h),
                // ]
                SizedBox(height: 42.h),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.colorTextBox,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false,
        persistent: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))));
  }
}
