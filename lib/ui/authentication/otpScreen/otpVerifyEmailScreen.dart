import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/otpScreen/otp_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../../constants/strings_constant.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/common_widget.dart';

class OtpEmailScreen extends GetView<OtpController> {
  const OtpEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBlueMci,
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      body: otpScreenBody(),
    );
  }

  Widget otpScreenBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 27.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      StringsConstant.otpTitle,
                      style: AppTheme.boldChinesewhite21spTextStyle,
                    ),
                  ),
                  SizedBox(height: 19.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          StringsConstant.codeSentTo,
                          style: AppTheme.white16sp,
                        ),
                        SizedBox(width: 5.w),
                        Obx(() => Text(
                              "${controller.email}",
                              style: AppTheme.white16sp,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 35.h),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Color(0xff16A9B1),
                  //         offset: Offset(
                  //           0.0,
                  //           1.0,
                  //         ),
                  //         blurRadius: 0.0,
                  //         spreadRadius: 0.0,
                  //       ),
                  //     ],
                  //   ),
                  //   child: SizedBox(
                  //     height: 41.h,
                  //     width: 41.w,
                  //     child: TextFormField(
                  //       //readOnly: controller.readOnly.value,
                  //       autovalidateMode: AutovalidateMode.onUserInteraction,
                  //       //controller: controller.mobileController,
                  //       keyboardType: TextInputType.phone,
                  //       style: AppTheme.inputFieldTextStyle,
                  //       decoration: InputDecoration(
                  //           errorMaxLines: 2,
                  //           isDense: true,
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 12.h, horizontal: 10.w),
                  //           border: AppTheme.inputFieldDarkModeBorder,
                  //           //enabledBorder: AppTheme.inputFieldEnabledBorder,
                  //           focusedBorder:
                  //               AppTheme.textFieldFocusedBottomBorder,
                  //           errorBorder: AppTheme.textFieldErrorBottomBorder,
                  //           filled: true,
                  //           fillColor //: controller.readOnly.value
                  //               //     ? AppColors.colorTextBox
                  //               : AppColors.colorTextBox),
                  //       // validator: (value) {
                  //       //   return ValidationUtil.validateMobileNo(value!);
                  //       //},
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 41.h,
                    width: 1.sw,
                    child: OTPTextField(
                      fieldWidth: 41.w,
                      length: 6,
                      spaceBetween: 18,
                      fieldStyle: FieldStyle.box,
                      keyboardType: TextInputType.number,
                      textFieldAlignment: MainAxisAlignment.center,
                      outlineBorderRadius: 8.r,
                      style: AppTheme.inputFieldTextStyle,
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: AppColors.colorDarkBackgroundScreen,
                        borderColor: AppColors.colorPrimaryDark,
                        focusBorderColor: AppColors.colorPrimaryDark,
                        enabledBorderColor: AppColors.colorPrimaryDark,
                        disabledBorderColor: AppColors.colorPrimary,
                      ),
                      onChanged: (value) {},
                      onCompleted: (value) {
                        controller.otp.value = value;
                      },
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      Text(
                        StringsConstant.didNotReceiveCode,
                        style: AppTheme.white16sp,
                      ),
                      SizedBox(width: 3.w),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            StringsConstant.resendCode,
                            style: AppTheme.underlinePrimaryTextStyle,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            // matchParentCustomButton(
            //     StringsConstant.verify, () => controller.checkOtpValidation()),
            matchParentCustomButtonDarkMode(
                () => controller.checkOtpValidation()),
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
                "Verify",
                style: AppTheme.boldColorRangoonGreen16sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
