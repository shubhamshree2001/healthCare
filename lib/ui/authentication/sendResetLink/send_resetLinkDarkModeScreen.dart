import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/sendResetLink/send_reset_link_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../constants/strings_constant.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/common_widget.dart';

class SendResetLinkDarkModeScreen extends GetView<SendResetLinkController> {
  const SendResetLinkDarkModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBlueMci,
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      body: sendResetLinkScreenBody(),
    );
  }

  Widget sendResetLinkScreenBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 27.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 52.w),
                  child: Text(
                    StringsConstant.sendResetLinkTitle,
                    style: AppTheme.boldChinesewhite21spTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 37.76.h),
                emailInputField(),
              ],
            ),
            matchParentCustomButtonDarkMode(
                () => controller.sendLinkForgotPass()),
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
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                "Send reset link",
                style: AppTheme.boldColorRangoonGreen16sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
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
        SizedBox(height: 10.h),
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
              suffix: InkWell(
                  onTap: () {
                    controller.emailController.text = "";
                  },
                  child: Icon(
                    Icons.close,
                    size: 20,
                  )),
              filled: true,
              fillColor: AppColors.colorTextBox),
          validator: (value) {
            return ValidationUtil.validateEmail(value!);
          },
        ),
      ],
    );
  }
}
