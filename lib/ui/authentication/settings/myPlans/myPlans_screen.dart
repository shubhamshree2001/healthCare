import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindpeers_mobile_flutter/appUtils/validation_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/mypalns_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/myPlans/therapyPlans/therapyPlansScreen.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class MyPlansScreen extends GetView<MyPlansController> {
  const MyPlansScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBlueChalk.withOpacity(0.5),
      body: myPlansBody(),
    );
  }

  Widget myPlansBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 58.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  StringsConstant.activePlan,
                  style: AppTheme.titleChineseBlackBold20TextStyle,
                ),
              ),
              SizedBox(height: 36.15.h),
              Center(
                child: SvgPicture.asset(
                  ImagesConstant.ventoutEmpty,
                  height: 179.35.h,
                  width: 137.56.w,
                ),
              ),
              SizedBox(height: 15.5.h),
              Text(
                StringsConstant.startWithPlan,
                style: AppTheme.boldChineseBlackColor16spTextStyle,
              ),
              SizedBox(height: 38.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      //height: 116.h,
                      // width: 158.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: 33.h,
                              width: 115.w,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Text(
                                    StringsConstant.communityPremium,
                                    style:
                                        AppTheme.subTitle2Regular14spTextStyle,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 21.h),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SvgPicture.asset(
                                    ImagesConstant.settingCommunity,
                                    height: 48.h,
                                    width: 48.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.communityPlans);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        StringsConstant.subscribeNow,
                                        style: AppTheme.boldBlack10spTextStyle,
                                      ),
                                      SvgPicture.asset(
                                          ImagesConstant.rightArrow)
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                      //height: 116.h,
                      //width: 158.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Text(
                                  StringsConstant.therapyCredits,
                                  style: AppTheme.subTitle2Regular14spTextStyle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                children: [
                                  Text("0 ",
                                      style: AppTheme
                                          .boldChineseBlackColor16spTextStyle),
                                  Text(
                                    "Credits",
                                    style: AppTheme.regularBlack10spTextStyle,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SvgPicture.asset(
                                    ImagesConstant.settingTherapy,
                                    height: 38.h,
                                    width: 38.w,
                                  ),
                                ),
                                SizedBox(
                                  width: 22.w,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.therapyPlans);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        StringsConstant.buyCredits,
                                        style: AppTheme.boldBlack10spTextStyle,
                                      ),
                                      SvgPicture.asset(
                                          ImagesConstant.rightArrow)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 31.21.h,
              ),
              Text(
                StringsConstant.orLabel,
                style: AppTheme.titleChineseBlackBold20TextStyle,
              ),
              SizedBox(height: 25.71.h),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  StringsConstant.giftcode,
                  style: AppTheme.subTitleRegularTextStyle,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 210.w,
                      height: 48.h,
                      child: Form(
                        key: controller.giftCouponFormKey,
                        child: TextFormField(
                          readOnly: controller.readOnly.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: controller.giftCardController,
                          keyboardType: TextInputType.text,
                          style: AppTheme.inputFieldTextStyle,
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 10.w),
                              border: AppTheme.inputFieldBorder,
                              enabledBorder: AppTheme.inputFieldEnabledBorder,
                              focusedBorder: AppTheme.inputFieldFocusBorder,
                              errorBorder: AppTheme.inputFieldEnabledBorder,
                              filled: true,
                              fillColor: controller.readOnly.value
                                  ? AppColors.colorPorcelain
                                  : AppColors.colorWhite),
                          validator: (value) {
                            return ValidationUtil.validateGiftCouponCode(
                                value!);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 14.68.w),
                  SizedBox(
                    height: 47.71.h,
                    width: 123.86.w,
                    child: ElevatedButton(
                        style: AppTheme.matchParentButtonStyle,
                        onPressed: () {
                          //controller.sendRedeemCoupon();
                          controller.checkGiftVouponValidation();
                          //Get.back();
                          //openRedeemedGiftDialogueBox();
                        },
                        child: Text(
                          StringsConstant.redeem,
                          style: AppTheme.matchParentButtonTextStyle,
                        )),
                  ),
                ],
              ),
              if (controller.pastPlansList.isNotEmpty) ...[
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.pastPlans);
                  },
                  child: Text("View Past Plans",
                      style: AppTheme.underlineTextblackStyle),
                ),
              ]
            ],
          ),
        ),
      ),
    );
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
