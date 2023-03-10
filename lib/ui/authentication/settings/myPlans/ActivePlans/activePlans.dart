import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/listMyPlans_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/mypalns_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/pastPlans/past_plans.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../myPlans_screen.dart';

class ActivePlansScreen extends GetView<MyPlansController> {
  const ActivePlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: SettingCustomAppbar(voidCallback: () => Get.back()),
        body: Obx(() {
          if (controller.isLoader.value) {
            return showProgress().toCenter();
          } else if (controller.isSuccess.value) {
            return activePlansBody();
          } else {
            return const MyPlansScreen();
          }
        }));
  }

  Widget activePlansBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      StringsConstant.activePlan,
                      style: AppTheme.titleChineseBlackBold20TextStyle,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        ImagesConstant.giftIcon,
                        height: 48.h,
                        width: 48.w,
                      ),
                      TextButton(
                        onPressed: () {
                          openRedeemAGiftBottomSheet();
                        },
                        child: Text(StringsConstant.gotAGift,
                            style: AppTheme.underlineTextblackStyle),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 31.h),
              summaryCardList(),
              SizedBox(height: 50.h),
              planList(),
              SizedBox(height: 20.h),
              if (controller.pastPlansList.isNotEmpty) ...[
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.pastPlans);
                    },
                    child: Text("View Past Plans",
                        style: AppTheme.underlineTextblackStyle))
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget summaryCardList() {
    return SizedBox(
      width: 1.sw,
      height: 116.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.summaryCardTypeList.length,
          separatorBuilder: (context, index) {
            return Padding(padding: EdgeInsets.only(left: 38.w));
          },
          itemBuilder: (context, index) {
            return summaryCardItem(controller.summaryCardTypeList[index]);
          }),
    );
  }

  Widget summaryCardItem(SummaryCard summaryCard) {
    return Container(
      width: 158.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.colorBlueShade),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 10.h),
              Text(
                "${summaryCard.heading}",
                style: AppTheme.subTitle2Regular14spTextStyle,
              )
                  .toSizedBoxWidth(103.w)
                  .toPaddingOnly(left: 10.w)
                  .toAlign(alignment: Alignment.topLeft),
              SizedBox(height: 7.h),
              if (summaryCard.cardType == "SUBSCRIPTON_CARD_TYPE_1") ...[
                if (summaryCard.subHeading!.isNotEmpty &&
                    summaryCard.subHeading != null) ...[
                  Text("${summaryCard.subHeading}",
                          style: AppTheme.boldRed10spTextStyle)
                      .toAlign(alignment: Alignment.topLeft)
                      .toPaddingOnly(left: 10.w),
                ],
                // if (summaryCard.warning!.text!.isNotEmpty &&
                //     summaryCard.warning!.text != null) ...[
                //   Text("${summaryCard.warning!.text}",
                //           style: AppTheme.boldRed10spTextStyle)
                //       .toAlign(alignment: Alignment.topLeft)
                //       .toPaddingOnly(left: 10.w),
                // ],
              ] else ...[
                // if (summaryCard.credits!.activeCredits != null &&
                //     summaryCard.credits!.expiredCredits != null &&
                //     summaryCard.subHeading!.isNotEmpty) ...[
                Text("${summaryCard.credits!.activeCredits} ${summaryCard.subHeading} ${summaryCard.credits!.totalCredits}",
                        style: AppTheme.boldBlack10spnormalTextStyle)
                    .toPaddingOnly(left: 10.w)
                    .toAlign(alignment: Alignment.topLeft),
                //],
                // if (summaryCard.warning!.text!.isNotEmpty &&
                //     summaryCard.warning!.text != null) ...[
                //   Text("${summaryCard.warning!.text}",
                //           style: AppTheme.boldBlack10spnormalTextStyle)
                //       .toPaddingOnly(left: 10.w)
                //       .toAlign(alignment: Alignment.topLeft),
                // ]
              ]
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.network(
                  summaryCard.icon,
                  height: 48.h,
                  width: 48.w,
                ),
              ),
              if (summaryCard.cardType == "CREDITS_CARD_TYPE_1")
                if (summaryCard.cta!.text != null &&
                    summaryCard.cta!.text.isNotEmpty) ...[
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.therapyPlans);
                      //Get.toNamed(Routes.communityPlans);
                    },
                    child: Row(
                      children: [
                        Text(
                          "${summaryCard.cta!.text}",
                          style: AppTheme.boldBlack10spTextStyle,
                        ),
                        SvgPicture.asset(ImagesConstant.rightArrow)
                      ],
                    ),
                  ),
                ] else ...[
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.communityPlans);
                      //Get.toNamed(Routes.communityPlans);
                    },
                    child: Row(
                      children: [
                        Text(
                          "${summaryCard.cta!.text}",
                          style: AppTheme.boldBlack10spTextStyle,
                        ),
                        SvgPicture.asset(ImagesConstant.rightArrow)
                      ],
                    ),
                  ),
                ]
            ],
          ).toAlign(alignment: Alignment.bottomCenter),
        ],
      ),
    );
  }

  Widget planList() {
    return ListView.separated(
        itemCount: controller.plansList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(top: 15.h));
        },
        itemBuilder: (context, index) {
          return planItem(controller.plansList[index]);
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

  openRedeemAGiftBottomSheet() {
    Get.bottomSheet(
        [
          32.h.toSizedBoxVertical,
          [
            ImagesConstant.giftRedeemImage.toSvg(height: 48.h, width: 48.w),
            14.w.toSizedBoxHorizontal,
            "Redeem a gift".toHeading1(),
          ].toRow(),
          30.h.toSizedBoxVertical,
          toTextFormField(
            controller: controller.giftCardController,
            validator: (value) {
              return ValidationUtil.validateGiftCouponCode(value!);
            },
          ).toForm(globalKey: controller.giftCouponFormKey),
          22.h.toSizedBoxVertical,
          "Redeem"
              .toHeading2(fontFamily: FontsConstant.appRegularFont)
              .toSquareButtonMatchParent(() {
            controller.checkGiftVouponValidation();
            //controller.sendRedeemCoupon();
            //Get.back();
            //openRedeemedGiftDialogueBox();
          }),
          40.h.toSizedBoxVertical,
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .toHorizontalPadding(33.w)
            .toSingleChildScrollView,
        //.toSizedBoxHeight(0.4.sh),
        backgroundColor: AppColors.colorBlueChalk,
        isDismissible: true,
        enableDrag: true,
        persistent: false,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))));
  }

  openRedeemedGiftDialogueBox() {
    return showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color(0XFFE9E9FF),
        content: SizedBox(
          height: 244.h,
          width: 1.sw,
          child: Column(
            children: [
              SizedBox(height: 23.h),
              SvgPicture.asset(
                ImagesConstant.competedLarge,
                height: 90.h,
                width: 90.w,
              ),
              SizedBox(height: 16.h),
              Text(
                "Credits added to your account",
                style: AppTheme.boldChineseBlackColor16spTextStyle,
              ),
              SizedBox(height: 19.5.h),
              SizedBox(
                height: 53.15.h,
                width: 185.5.w,
                child: ElevatedButton(
                  style: AppTheme.dialogueYesButtonStyle,
                  child: Text(
                    'Continue',
                    style: AppTheme.subTitleRegularTextStyle,
                  ),
                  onPressed: () {
                    //controller.checkGiftVouponValidation();
                    Get.back();
                    //Get.toNamed(Routes.activePlans);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
