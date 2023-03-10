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

class OtpScreen extends GetView<OtpController>
{
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorGhostWhite,
      appBar: CustomAppbar(voidCallback:()=>Get.back()),
      body: otpScreenBody(),
    );
  }

  Widget otpScreenBody()
  {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h,vertical: 27.h),
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
                      style: AppTheme.titleChineseBlackBoldTextStyle,
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
                          style: AppTheme.regularColorRangoonGreen16sp,
                        ),
                        SizedBox(width: 5.w),
                        Obx(() => Text(
                          "${controller.email}",
                          style: AppTheme.boldColorRangoonGreen16sp,
                        )),
                      ],
                    ),
                  ),

                  SizedBox(height: 35.h),
                  SizedBox(
                    height: 41.h,
                    width: 1.sw,
                    child: OTPTextField(
                      fieldWidth: 41.w,
                      length: 6,
                      spaceBetween: 15,
                      fieldStyle: FieldStyle.box,
                      keyboardType: TextInputType.number,
                      textFieldAlignment: MainAxisAlignment.center,
                      outlineBorderRadius: 8.r,
                      style: AppTheme.inputFieldTextStyle,
                      otpFieldStyle: OtpFieldStyle(
                        backgroundColor: AppColors.colorWhite,
                        borderColor: AppColors.colorPrimary,
                        focusBorderColor: AppColors.colorPrimary,
                        enabledBorderColor:AppColors.colorPrimary,
                        disabledBorderColor: AppColors.colorPrimary,
                      ),
                      onChanged: (value){},
                      onCompleted: (value){
                        controller.otp.value=value;
                      },
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Row(
                    children: [
                      Text(
                        StringsConstant.didNotReceiveCode,
                        style: AppTheme.regularColorRangoonGreen16sp,
                      ),
                      SizedBox(width: 3.w),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            StringsConstant.resendCode,
                            style: AppTheme.underlineTextStyle,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            matchParentCustomButton(StringsConstant.verify,()=>controller.checkOtpValidation()),
          ],
        ),
      ),
    );
  }

}