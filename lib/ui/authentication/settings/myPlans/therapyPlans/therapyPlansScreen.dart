import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/mypalns_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class TherapyPlansScreen extends GetView<MyPlansController> {
  const TherapyPlansScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: SettingCustomAppbar(voidCallback: () => Get.back()),
      body: Obx(() => therapyPlansBody()),
      //onLoading: showProgress()),
    );
  }

  Widget therapyPlansBody() {
    return SafeArea(
        child: SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Center(
            child: Text(
              StringsConstant.therapyPlan,
              style: AppTheme.titleChineseBlackBold20TextStyle,
            ),
          ),
          SizedBox(
            height: 34.87.h,
          ),
          therapyPlansList(),
          SizedBox(
            height: 96.88.h,
          ),
          Text(
            StringsConstant.exclusiveGst,
            style: AppTheme.subTitle2Regular14spTextStyle,
          ),
          SizedBox(height: 31.37.h),
          SizedBox(
            height: 54.9.h,
            width: 232.25.w,
            child: ElevatedButton(
                style: AppTheme.matchParentButton27Style,
                onPressed: () {
                  Get.toNamed(Routes.planPurchased);
                },
                child: Text(
                  StringsConstant.proceedPayment,
                  style: AppTheme.matchParentButtonTextStyle,
                )),
          ),
          SizedBox(height: 35.56.h),
        ],
      ),
    ));
  }

  Widget therapyPlansList() {
    return ListView.separated(
        itemCount: controller.therapyPlansList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(top: 15.h));
        },
        itemBuilder: (context, index) {
          return therapyPlansItem(controller.therapyPlansList[index], index);
        }).toHorizontalPadding(80.5.w);
  }

  Widget therapyPlansItem(TherapyGiftPlan therapyPlan, index) {
    return Obx(
      () => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Container(
          //width: 1.sw,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                  color: index == controller.selectedPlanIndex.value
                      ? AppColors.colorPrimary
                      : AppColors.colorTitanWhite),
              borderRadius: BorderRadius.all(Radius.circular(14.r)),
              color: AppColors.colorTitanWhite),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 13.h,
              ),
              Center(
                child: Text('${therapyPlan.name}',
                    style: AppTheme.subTitle2Regular14spTextStyle),
              ),
              SizedBox(height: 17.h),
              Text(
                '${therapyPlan.units!.session}  Sessions',
                style: AppTheme.titleChineseBlackBoldTextStyle,
              ),
              Text(
                '${therapyPlan.region!.currency!.symbol}${therapyPlan.summary!.perBase}/- Each',
                style: AppTheme.subTitleRegular20TextStyle,
              ),
              SizedBox(
                height: 17.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (AppUtil.getValidateDays(therapyPlan.time) != 0) ...[
                    Text(
                      "${AppUtil.getValidateDays(therapyPlan.time)} Day Validity",
                      style: AppTheme.subTitle2Regular14spTextStyle,
                    ),
                  ],
                  SizedBox(width: 6.w),
                  if (index == controller.selectedPlanIndex.value) ...[
                    SvgPicture.asset(
                      ImagesConstant.greenCheck,
                      height: 28.h,
                      width: 28.w,
                    )
                  ]
                ],
              ),
              SizedBox(height: 13.25.h),
            ],
          ),
        ),
      ).onTapWidget(() {
        controller.selectedPlanIndex.value = index;
      }),
    );
  }
}
