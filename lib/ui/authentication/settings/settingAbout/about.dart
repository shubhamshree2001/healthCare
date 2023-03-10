import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/settingScreen/setting_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class AboutScreen extends GetView<SettingController> {
  const AboutScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: SettingCustomAppbar(voidCallback: () => Get.back()),
      body: aboutBody(),
    );
  }

  Widget aboutBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            InkWell(
              onTap: () {
                controller
                    .redirectToWebView(StringsConstant.termsAndConditionUrl);
              },
              child: Text(
                StringsConstant.termsAndConditionAbout,
                style: AppTheme.underlineTextblackStyle,
              ),
            ),
            SizedBox(height: 26.h),
            InkWell(
              onTap: () {
                controller.redirectToWebView(StringsConstant.privacyPolicyUrl);
              },
              child: Text(
                StringsConstant.privacyPolicy,
                style: AppTheme.underlineTextblackStyle,
              ),
            ),
            SizedBox(height: 26.h),
            InkWell(
              onTap: () {
                controller
                    .redirectToWebView(StringsConstant.communityGuidelinesUrl);
              },
              child: Text(
                StringsConstant.communityGuideLines,
                style: AppTheme.underlineTextblackStyle,
              ),
            ),
            SizedBox(height: 563.h),
            Center(
              child: Text(
                StringsConstant.version,
                style: AppTheme.inputFieldTextStyle,
              ),
            ),
            SizedBox(height: 15.h),
            Center(
              child: Text(
                StringsConstant.copyright,
                style: AppTheme.inputFieldTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
