import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/mypalns_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class CommunityPlansScreen extends GetView<MyPlansController> {
  const CommunityPlansScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: CommunityCustomAppbar(voidCallback: () => Get.back()),
      body: communityPlansBody(),
    );
  }

  Widget communityPlansBody() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 39.w),
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Text(StringsConstant.premiumMembers,
                        style: AppTheme.titleChineseBlackBoldTextStyle),
                    SizedBox(height: 36.17.h),
                    Row(
                      children: [
                        SvgPicture.asset(ImagesConstant.greenCheck,
                            height: 16.h, width: 16.w),
                        SizedBox(
                          width: 15.38.w,
                        ),
                        SizedBox(
                          width: 317.w,
                          height: 40.h,
                          child: Text(StringsConstant.unlimitedAccess,
                              style: AppTheme.regularBlack14spTextStyle),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        SvgPicture.asset(ImagesConstant.greenCheck,
                            height: 16.h, width: 16.w),
                        SizedBox(
                          width: 15.38.w,
                        ),
                        Text(StringsConstant.responsePsychologist,
                            style: AppTheme.regularBlack14spTextStyle),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        SvgPicture.asset(ImagesConstant.greenCheck,
                            height: 16.h, width: 16.w),
                        SizedBox(
                          width: 15.38.w,
                        ),
                        Text(StringsConstant.mentalStrength,
                            style: AppTheme.regularBlack14spTextStyle),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      children: [
                        SvgPicture.asset(ImagesConstant.greenCheck,
                            height: 16.h, width: 16.w),
                        SizedBox(
                          width: 15.38.w,
                        ),
                        Text(StringsConstant.unlimitedSpace,
                            style: AppTheme.regularBlack14spTextStyle),
                      ],
                    ),
                    SizedBox(height: 46.83.h),
                    communityPlansList(),
                    SizedBox(height: 76.09.h),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.planPurchased);
            },
            child: Container(
              width: 1.sw,
              height: 74.h,
              color: AppColors.colorPrimary,
              child: Center(
                child: Text(
                  StringsConstant.subscribeNow,
                  style: AppTheme.matchParentButtonTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget communityPlansList() {
    return Obx(
      () => ListView.separated(
          itemCount: controller.communityPlansList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return Padding(padding: EdgeInsets.only(top: 15.h));
          },
          itemBuilder: (context, index) {
            return communityPlansItem(
                controller.communityPlansList[index], index);
          }),
    );
  }

  Widget communityPlansItem(TherapyGiftPlan communityPlan, index) {
    return Obx(
      () => Stack(
        clipBehavior: Clip.none,
        children: [
          Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.72.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.25.h),
                  if (communityPlan.discount != 0) ...[
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 84.w,
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.r),
                            ),
                            color: AppColors.colorShamrockGreen),
                        child: Text('Save ${communityPlan.discount}%',
                            style: AppTheme.regularWhite10spTextStyle),
                      ),
                    ),
                  ],
                  Text(
                    "${communityPlan.description}",
                    style: AppTheme.boldChineseBlackColor16spTextStyle,
                  ),
                  SizedBox(height: 9.49.h),
                  Text(
                    "${communityPlan.name}",
                    style: AppTheme.subTitleRegularTextStyle,
                  ),
                  SizedBox(height: 7.h),
                  Text(
                      "${communityPlan.region!.currency!.symbol} ${communityPlan.summary!.base}",
                      style: AppTheme.regularCarbonGrey14spTextStyle),
                  //SizedBox(height: 35.53.h),
                  if (index == controller.selectedPlanIndex.value) ...[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SvgPicture.asset(ImagesConstant.competedLarge,
                          height: 28.h, width: 28.w),
                    ),
                    //SizedBox(height: 12.66.h)
                  ],
                  SizedBox(height: 21.21.h),
                ],
              ),
            ).toContainer(
              //width: 1.sw,
              width: 348.w,
              decoration: BoxDecoration(
                // color: index == controller.selectedPlanIndex.value
                //     ? AppColors.colorWhite
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(14.r)),
                border: Border.all(
                    color: index == controller.selectedPlanIndex.value
                        ? AppColors.colorPrimary
                        : AppColors.colorIron,
                    width: 2.w),
              ),
            ),
            if (index == controller.selectedPlanIndex.value) ...[
              Container(
                height: 8.75.h,
                width: 328.58.w,
                decoration: BoxDecoration(
                    color: Color(0xffBCBCEB),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(14.r),
                        bottomRight: Radius.circular(14.r))),
              ).toAlign(alignment: Alignment.center)
            ]
          ]).toPositioned(top: 10),
          if (communityPlan.badge != null &&
              communityPlan.badge!.isNotEmpty) ...[
            "${communityPlan.badge}"
                .toHeading4(fontFamily: FontsConstant.appRegularFont)
                .toAlign(alignment: Alignment.center)
                .toSymmetricPadding(2.w, 3.h)
                .toContainer(
                    height: 20.75.h,
                    width: 75.22.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(27.r),
                        color: AppColors.colorPrimary))
                .toAlign(alignment: Alignment.topCenter)
                .toPaddingOnly(left: 8.w, right: 8.w),
          ]
        ],
      )
          .toSizedBox(180.h, 1.sw)
          .toAlign(alignment: Alignment.center)
          .onTapWidget(() {
        controller.selectedPlanIndex.value = index;
      }),
    );
  }
}
