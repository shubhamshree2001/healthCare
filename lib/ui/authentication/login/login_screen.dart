import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import '../../../data/models/authModel/country_code_list_response.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorGhostWhite,
      body: loginBody(),
    );
  }

  Widget loginBody() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 83.h),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 33.sp),
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          StringsConstant.loginTitle,
                          style: AppTheme.titleChineseBlackBoldTextStyle,
                        ),
                      ),
                      SizedBox(height: 23.95.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          StringsConstant.whatYourEmail,
                          style: AppTheme.subTitleRegularTextStyle,
                        ),
                      ),
                      SizedBox(height: 17.h),
                      emailInputField(),
                      SizedBox(height: 17.2.h),
                      matchParentCustomButton(
                          StringsConstant.continueLabel,
                          () => controller.checkLoginValidation(
                              controller.emailController.text)),
                      SizedBox(height: 40.h),
                      orDivider(),
                      SizedBox(height: 40.h),
                      GetPlatform.isAndroid
                          ? socialMediaButton(StringsConstant.googleBtnLabel,
                              ImagesConstant.googleIcon, () {})
                          : socialMediaButton(StringsConstant.appleBtnLabel,
                              ImagesConstant.appleIcon, () {}),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
                width: 210.42,
                height: 160.71,
                child: SvgPicture.asset(ImagesConstant.illustrationSignupImg)),
          )
        ],
      ),
    );
  }

  Widget emailInputField() {
    return SizedBox(
      child: TextFormField(
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
    );
  }

  Widget orDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.colorPrimary,
            thickness: 1.h,
          ),
        ),
        SizedBox(width: 11.w),
        Text(
          StringsConstant.orLabel,
          style: AppTheme.subTitleRegularTextStyle,
        ),
        SizedBox(width: 11.w),
        Expanded(
          child: Divider(
            color: AppColors.colorPrimary,
            thickness: 1.h,
          ),
        )
      ],
    );
  }
}
