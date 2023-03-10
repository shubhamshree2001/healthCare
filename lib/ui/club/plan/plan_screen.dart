import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/club/plan/plan_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import '../../../constants/images_constant.dart';
import '../../../constants/strings_constant.dart';
import '../../../theme/dark_theme_app_color.dart';
import '../../../widgets/response_widget_animator.dart';

class PlanScreen extends GetView<PlansController>{
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
      appBar: AppBar(
        backgroundColor: DarkThemeAppColors.colorAppBar,
        elevation: 0,
        leading: IconButton(
          splashRadius: 18,
          icon: ImagesConstant.cross.toSvg(color: DarkThemeAppColors.colorWhite),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => planBody()),
    );
  }

  Widget planBody() {
    return Column(
      children: [
        Column(
          children: [
            20.h.toSizedBoxVertical,
            "Become a premium member to get:"
                .toHeading1(color: DarkThemeAppColors.colorTitle),
            30.h.toSizedBoxVertical,
            if(controller.subscriptionBenefitsType.value == "CHECKLIST") ...[
              subscriptionBenefitsCheckList(),
            ],
            58.h.toSizedBoxVertical,
            ResponseWidgetsAnimator(
              apiCallStatus: controller.planListApiStatus.value,
              loadingWidget: (){
                return showProgress();
              },
              errorWidget: () {
                return const SizedBox();
              },
              successWidget: (){
                return planListView();
              },
            ),
            30.h.toSizedBoxVertical,
          ],
        ).toSingleChildScrollView.toExpanded(),
        Column(
          children: [
            "Restore subscription".toHeading3(color: DarkThemeAppColors.colorTitle,textDecoration: TextDecoration.underline).toTextButton(() { }),
            15.h.toSizedBoxVertical,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: "Your membership will renew automatically. By subscribing you agree to",
                    style: AppTheme.heading3.copyWith(fontFamily: FontsConstant.appRegularFont,color: DarkThemeAppColors.colorSubTitle)
                ),
                TextSpan(
                    text:"Terms of service",
                    style: AppTheme.heading3.copyWith(fontFamily: FontsConstant.appRegularFont,color: DarkThemeAppColors.colorSubTitle,decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //  controller.redirectToWebView(StringsConstant.termsAndConditionUrl);
                      }),
                TextSpan(
                  text: " & ",
                  style: AppTheme.heading3.copyWith(fontFamily: FontsConstant.appRegularFont,color: DarkThemeAppColors.colorSubTitle),
                ),
                TextSpan(
                    text: StringsConstant.privacyPolicy,
                    style: AppTheme.heading3.copyWith(fontFamily: FontsConstant.appRegularFont,color: DarkThemeAppColors.colorSubTitle,decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //controller.redirectToWebView(StringsConstant.privacyPolicyUrl);
                      }),
              ]),
            ).toHorizontalPadding(15.w),
            20.h.toSizedBoxVertical,
            "Subscribe now".toHeading2(color: DarkThemeAppColors.colorBlack,textAlign: TextAlign.center).toSquareButton(() {
              controller.subscribe();
            }).toSizedBoxWidth(1.sw),
            20.h.toSizedBoxVertical,
          ],
        ),
      ],
    ).toHorizontalPadding(33.w);
  }

  Widget subscriptionBenefitsCheckList()
  {
    return  ListView.separated(
      separatorBuilder: (context, index) {
        return Padding(padding: EdgeInsets.only(top: 10.h));
      },
      itemCount: controller.subscriptionCheckList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return subscriptionBenefitsItem(controller.subscriptionCheckList[index]);
      },
    );
  }

  Widget subscriptionBenefitsItem(String item) {
    return Row(
      children: [
        ImagesConstant.greenCheck.toSvg(),
        15.w.toSizedBoxHorizontal,
        item.toHeading3(
            fontFamily: FontsConstant.appRegularFont,
            color: DarkThemeAppColors.colorSubTitle).toExpanded()
      ],
    );
  }

  Widget planListView()
  {
    return ListView.separated(
       itemCount: controller.planList.length,
       shrinkWrap: true,
       physics: const NeverScrollableScrollPhysics(),
       separatorBuilder: (context,index){
        return Padding(padding: EdgeInsets.only(top: 20.h));
       },
      itemBuilder: (context,index){
          return planItem(index);
      },
    );
  }

  Widget planItem(int index){
    return Obx(() => Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds:300),
          padding: EdgeInsets.only(bottom: controller.selectedPlanIndex.value == index?3.h:0),
          decoration: BoxDecoration(
              color: DarkThemeAppColors.colorPrimary,
              // border: Border.all(color: DarkThemeAppColors.colorPrimary,width: 1),
              borderRadius: BorderRadius.circular(14.r)
          ),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFF2E2E2E),
                border: Border.all(color: controller.selectedPlanIndex.value == index?DarkThemeAppColors.colorPrimary:const Color(0xFFD5D5D5),width: 1),
                borderRadius: BorderRadius.circular(14.r)
            ),
            child:Column(
              children: [
                22.h.toSizedBoxVertical,
                "${controller.planList[index].description}".toHeading2(color: DarkThemeAppColors.colorTitle).toAlign(alignment: Alignment.topLeft),
                7.h.toSizedBoxVertical,
                "${controller.planList[index].name}".toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont).toAlign(alignment: Alignment.topLeft),
                5.95.h.toSizedBoxVertical,
                [
                  if(controller.planList[index].discount!=null && controller.planList[index].discount!=0) ...[
                    "₹${controller.planList[index].price}".toHeading2(color: const Color(0xFFFF4646),textDecoration: TextDecoration.lineThrough,fontFamily: FontsConstant.appRegularFont),
                    9.w.toSizedBoxHorizontal,
                  ],
                  "₹${controller.planList[index].summary?.total?.grand}".toHeading2(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont),
                ].toRow(),
                8.34.h.toSizedBoxVertical,
                [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: DarkThemeAppColors.colorMediumGreen,
                        borderRadius: BorderRadius.circular(15.r)
                    ),
                    child: "Save ${controller.planList[index].discount}%".toHeading3(color: DarkThemeAppColors.colorBlack,fontFamily: FontsConstant.appRegularFont),
                  ).toVisibility(controller.planList[index].discount!=null && controller.planList[index].discount!=0?true:false),
                  ImagesConstant.competedLarge.toSvg(width: 30.w,height: 30.h).toAlign(alignment:Alignment.bottomRight).toVisibility(controller.selectedPlanIndex.value==index)
                ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                15.h.toSizedBoxVertical,
              ],
            ).toHorizontalPadding(15.w),
          ),
        ),
        if(controller.planList[index].badge!=null && controller.planList[index].badge!.isNotEmpty) ...[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27.r),
                color: DarkThemeAppColors.colorPrimary),
            child: "Best Value"
                .toHeading4(fontFamily: FontsConstant.appRegularFont)
                .toSymmetricPadding(10.w, 6.h),
          ).toAlign(alignment: Alignment.topCenter).toPositioned(top: -10),
        ]

      ],
    ).onTapWidget(() {
      controller.selectedPlanIndex.value = index;
    }));
  }
}
