import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/login/login_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../appUtils/validation_util.dart';

class LoginDarkModeScreen extends GetView<LoginController> {
  const LoginDarkModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBlueMci,
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      body: loginScreenBody(),
    );
  }

  Widget loginScreenBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    "Welcome back, Log In to your account",
                    style: AppTheme.boldChinesewhite21spTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 36.h),
                emailInputField(),
                SizedBox(height: 41.71.h),
                passwordInputField(),
                SizedBox(height: 381.h),
                matchParentCustomButtonDarkMode(() {
                  //controller.loginApiCall(controller.emailController.text);
                  controller
                      .checkLoginValidation(controller.emailController.text);
                }),
                SizedBox(height: 33.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppTheme.text16blackStyle,
                    ),
                    SizedBox(width: 10.w),
                    InkWell(
                        onTap: () {
                          if (controller.receiveParams.value.isAccessWithOrg ==
                              true) {
                            Get.toNamed(Routes.signupDarkMode);
                          } else {
                            openSignInBottomSheet();
                          }
                        },
                        child: Text(
                          "Sign up",
                          style: AppTheme.underlinePrimaryTextStyle,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailInputField() {
    return Column(
      children: [
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Text(
        //     StringsConstant.email,
        //     style: AppTheme.boldColorwhite16sp,
        //   ),
        // ),
        // SizedBox(height: 10.h),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          style: AppTheme.inputFieldTextStyle,
          decoration: InputDecoration(
              isDense: true,
              labelText: "Email",
              labelStyle: TextStyle(color: AppColors.colorTextFieldText),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              border: AppTheme.inputFieldDarkModeBorder,
              enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
              focusedBorder: AppTheme.textFieldBorder,
              errorBorder: AppTheme.textFieldErrorBorder,
              filled: true,
              fillColor: AppColors.colorDarkBackgroundScreen),
          validator: (value) {
            return ValidationUtil.validateEmail(value!);
          },
        ),
      ],
    );
  }

  Widget passwordInputField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Row(
      //   children: [
      //     Align(
      //       alignment: Alignment.topLeft,
      //       child: Text(
      //         StringsConstant.createPassword,
      //         style: AppTheme.boldColorwhite16sp,
      //       ),
      //     ),
      //     SizedBox(width: 6.w),
      //     InkWell(
      //       onTap: () {
      //         Get.toNamed(Routes.sendResetLinkDarkMode);
      //       },
      //       child: Text(
      //         "Forgot?",
      //         style: AppTheme.primaryTextStyle,
      //       ),
      //     )
      //   ],
      // ),
      //SizedBox(height: 10.h),
      Obx(
        () => SizedBox(
          height: 45.h,
          child: TextFormField(
            readOnly: controller.readOnly.value,
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
                      color: AppColors.colorBackground),
                  onPressed: () {
                    controller.isObscureText.value =
                        !controller.isObscureText.value;
                  },
                ),
                isDense: true,
                labelText: "  Password",
                labelStyle: TextStyle(color: AppColors.colorTextFieldText),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                border: AppTheme.inputFieldDarkModeBorder,
                enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
                focusedBorder: AppTheme.textFieldBorder,
                errorBorder: AppTheme.textFieldErrorBorder,
                filled: true,
                fillColor: controller.readOnly.value
                    ? AppColors.colorDarkBackgroundScreen
                    : AppColors.colorDarkBackgroundScreen),
            onChanged: (value) {
              controller.isValidatePass.value =
                  ValidationUtil.isValidatePassword(value)!;
            },
          ),
        ),
      ),
      SizedBox(height: 10.h),
      InkWell(
        onTap: () {
          Get.toNamed(Routes.sendResetLinkDarkMode,
              arguments: NavigationParamsModel(
                  email: controller.emailController.text));
        },
        child: Text(
          "(Forgot password?)",
          style: AppTheme.primaryTextStyle,
        ),
      )
    ]);
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
                "Login",
                style: AppTheme.boldColorRangoonGreen16sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  openSignInBottomSheet() {
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
                // if (controller.isAccessOrganization.value == true) ...[
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
                // if (controller.isAccessOrganization.value == false) ...[
                //   SizedBox(height: 29.h)
                // ],
                SizedBox(height: 29.h),
                Text(
                  "Create your account",
                  style: AppTheme.boldChinesewhite21spTextStyle,
                ),
                //SizedBox(height: 32.h),
                SizedBox(height: 32.h),
                if (GetPlatform.isAndroid) ...[
                  socialMediaButton(
                      // controller.isAccessOrganization.value == false
                      //     ? StringsConstant.signUpGoogleBtnLabel
                      //     : StringsConstant.workGmail,
                      StringsConstant.signUpGoogleBtnLabel,
                      ImagesConstant.googleIcon, () {
                    //controller.googleLogin();
                    //controller.signIn();
                  }),
                  SizedBox(height: 24.h),
                  socialMediaEmailButton(StringsConstant.signUpEmailBtnLabel,
                      ImagesConstant.emailImg, () {
                    Navigator.of(Get.context!).pop();
                    Get.toNamed(Routes.signupDarkMode,
                        arguments: NavigationParamsModel(
                            isAccessWithOrg: controller
                                .receiveParams.value.isAccessWithOrg));
                  }),
                  //SizedBox(height: 59.h),
                ] else ...[
                  socialMediaButton(
                      // controller.isAccessOrganization.value == false
                      //     ? StringsConstant.signUpGoogleBtnLabel
                      //     : StringsConstant.workGmail,
                      StringsConstant.signUpGoogleBtnLabel,
                      ImagesConstant.googleIcon, () {
                    //controller.googleLogin();
                    //controller.signIn();
                  }),
                  SizedBox(height: 24.h),
                  socialMediaAppleButton(StringsConstant.signUpAppleBtnLabel,
                      ImagesConstant.newAppleIcon, () {}),
                  SizedBox(height: 24.h),
                  socialMediaEmailButton(StringsConstant.signUpEmailBtnLabel,
                      ImagesConstant.emailImg, () {
                    Navigator.of(Get.context!).pop();
                    Get.toNamed(Routes.signupDarkMode);
                  }),
                  //SizedBox(height: 59.h),
                ],
                // if (controller.isAccessOrganization.value == false) ...[
                //   SizedBox(height: 59.h),
                // ],
                // if (controller.isAccessOrganization.value == true) ...[
                //   SizedBox(height: 32.h),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "Already have an account?",
                //         style: AppTheme.boldColorRangoonGreen16sp,
                //       ),
                //       SizedBox(width: 5.w),
                //       InkWell(
                //         onTap: () {
                //           Navigator.of(Get.context!).pop();
                //           openLoginBottomSheet();
                //         },
                //         child: Text(
                //           "Log In",
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
