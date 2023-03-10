import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:intl/intl.dart';
import '../../../../constants/strings_constant.dart';
import '../../../../data/models/authModel/country_code_list_response.dart';
import 'profile_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
          backgroundColor: AppColors.colorBlueChalk,
          elevation: 0,
          leading: Obx(
            () => controller.isChanged.value == true
                ? IconButton(
                    icon: Icon(Icons.close,
                        color: AppColors.colorBlack, size: 24),
                    onPressed: () => controller.isChanged.value =
                        false, // Get.toNamed(Routes.profile),
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
                      onPressed: () => controller.profileUpdateValidation(),
                      icon: Icon(Icons.check,
                          color: AppColors.colorBlack, size: 24),
                    ),
                  ]
                ])),
          ]),
      body: profileBody(),
    );
  }

  Widget profileBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: controller.profileFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.w),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Stack(
                    children: <Widget>[
                      Obx(() {
                        if (controller.isProfilePicPathSet.value == true) {
                          return CircleAvatar(
                              backgroundColor: AppColors.colorBackgroundScreen,
                              radius: 60.r,
                              backgroundImage: FileImage(
                                  File(controller.profilePicPath.value)));
                        } else {
                          return "${controller.user.value.profile != null ? controller.user.value.profile : ""}"
                              .toNetWorkImage(height: 120.h, width: 120.w);
                        }
                      }),
                      Positioned(
                        bottom: 9,
                        right: 9,
                        child: GestureDetector(
                          child: const Icon(Icons.camera_alt,
                              color: AppColors.colorBlack),
                          onTap: () {
                            openChoosePictureBottomSheet();
                            controller.isChanged.value = true;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 27.h),
                fullNameInputField(),
                SizedBox(height: 19.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    StringsConstant.email,
                    style: AppTheme.subTitleRegularTextStyle,
                  ),
                ),
                SizedBox(height: 10.h),
                emailInputField(),
                SizedBox(height: 19.h),
                mobileInputField(),
                SizedBox(height: 19.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    StringsConstant.dateOfBirth,
                    style: AppTheme.subTitleRegularTextStyle,
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 167.w,
                    height: 51.5.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0XFFA1A1FF).withOpacity(0.5),
                        style: BorderStyle.solid,
                      ),
                      color: AppColors.colorWhite,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Obx(
                            () => Text(
                              controller.dateOfBirth.value,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0XFF294962),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xff111111),
                            size: 38,
                          ),
                          onTap: () {
                            controller.chooseDate();
                            controller.isChanged.value = true;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 19.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    StringsConstant.gender,
                    style: AppTheme.subTitleRegularTextStyle,
                  ),
                ),
                //SizedBox(height: 10.h),
                Obx(
                  () => Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Color(0xffB1B2FC),
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              activeColor: Color(0xffB1B2FC),
                              value: controller.genderList[0],
                              groupValue: controller.selectedGender.value,
                              onChanged: (val) {
                                controller.selectedGender.value = val as String;
                                controller.isChanged.value = true;
                              },
                            ),
                            Text(
                              StringsConstant.male,
                              style: AppTheme.regularBlack14spTextStyle,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(0xffB1B2FC),
                              value: controller.genderList[1],
                              groupValue: controller.selectedGender.value,
                              onChanged: (val) {
                                controller.selectedGender.value = val as String;
                                controller.isChanged.value = true;
                              },
                            ),
                            Text(
                              StringsConstant.female,
                              style: AppTheme.regularBlack14spTextStyle,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(0xffB1B2FC),
                              value: controller.genderList[2],
                              groupValue: controller.selectedGender.value,
                              onChanged: (val) {
                                controller.selectedGender.value = val as String;
                                controller.isChanged.value = true;
                              },
                            ),
                            Text(
                              StringsConstant.nonBinary,
                              style: AppTheme.regularBlack14spTextStyle,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 19.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    StringsConstant.role,
                    style: AppTheme.subTitleRegularTextStyle,
                  ),
                ),
                SizedBox(height: 10.h),
                roleDropdown(),
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
          onChanged: (value) {
            controller.isChanged.value = true;
          },
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
              fillColor: AppColors.colorWhite),
          validator: (value) {
            return ValidationUtil.validateFullName(value!);
          },
        )
      ],
    );
  }

  Widget emailInputField() {
    return SizedBox(
      child: TextFormField(
        readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        style: AppTheme.inputFieldTextStyle,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
            border: AppTheme.inputFieldUnabledBorder,
            enabledBorder: AppTheme.inputFieldUnabledBorder,
            focusedBorder: AppTheme.inputFieldUnabledFocusBorder,
            filled: true,
            fillColor: AppColors.colorDesertStorm),
        validator: (value) {
          return ValidationUtil.validateEmail(value!);
        },
      ),
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
          children: [
            mobileCodeDropdown(),
            SizedBox(width: 15.w),
            Expanded(
              child: TextFormField(
                readOnly: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.mobileController,
                keyboardType: TextInputType.phone,
                style: AppTheme.inputFieldTextStyle,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                    border: AppTheme.inputFieldUnabledBorder,
                    enabledBorder: AppTheme.inputFieldUnabledBorder,
                    focusedBorder: AppTheme.inputFieldUnabledFocusBorder,
                    filled: true,
                    fillColor: AppColors.colorDesertStorm),
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
    return Obx(() => Container(
          width: 90.w,
          height: 43.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.colorFrenchGrey,
            ),
            color: AppColors.colorDesertStorm,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CountryCodeItem>(
              value: controller.selectedCountryCode.value,
              // isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 20,
              onChanged: (CountryCodeItem? stateModel) {
                controller.selectedCountryCode.value = stateModel!;
              },
              /*decoration: InputDecoration(
                border: AppTheme.inputFieldBorder,
                focusedBorder: AppTheme.inputFieldBorder,
                contentPadding:
                    const EdgeInsets.only(top: 10, left: 10, bottom: 10),
              ),*/
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
        ));
  }

  Widget roleDropdown() {
    return Obx(() => Container(
          width: 1.sw,
          height: 47.7.h,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.colorPrimary,
            ),
            color: AppColors.colorWhite,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(StringsConstant.selectOption,
                  style: AppTheme.regularBlack14spTextStyle),
              value: controller.selectedRoleDrowpdown.value,
              // isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 20,
              onChanged: (newValue) {
                controller.selectedRoleDrowpdown.value = newValue!;
                //controller.isChanged.value = true;
              },

              items: controller.roleDropdownItem.map((map) {
                return DropdownMenuItem<String>(
                  value: map,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Text(map, style: AppTheme.regularBlack14spTextStyle),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }

  openChoosePictureBottomSheet() {
    return Get.bottomSheet(
      Container(
        height: 200.h,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    'Profile photo',
                    style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 180.0),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: Get.context!,
                          builder: (ctx) => AlertDialog(
                            backgroundColor: Color(0XFFFFFFFF),
                            content: const Text(
                              "Are you sure you want to remove your picture?",
                              style: TextStyle(color: Color(0XFF000000)),
                            ),
                            actions: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 46.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 37.h,
                                      width: 89.5.w,
                                      child: ElevatedButton(
                                        style: AppTheme.dialogueYesButtonStyle,
                                        child: Text('No',
                                            style:
                                                TextStyle(color: Colors.black)),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14.03.w,
                                    ),
                                    SizedBox(
                                      height: 37.h,
                                      width: 89.5.w,
                                      child: ElevatedButton(
                                        style: AppTheme.dialogueYesButtonStyle,
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                            color: Color(0XFF111111),
                                            fontSize: 14,
                                          ),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.delete, color: Color(0xff111111)),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.getImage(ImageSource.camera);
                      },
                      icon: Icon(Icons.camera_alt_rounded),
                      iconSize: 30,
                      color: Color(0xff111111),
                    ),
                    Text("Camera",
                        style: AppTheme.boldChineseBlackColor16spTextStyle)
                  ],
                ),
                SizedBox(width: 60.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.getImage(ImageSource.gallery);
                      },
                      icon: Icon(Icons.image),
                      color: Color(0xff111111),
                      iconSize: 30,
                    ),
                    Text("Gallery",
                        style: AppTheme.boldChineseBlackColor16spTextStyle)
                  ],
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
    );
  }
}




// ClipRRect(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(100.r)),
//                           //radius: 90.r,
//                           child: controller.selectedImagePath.value != null
//                               ? Image.file(
//                                   File(controller.selectedImagePath.value),
//                                   height: 100.h,
//                                   width: 100.w,
//                                   fit: BoxFit.cover,
//                                 )
//                               : SvgPicture.asset(ImagesConstant.aboutIcon),
//                         ),