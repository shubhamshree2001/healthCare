import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/uppercase_textformatter.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/callback/callback.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/mvciResultResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/signup/signup_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/welcomeScreen/welcomeScreenController.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class WelcomeScreen extends GetView<WelcomeScreenController>
    implements CallBack {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppbar(voidCallback: () => Get.back()),
      body: Obx(() => welcomeBody()),
      backgroundColor: AppColors.colorBlueMci,
    );
  }

  Widget welcomeBody() {
    return SafeArea(
      child: Stack(
        children: [
          Wrap(
            direction: Axis.horizontal,
            children: [
              SvgPicture.asset(
                ImagesConstant.backgroundImage,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 23.h),
              if (controller.isAccessOrganization.value == false) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Image.asset(
                    ImagesConstant.logoBlackMindpeers,
                    //height: 22.h,
                    //width: 200.w,
                  ),
                ),
              ],
              if (controller.isAccessOrganization.value == true) ...[
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    ImagesConstant.companyLogo,
                    height: 83.h,
                    width: 190.w,
                  ),
                )
              ],
              //SizedBox(height: 65.53.h),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 57.h),
              //   child: CarouselSlider.builder(
              //     itemCount: 3,
              //     itemBuilder: (context, itemIndex, pageViewIndex) {
              //       return reportDetailSlider(context, itemIndex);
              //     },
              //     options: CarouselOptions(
              //       onPageChanged: (index, reason) {
              //         controller.selectedStrengthIndex.value = index;
              //       },
              //       enlargeCenterPage: true,
              //       //autoPlay: true,
              //       //aspectRatio: 16 / 9,
              //       //autoPlayCurve: Curves.fastOutSlowIn,
              //       //enableInfiniteScroll: true,
              //       autoPlayAnimationDuration:
              //           const Duration(milliseconds: 800),
              //       viewportFraction: 1,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 16.h),
              // DotsIndicator(
              //   dotsCount: 3,
              //   position: controller.selectedStrengthIndex.value.toDouble(),
              //   decorator: const DotsDecorator(
              //     color: AppColors.coloeSlider,
              //     activeColor: AppColors.coloractiveSlide,
              //   ),
              // ),
              //SizedBox(height: 61.h),
              SizedBox(height: 380.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  "Hey there,",
                  style: AppTheme.boldChinesewhite28spTextStyle,
                ),
              ),
              SizedBox(height: 13.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  "Let's get started on your mental strength journey!",
                  style: AppTheme.white16sp,
                ),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.h),
                child: SizedBox(
                    width: 1.sw,
                    height: 61.h,
                    child: InkWell(
                      onTap: () {
                        // controller.isAccessOrganization.value = false;
                        // openSignInBottomSheet();
                        controller.isAccessOrganization.value
                            ? Get.toNamed(Routes.signupDarkMode,
                                arguments: NavigationParamsModel(
                                    isAccessWithOrg:
                                        controller.isAccessOrganization.value))
                            : openSignInBottomSheet();
                      },
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
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Text(
                            "Create account",
                            style: AppTheme.boldColorRangoonGreen16sp,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: AppTheme.text16blackStyle,
                  ),
                  SizedBox(width: 5.w),
                  InkWell(
                    onTap: () {
                      // controller.isAccessOrganization.value = false;
                      // openLoginBottomSheet();
                      controller.isAccessOrganization.value
                          ? Get.toNamed(Routes.loginDarkModeScreen,
                              arguments: NavigationParamsModel(
                                  isAccessWithOrg:
                                      controller.isAccessOrganization.value))
                          : openLoginBottomSheet();
                    },
                    child: Text(
                      "Log In",
                      style: AppTheme.underlinePrimaryTextStyle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 45.h),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: Colors.black,
                dashGradient: [Colors.red, Colors.blue],
                dashRadius: 0.0,
                dashGapLength: 4.0,
                dashGapColor: Colors.transparent,
                dashGapGradient: [Colors.red, Colors.blue],
                dashGapRadius: 0.0,
              ),
              SizedBox(height: 45.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.h),
                child: SizedBox(
                    width: 1.sw,
                    height: 61.h,
                    child: InkWell(
                      onTap: () {
                        // controller.isAccessOrganization.value = true;
                        if (controller.isAccessOrganization.value == false) {
                          enterAccessCodeBottomSheet();
                        } else if (controller.isAccessOrganization.value ==
                            true) {
                          //controller.isAccessOrganization.value = false;
                          Get.toNamed(Routes.welcomeScreen);
                          controller.isAccessOrganization.value = false;
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            color: Color(0XFF171717),
                            border: Border.all(
                              color: Color(0xffFFFFFF),
                              style: BorderStyle.solid,
                              width: 1.0,
                            )),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Text(
                            controller.isAccessOrganization.value
                                ? "Make a personal account"
                                : "Access Organization Account",
                            style: AppTheme.white16sp,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget reportDetailSlider(BuildContext context, index) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(14),
  //       ),
  //     ),
  //     child: Image.asset(ImagesConstant.welcomeImage),
  //   );
  // }

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
                if (controller.isAccessOrganization.value == true) ...[
                  SizedBox(height: 20.47.h),
                  Container(
                    height: 87.h,
                    width: 190.w,
                    child: Image.asset(
                      ImagesConstant.companyLogo,
                    ),
                  ),
                  SizedBox(height: 14.h),
                ],
                if (controller.isAccessOrganization.value == false) ...[
                  SizedBox(height: 29.h)
                ],
                Text(
                  "Log in to your account",
                  style: AppTheme.boldChinesewhite21spTextStyle,
                ),
                SizedBox(height: 32.h),
                if (GetPlatform.isAndroid) ...[
                  socialMediaButton(
                      StringsConstant.googleBtnLabel, ImagesConstant.googleIcon,
                      () {
                    controller.googleAccountLogin();
                    //controller.signIn();
                  }),
                  SizedBox(height: 24.h),
                  socialMediaEmailButton(
                      StringsConstant.emailBtnLabel, ImagesConstant.emailImg,
                      () {
                    Navigator.of(Get.context!).pop();
                    Get.toNamed(Routes.loginDarkModeScreen,
                        arguments: NavigationParamsModel(
                            isAccessWithOrg:
                                controller.isAccessOrganization.value));
                  }),
                  //SizedBox(height: 59.h),
                ] else ...[
                  socialMediaButton(
                      StringsConstant.googleBtnLabel, ImagesConstant.googleIcon,
                      () {
                    controller.googleAccountLogin();
                  }),
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
                if (controller.isAccessOrganization.value == false) ...[
                  SizedBox(height: 59.h),
                ],
                if (controller.isAccessOrganization.value == true) ...[
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTheme.boldColorRangoonGreen16sp,
                      ),
                      SizedBox(width: 5.w),
                      InkWell(
                        onTap: () {
                          Navigator.of(Get.context!).pop();
                          openSignInBottomSheet();
                        },
                        child: Text(
                          "Sign Up",
                          style: AppTheme.underlinePrimaryTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 42.h),
                ]
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
                if (controller.isAccessOrganization.value == true) ...[
                  SizedBox(height: 20.47.h),
                  Container(
                    height: 87.h,
                    width: 190.w,
                    child: Image.asset(
                      ImagesConstant.companyLogo,
                    ),
                  ),
                  SizedBox(height: 14.h),
                ],
                if (controller.isAccessOrganization.value == false) ...[
                  SizedBox(height: 29.h)
                ],
                Text(
                  "Create your account",
                  style: AppTheme.boldChinesewhite21spTextStyle,
                ),
                //SizedBox(height: 32.h),
                SizedBox(height: 32.h),
                if (GetPlatform.isAndroid) ...[
                  socialMediaButton(
                      controller.isAccessOrganization.value == false
                          ? StringsConstant.signUpGoogleBtnLabel
                          : StringsConstant.workGmail,
                      ImagesConstant.googleIcon, () {
                    controller.googleLogin();
                    //controller.signIn();
                  }),
                  SizedBox(height: 24.h),
                  socialMediaEmailButton(StringsConstant.signUpEmailBtnLabel,
                      ImagesConstant.emailImg, () {
                    Navigator.of(Get.context!).pop();
                    Get.toNamed(Routes.signupDarkMode,
                        arguments: NavigationParamsModel(
                            isAccessWithOrg:
                                controller.isAccessOrganization.value));
                  }),
                  //SizedBox(height: 59.h),
                ] else ...[
                  socialMediaButton(
                      controller.isAccessOrganization.value == false
                          ? StringsConstant.signUpGoogleBtnLabel
                          : StringsConstant.workGmail,
                      ImagesConstant.googleIcon, () {
                    controller.googleLogin();
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
                if (controller.isAccessOrganization.value == false) ...[
                  SizedBox(height: 59.h),
                ],
                if (controller.isAccessOrganization.value == true) ...[
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: AppTheme.boldColorRangoonGreen16sp,
                      ),
                      SizedBox(width: 5.w),
                      InkWell(
                        onTap: () {
                          Navigator.of(Get.context!).pop();
                          openLoginBottomSheet();
                        },
                        child: Text(
                          "Log In",
                          style: AppTheme.underlinePrimaryTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 42.h),
                ]
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

  enterAccessCodeBottomSheet() {
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
                SizedBox(height: 29.5.h),
                Text(
                  "Enter your Access code",
                  style: AppTheme.boldChinesewhite21spTextStyle,
                ),
                SizedBox(height: 21.83.h),
                corporateInputField(),
                SizedBox(height: 41.96.h),
                matchParentCustomButtonDarkMode(() {
                  Navigator.of(Get.context!).pop();
                  //openSignInBottomSheet();
                  controller.isAccessOrganization.value = true;
                  Get.toNamed(Routes.welcomeScreen);
                }),
                SizedBox(height: 45.h),
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
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                "Next",
                style: AppTheme.boldColorRangoonGreen16sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  Widget corporateInputField() {
    return Column(
      children: [
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Text(
        //     StringsConstant.corporateAccessCode,
        //     style: AppTheme.boldColorRangoonGreen16sp,
        //   ),
        // ),
        //SizedBox(height: 10.h),
        TextFormField(
          inputFormatters: [UpperCaseTextFormatter()],
          focusNode: controller.focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.corporateAccessCodeController,
          keyboardType: TextInputType.text,
          style: AppTheme.inputFieldBlackTextStyle,
          decoration: InputDecoration(
              labelText: "Access code",
              labelStyle: TextStyle(color: AppColors.colorTextFieldText),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
              // border: AppTheme.inputFieldEnabledBorder,
              //enabledBorder: AppTheme.textFieldFocusedBottomBorder,
              //focusedBorder: AppTheme.textFieldFocusedBottomBorder,
              //errorBorder: AppTheme.textFieldErrorBottomBorder,
              border: AppTheme.inputFieldDarkModeBorder,
              enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
              focusedBorder: AppTheme.textFieldBorder,
              errorBorder: AppTheme.textFieldErrorBorder,
              filled: true,
              //fillColor: AppColors.colorWhite
              fillColor: AppColors.colorDarkBackgroundScreen),
          validator: (value) {
            return ValidationUtil.validateCorporateAccessCode(value!);
          },
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  Widget phoneNumberInputField() {
    return Column(
      children: [
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Text(
        //     StringsConstant.corporateAccessCode,
        //     style: AppTheme.boldColorRangoonGreen16sp,
        //   ),
        // ),
        //SizedBox(height: 10.h),
        TextFormField(
          inputFormatters: [UpperCaseTextFormatter()],
          focusNode: controller.focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.manualPhoneNumber,
          keyboardType: TextInputType.text,
          style: AppTheme.inputFieldBlackTextStyle,
          decoration: InputDecoration(
              labelText: "Phone Number",
              labelStyle: TextStyle(color: AppColors.colorTextFieldText),
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
              // border: AppTheme.inputFieldEnabledBorder,
              //enabledBorder: AppTheme.textFieldFocusedBottomBorder,
              //focusedBorder: AppTheme.textFieldFocusedBottomBorder,
              //errorBorder: AppTheme.textFieldErrorBottomBorder,
              border: AppTheme.inputFieldDarkModeBorder,
              enabledBorder: AppTheme.inputFieldDarkEnabledBorder,
              focusedBorder: AppTheme.textFieldBorder,
              errorBorder: AppTheme.textFieldErrorBorder,
              filled: true,
              //fillColor: AppColors.colorWhite
              fillColor: AppColors.colorDarkBackgroundScreen),
          validator: (value) {
            return ValidationUtil.validateMobileNo(value!);
          },
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  @override
  void onCall() {
    Navigator.pop(Get.context!);
    phoneNumberInputField();
  }
}
