import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/signup/signup_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyDarkModeScreen extends GetView<SignupController> {
  const PrivacyPolicyDarkModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomDarkCloseAppbar(voidCallback: () => openplayStoreDialogueBox()),
      backgroundColor: AppColors.colorBlueMci,
      body: Stack(
        children: [
          //matchParentCustomButtonDarkMode(),
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: "https://mindpeers.co/privacy-policy",
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 111.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: AppColors.colorTextBox,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 24.h, bottom: 24.h, left: 40.w, right: 40.w),
                child: matchParentCustomButtonDarkMode(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget matchParentCustomButtonDarkMode() {
    return SizedBox(
        //width: 1.sw,
        height: 61.h,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.emailOtpScreen);
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
                  blurRadius: 0.5,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                "I accept",
                style: AppTheme.boldColorRangoonGreen16sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }

  openplayStoreDialogueBox() {
    return showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.colorTextBox,
        content: SizedBox(
          height: 245.h,
          //width: 348.w,
          child: Column(
            children: [
              Text(
                "Do you want to create your account?",
                style: AppTheme.text16blackStyle,
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 11.h),
              Text(
                "Your data is subject to the highest confidentiality, By accepting privacy policy you can create your account with us.",
                style: AppTheme.regularWhite10spTextStyle,
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  child: Text(
                    'Go Back',
                    style: AppTheme.underlineTextwhiteStyle,
                  ),
                  onTap: () {
                    Get.toNamed(Routes.welcomeScreen);
                  },
                ),
                SizedBox(
                  width: 14.03.w,
                ),
                CustomButtonDarkMode(() {
                  Get.toNamed(Routes.privacyPolicyScreen);
                }),
                // SizedBox(
                //   height: 37.h,
                //   width: 105.w,
                //   child: ElevatedButton(
                //     style: AppTheme.dialogueYesButtonStyle,
                //     child: Text(
                //       "Yes",
                //       style: TextStyle(
                //         color: Color(0XFF111111),
                //         //fontSize: 15,
                //       ),
                //     ),
                //     onPressed: () {
                //       //StoreRedirect.redirect(androidAppId: "", iOSAppId: '');
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 27.5.h),
        ],
      ),
    );
  }

  Widget CustomButtonDarkMode(VoidCallback voidCallback) {
    return SizedBox(
        width: 158.w,
        height: 48.h,
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
                "Continue",
                style: AppTheme.boldColorRangoonGreen16sp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
