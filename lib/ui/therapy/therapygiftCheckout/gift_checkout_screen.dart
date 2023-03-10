import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapygiftCheckout/gift_therpy_checkout_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../widgets/common_widget.dart';

class GiftCheckoutScreen extends GetView<GiftTherapyCheckoutController>
{
  const GiftCheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
         return onWillPop(context);
        },
      child: Scaffold(
        backgroundColor: AppColors.colorBackgroundScreen,
        appBar: CustomAppbar(voidCallback: (){
          onWillPop(context);
        }
        ),
        body: controller.obx((state) => Obx(() => giftCheckoutScreenBody())),
      ),
    );
  }

  giftCheckoutScreenBody()
  {
    return [
      [
        75.h.toSizedBoxVertical,
        StringsConstant.paymentSummary.toHeading1().toHorizontalPadding(33.w),
        29.46.h.toSizedBoxVertical,
        [
          17.88.h.toSizedBoxVertical,
          "1 X ${controller.therapyGiftPlan.value.name} (${controller.therapyGiftPlan.value.units?.session} Credits)".toHeading2().toHorizontalPadding(24.w),
          if(controller.therapyGiftPlan.value.summary?.main?.rate!=null && controller.therapyGiftPlan.value.summary?.main?.rate!=0 && controller.therapyGiftPlan.value.summary?.main?.value!=null && controller.therapyGiftPlan.value.summary?.main?.value!=0) ...[
            13.h.toSizedBoxVertical,
            [
              "Discount (${controller.therapyGiftPlan.value.summary?.main?.rate}%) :".toHeading3(fontFamily: FontsConstant.appRegularFont),
              "${controller.therapyGiftPlan.value.region?.currency?.symbol}${controller.therapyGiftPlan.value.summary?.main?.value}".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorStormDust),
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(24.w),
          ],

          if(controller.therapyGiftPlan.value.summary?.premium?.rate!=null && controller.therapyGiftPlan.value.summary?.premium?.rate!=0 && controller.therapyGiftPlan.value.summary?.premium?.value!=null && controller.therapyGiftPlan.value.summary?.premium?.value!=0) ...[
            11.39.h.toSizedBoxVertical,
            [
              "Premium User Discount (${controller.therapyGiftPlan.value.summary?.premium?.rate}%) :".toHeading3(fontFamily: FontsConstant.appRegularFont),
              "${controller.therapyGiftPlan.value.region?.currency?.symbol}${controller.therapyGiftPlan.value.summary?.premium?.value}".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorStormDust),
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(24.w),
          ],
          11.52.h.toSizedBoxVertical,
          const Divider(color: AppColors.colorPrimary,thickness: 1).toHorizontalPadding(12.w),
          12.h.toSizedBoxVertical,
          [
            "Total (After Discounts) :".toHeading3(fontFamily: FontsConstant.appRegularFont),
            "${controller.therapyGiftPlan.value.region?.currency?.symbol}${controller.therapyGiftPlan.value.summary?.total?.sub}".toHeading3(),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(24.w),
          16.54.h.toSizedBoxVertical,
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toContainer(
            color: AppColors.colorWhiteLilac
        ).toHorizontalPadding(21.w),
        36.54.h.toSizedBoxVertical,
        [
          "Sub Total".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorStormDust),
          "${controller.therapyGiftPlan.value.region?.currency?.symbol}${controller.therapyGiftPlan.value.summary?.total?.sub}".toHeading3(),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(33.w),
        15.h.toSizedBoxVertical,
        [
          "${controller.therapyGiftPlan.value.region?.tax?.kind} (${controller.therapyGiftPlan.value.region?.tax?.rate}%)".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorStormDust),
          "${controller.therapyGiftPlan.value.region?.currency?.symbol}${controller.therapyGiftPlan.value.summary?.tax}".toHeading3(),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(33.w),
        25.54.h.toSizedBoxVertical,
        [
          StringsConstant.confirmAndTermsCondition.toHeading5(fontFamily: FontsConstant.appRegularFont).onTapWidget((){}),
          5.w.toSizedBoxHorizontal,
          StringsConstant.termsConditionsCaption.toHeading5(fontFamily: FontsConstant.appRegularFont,textDecoration: TextDecoration.underline).onTapWidget((){
            controller.redirectToWebView(StringsConstant.termsAndConditionUrl);
          }),
        ].toRow(mainAxisAlignment: MainAxisAlignment.center).toHorizontalPadding(20.w)
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toSingleChildScrollView.toExpanded(),
      [
        [
          "${controller.therapyGiftPlan.value.region?.currency?.symbol}${controller.therapyGiftPlan.value.summary?.total?.grand}".toHeading2(),
          "TOTAL".toHeading2(color: AppColors.colorCharcoalGrey,fontFamily: FontsConstant.appRegularFont)
        ].toColumn(),
        [
          "Confirm & Send".toHeading2(fontFamily: FontsConstant.appRegularFont),
          5.w.toSizedBoxHorizontal,
        // ImagesConstant.arrowForward.toSvg(color: AppColors.colorBlack),
          const Icon(Icons.arrow_forward_ios_sharp,color: AppColors.colorDarkBlue,size: 24)
        ].toRow().onTapWidget(()=>controller.checkout())

      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toSymmetricPadding(33.w, 16.h).toContainer(color: AppColors.colorPrimary)

    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toSafeArea;
  }


  Future<bool> onWillPop(BuildContext context)async
  {
    final result = await showCustomDialog(context: context, posBtnCallBack: (){
     controller.cancelOrder();
     Get.back();
    }, negBtnCallBack: ()=>Get.back(),
    removeBtnCallBack: ()=>Get.back());

    if(result==null)
      {
        return false;
      }
    else
      {
        return true;
      }
  }
}