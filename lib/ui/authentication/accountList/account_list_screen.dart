import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/account_list_response.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/accountList/account_list_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../appUtils/validation_util.dart';

class AccountListScreen extends GetView<AccountListController> {
  const AccountListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorGhostWhite,
      appBar: CustomAppbar(voidCallback: () => Get.back()),
      body: accountListBody(),
    );
  }

  Widget accountListBody() {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 27.h),
          Center(
            child: Text(
              StringsConstant.chooseYourAccount,
              style: AppTheme.titleChineseBlackBoldTextStyle,
            ),
          ),
          SizedBox(height: 37.h),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: accountList()),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                roundedButtonRightIcon(
                    StringsConstant.useDiffAccount,
                    ImagesConstant.changeIcon,
                    () => Get.offAllNamed(Routes.initial)),
                SizedBox(height: 24.h),
                roundedButtonRightIcon(
                    controller.isIndividualAccount
                        ? StringsConstant.joinWthOrg
                        : StringsConstant.addAccount,
                    ImagesConstant.addAccountIcon,
                    () => controller.redirectToSignUpScreen()),
                SizedBox(height: 30.h),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget accountList() {
    return Obx(() => ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(top: 15.h));
        },
        itemBuilder: (context, index) {
          return accountItem(controller.accountList[index]);
        }));
  }

  Widget accountItem(AccountItem accountItem) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      shadowColor: const Color(0x01013133),
      color: AppColors.colorWhite,
      child: InkWell(
        onTap: () {
          controller.passwordController.text = "";
          openLoginBottomSheet(accountItem);
        },
        child: Column(
          children: [
            Container(
              width: 1.sw,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 5.5.h, horizontal: 10.w),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r)),
                  color: AppColors.colorPrimary),
              child: Text(
                "${accountItem.orgName}",
                style: AppTheme.subTitle2Regular14spTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  SizedBox(
                    height: 56.h,
                    width: 56.w,
                    child: CircleAvatar(
                      backgroundColor: accountItem.logo != null &&
                              accountItem.logo!.isNotEmpty
                          ? AppColors.colorPorcelain
                          : AppColors.colorJeansBlue,
                      child: accountItem.logo != null &&
                              accountItem.logo!.isNotEmpty
                          ? Image.network(accountItem.logo!)
                          : Text(
                              accountItem.userEmail![0].toUpperCase(),
                              style: AppTheme.titleChineseBlackBoldTextStyle,
                            ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${accountItem.userName}",
                          style: AppTheme.boldChineseBlackColor16spTextStyle,
                        ),
                        Text(
                          "${accountItem.userEmail}",
                          style: AppTheme.regularCarbonGrey14spTextStyle,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 12.h)
          ],
        ),
      ),
    );
  }

  openLoginBottomSheet(AccountItem accountItem) {
    controller.isShowPasswordError.value = false;

    return Get.bottomSheet(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Form(
            key: controller.loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  SizedBox(
                    height: 80.h,
                    width: 80.w,
                    child: CircleAvatar(
                      backgroundColor: accountItem.logo != null &&
                              accountItem.logo!.isNotEmpty
                          ? AppColors.colorPorcelain
                          : AppColors.colorJeansBlue,
                      child: accountItem.logo != null &&
                              accountItem.logo!.isNotEmpty
                          ? Image.network(accountItem.logo!)
                          : Text(
                              accountItem.userEmail![0].toUpperCase(),
                              style: AppTheme.boldChineseBlack30spTextStyle,
                            ),
                    ),
                  ),
                  SizedBox(height: 17.h),
                  Row(
                    children: [
                      Text(
                        StringsConstant.password,
                        style: AppTheme.subTitleRegularTextStyle,
                      ),
                      SizedBox(width: 3.w),
                      TextButton(
                          onPressed: () {
                            Get.back();
                            Get.toNamed(Routes.sendResetLink,
                                arguments: accountItem.userEmail);
                          },
                          child: Text(
                            "(${StringsConstant.forgot}?)",
                            style: AppTheme.underlineTextStyle,
                          ))
                    ],
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(child: passwordInputField()),
                  SizedBox(height: 35.h),
                  matchParentCustomButton(
                      StringsConstant.login,
                      () => controller
                          .checkLoginValidation(accountItem.userEmail!)),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false,
        persistent: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))));
  }

  Widget passwordInputField() {
    return Obx(() => SizedBox(
          height: !controller.isShowPasswordError.value ? 48.h : 56,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller.passwordController,
            keyboardType: TextInputType.emailAddress,
            obscureText: controller.isObscureText.value,
            style: AppTheme.inputFieldTextStyle,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  splashRadius: 20,
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
            validator: (value) {
              return ValidationUtil.validatePassword(value!);
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                controller.isShowPasswordError.value = false;
              } else {
                controller.isShowPasswordError.value = true;
              }
            },
          ),
        ));
  }
}
