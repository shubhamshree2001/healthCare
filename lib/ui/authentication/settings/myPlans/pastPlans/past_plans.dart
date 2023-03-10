import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/listMyPlans_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/mypalns_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class PastPlansScreen extends GetView<MyPlansController> {
  const PastPlansScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: SettingCustomAppbar(voidCallback: () => Get.back()),
      body: pastPlansBody(),
    );
  }

  Widget pastPlansBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  StringsConstant.pastPlans,
                  style: AppTheme.titleChineseBlackBold20TextStyle,
                ),
              ),
              SizedBox(height: 43.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 116.h,
                      // width: 158.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.colorBlueShade),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  "${controller.credits.value.usedCredits?.toInt()}",
                                  style: AppTheme.boldChineseBlack30spTextStyle,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Align(
                              alignment: Alignment.center,
                              child: Text("Used Credits",
                                  style: AppTheme.regularBlack14spTextStyle),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  Expanded(
                    child: Container(
                      height: 116.h,
                      // width: 158.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: AppColors.colorBlueShade),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  "${controller.credits.value.expiredCredits?.toInt()}",
                                  style: AppTheme.boldChineseBlack30spTextStyle,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Align(
                              alignment: Alignment.center,
                              child: Text("Expired Credits",
                                  style: AppTheme.regularBlack14spTextStyle),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 51.79.h),
              planList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget planList() {
    return ListView.separated(
        itemCount: controller.pastPlansList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(top: 15.h));
        },
        itemBuilder: (context, index) {
          return planItem(controller.pastPlansList[index]);
        });
  }

  Widget planItem(Plan plan) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      shadowColor: const Color(0x01013133),
      color: AppColors.colorTitanWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.5.w),
        child: Column(
          children: [
            SizedBox(height: 15.94.h),
            Container(
                    // alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 34.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(4.r)),
                        border: Border.all(color: AppColors.colorPrimary),
                        color: AppColors.colorFog),
                    child: plan.heading.toHeading2(textAlign: TextAlign.center))
                .toAlign(alignment: Alignment.topLeft),
            SizedBox(height: 12.6.h),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                  "${plan.name} ${plan.totalCredits != 0 ? "(${plan.totalCredits} credits)" : ""}",
                  style: AppTheme.regularColorRangoonGreen16sp),
            ),
            SizedBox(height: 5.9.h),
            Row(
              children: [
                Text(StringsConstant.purchasedOn,
                    style: AppTheme.regularColorSmokeyGrey12spTextStyle),
                Text(
                  "${AppUtil.convertTimeStampToDateFormat(plan.purchasedOn, format: AppUtil.dateTimeDDMMMMYYYY)}",
                  style: AppTheme.regularColorSmokeyGrey12spTextStyle,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Text(StringsConstant.validTill,
                    style: AppTheme.regularColorSmokeyGrey12spTextStyle),
                Text(
                  "${AppUtil.convertTimeStampToDateFormat(plan.validTill, format: AppUtil.dateTimeDDMMMMYYYY)}",
                  style: AppTheme.regularColorSmokeyGrey12spTextStyle,
                ),
              ],
            ),
            SizedBox(height: 16.1.h),
            if (plan.buyAgainOption != null && plan.buyAgainOption == 1) ...[
              Text(StringsConstant.buyAgain, style: AppTheme.underlineBlack14sp)
                  .onTapWidget(() {})
            ],
            SizedBox(height: 17.43.h),
          ],
        ),
      ),
    );
  }
}
