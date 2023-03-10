import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/uppercase_textformatter.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/signup/signup_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../appUtils/validation_util.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(voidCallback: () => Get.back()),
      body: Obx(() => signupBody()),
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
                    StringsConstant.signUpTitle,
                    style: AppTheme.titleChineseBlackBoldTextStyle,
                  ),
                ),
                SizedBox(height: 50.h),
                Row(
                  children: [
                    Obx(() => Visibility(
                          visible: controller.isShowCorporateSwitch.value,
                          child: CupertinoSwitch(
                            activeColor: AppColors.colorPrimary,
                            trackColor: AppColors.colorMountainMistGrey,
                            onChanged: (bool value) {
                              controller.corporateSwitch.value = value;
                              controller.corporateSwitchOnChange(value);
                            },
                            value: controller.corporateSwitch.value,
                          ),
                        )),
                    SizedBox(width: 15.w),
                    Text(
                      StringsConstant.corporateSwitchLabel,
                      style: AppTheme.regularColorRangoonGreen16sp,
                    )
                  ],
                ),
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Obx(() => Text(
                            "${controller.email}",
                            style: AppTheme.boldChineseBlackColor16spTextStyle,
                          )),
                      SizedBox(width: 8.w),
                      InkWell(
                        child: Text(
                          StringsConstant.change,
                          style: AppTheme.underlineTextStyle,
                        ),
                        onTap: () => Get.back(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 35.h),
                corporateInputField(),
                fullNameInputField(),
                SizedBox(height: 19.h),
                mobileInputField(),
                SizedBox(height: 19.h),
                passwordInputField(),
                SizedBox(height: 38.h),
                termsAndConditionView(),
                SizedBox(height: 20.h),
                matchParentCustomButton(StringsConstant.signUp,
                    () => controller.checkSignupValidation()),
                SizedBox(height: 35.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fullNameInputField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            StringsConstant.name,
            style: AppTheme.subTitleRegularTextStyle,
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          readOnly: controller.readOnly.value,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.nameController,
          keyboardType: TextInputType.emailAddress,
          style: AppTheme.inputFieldTextStyle,
          decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              border: AppTheme.inputFieldBorder,
              enabledBorder: AppTheme.inputFieldEnabledBorder,
              focusedBorder: AppTheme.inputFieldFocusBorder,
              errorBorder: AppTheme.inputFieldEnabledBorder,
              filled: true,
              fillColor: controller.readOnly.value
                  ? AppColors.colorPorcelain
                  : AppColors.colorWhite),
          validator: (value) {
            return ValidationUtil.validateFullName(value!);
          },
        )
      ],
    );
  }

  Widget corporateInputField() {
    return Obx(() => Visibility(
          visible: controller.corporateSwitch.value,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  StringsConstant.corporateAccessCode,
                  style: AppTheme.subTitleRegularTextStyle,
                ),
              ),
              SizedBox(height: 10.h),
              TextFormField(
                inputFormatters: [UpperCaseTextFormatter()],
                focusNode: controller.focusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.corporateAccessCodeController,
                keyboardType: TextInputType.text,
                style: AppTheme.inputFieldTextStyle,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                    border: AppTheme.inputFieldBorder,
                    enabledBorder: AppTheme.inputFieldEnabledBorder,
                    focusedBorder: AppTheme.inputFieldFocusBorder,
                    errorBorder: AppTheme.inputFieldEnabledBorder,
                    filled: true,
                    fillColor: AppColors.colorWhite),
                validator: (value) {
                  return ValidationUtil.validateCorporateAccessCode(value!);
                },
              ),
              SizedBox(height: 18.h),
            ],
          ),
        ));
  }

  Widget mobileInputField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            StringsConstant.phone,
            style: AppTheme.subTitleRegularTextStyle,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mobileCodeDropdown(),
            SizedBox(width: 15.w),
            Expanded(
              child: TextFormField(
                readOnly: controller.readOnly.value,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.mobileController,
                keyboardType: TextInputType.phone,
                style: AppTheme.inputFieldTextStyle,
                decoration: InputDecoration(
                    errorMaxLines: 2,
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                    border: AppTheme.inputFieldBorder,
                    enabledBorder: AppTheme.inputFieldEnabledBorder,
                    focusedBorder: AppTheme.inputFieldFocusBorder,
                    errorBorder: AppTheme.inputFieldEnabledBorder,
                    filled: true,
                    fillColor: controller.readOnly.value
                        ? AppColors.colorPorcelain
                        : AppColors.colorWhite),
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
            width: 90.w,
            height: 43.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.colorPrimary,
              ),
              color: controller.readOnly.value
                  ? AppColors.colorPorcelain
                  : AppColors.colorWhite,
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
                              style: AppTheme.regularBlack14spTextStyle),
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
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          StringsConstant.password,
          style: AppTheme.subTitleRegularTextStyle,
        ),
      ),
      SizedBox(height: 10.h),
      Obx(() => SizedBox(
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
                  fillColor: controller.readOnly.value
                      ? AppColors.colorPorcelain
                      : AppColors.colorWhite),
              onChanged: (value) {
                controller.isValidatePass.value =
                    ValidationUtil.isValidatePassword(value)!;
              },
            ),
          )),
      SizedBox(height: 20.h),
      passwordValidationView()
    ]);
  }

  Widget passwordValidationView() {
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

  Widget termsAndConditionView() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6.r),
            color: AppColors.colorBlueChalk),
        child: Row(
          children: [
            Obx(
              () => SizedBox(
                height: 20.h,
                width: 20.w,
                child: Checkbox(
                  value: controller.termAndConditionCheckBox.value,
                  onChanged: (value) {
                    controller.termAndConditionCheckBox.value = value!;
                  },
                  checkColor: AppColors.colorWhite,
                  activeColor: AppColors.colorChineseBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0.r),
                  ),
                  side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(
                        width: 2.0, color: AppColors.colorChineseBlack),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: StringsConstant.termsAndCondition,
                      style: AppTheme.regularColorDarkGreyBlue12spTextStyle),
                  TextSpan(
                      text: StringsConstant.termsOfUse,
                      style: TextStyle(
                          color: AppColors.colorDarkGreyBlue,
                          fontSize: 12.sp,
                          fontFamily: FontsConstant.avenirRegular,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.redirectToWebView(
                              StringsConstant.termsAndConditionUrl);
                        }),
                  TextSpan(
                      text: " and ",
                      style: AppTheme.regularColorDarkGreyBlue12spTextStyle),
                  TextSpan(
                      text: StringsConstant.privacyPolicy,
                      style: TextStyle(
                          color: AppColors.colorDarkGreyBlue,
                          fontSize: 12.sp,
                          fontFamily: FontsConstant.avenirRegular,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          controller.redirectToWebView(
                              StringsConstant.privacyPolicyUrl);
                        }),
                ]),
              ),
            ),
          ],
        ));
  }
}
