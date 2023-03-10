import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/settingScreen/setting_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';
import '../../../../constants/strings_constant.dart';
import '../../../../data/models/authModel/country_code_list_response.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReferScreen extends GetView<SettingController> {
  const ReferScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBlueChalk.withOpacity(0.5),
      appBar: CustomAppbar(voidCallback: () => Get.back()),
      body: referBody(),
    );
  }

  Widget referBody() {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.h),
          child: Form(
            key: controller.referFormKey,
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(ImagesConstant.helpIcon,
                        color: Colors.black),
                    Text(StringsConstant.lives,
                        style: AppTheme.titleChineseBlackBold20TextStyle)
                  ],
                ),
                Container(
                    child: Text(StringsConstant.mission,
                        style: AppTheme.subTitleRegularTextStyle)),
                SizedBox(height: 33.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(StringsConstant.referToOrg,
                      style: AppTheme.titleChineseBlackBold20TextStyle),
                ),
                SizedBox(height: 21.h),
                fullOrgNameInputField(),
                SizedBox(height: 30.29.h),
                fullNameInputField(),
                SizedBox(height: 30.29.h),
                emailInputField(),
                SizedBox(height: 30.29.h),
                mobileInputField(),
                SizedBox(height: 30.29.h),
                SizedBox(
                  width: 172.09.w,
                  child: ElevatedButton(
                    style: AppTheme.matchParentButtonStyle,
                    onPressed: () {
                      controller.checkReferUsValidation();
                    },
                    child: Text(
                      StringsConstant.refer,
                      style: AppTheme.matchParentButtonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fullOrgNameInputField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            StringsConstant.org,
            style: AppTheme.subTitleRegularTextStyle,
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          readOnly: controller.readOnly.value,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.orgNameController,
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

  Widget emailInputField() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            StringsConstant.email,
            style: AppTheme.subTitleRegularTextStyle,
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          style: AppTheme.inputFieldTextStyle,
          decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              border: AppTheme.inputFieldBorder,
              enabledBorder: AppTheme.inputFieldEnabledBorder,
              focusedBorder: AppTheme.inputFieldFocusBorder,
              filled: true,
              fillColor: AppColors.colorWhite),
          validator: (value) {
            return ValidationUtil.validateEmail(value!);
          },
        ),
      ],
    );
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
}
