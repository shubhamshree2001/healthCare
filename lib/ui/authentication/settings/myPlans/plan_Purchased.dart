import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/mypalns_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class PlanPurchasedScreen extends GetView<MyPlansController> {
  const PlanPurchasedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: SettingCustomAppbar(voidCallback: () => Get.back()),
      body: planPurchasedBody(),
    );
  }

  Widget planPurchasedBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              shadowColor: const Color(0x01013133),
              child: Container(
                width: 1.sw,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  shape: BoxShape.rectangle,
                  color: AppColors.colorWhite,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    children: [
                      SizedBox(height: 22.h),
                      SvgPicture.asset(ImagesConstant.purchasedTick,
                          height: 48.h, width: 48.w),
                      SizedBox(width: 30.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringsConstant.planPurchased,
                            style: AppTheme.titleChineseBlackBold20TextStyle,
                          ),
                          SizedBox(
                            width: 211.w,
                            child: Text(
                              StringsConstant.moreDetails,
                              style: AppTheme.regularBlack14spTextStyle,
                            ),
                          ),
                          SizedBox(height: 20.14.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 41.86.h),
            Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              shadowColor: const Color(0x01013133),
              child: Container(
                width: 1.sw,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.r)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black,
                  //   ),
                  // ],
                  shape: BoxShape.rectangle,
                  color: AppColors.colorWhite,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      Text(
                        StringsConstant.bookSession,
                        style: AppTheme.regularBlack14spTextStyle,
                      ),
                      SizedBox(height: 20.14.h),
                      ElevatedButton(
                        style: AppTheme.matchParentButtonStyle,
                        onPressed: () {
                          Get.toNamed("");
                        },
                        child: Text(
                          StringsConstant.bookASession,
                          style: AppTheme.matchParentButtonTextStyle,
                        ),
                      ),
                      SizedBox(height: 23.33.h)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
