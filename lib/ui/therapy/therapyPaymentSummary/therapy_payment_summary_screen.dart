import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/credit_history_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapyPaymentSummary/therapy_payment_summary_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../appUtils/app_util.dart';
import '../../../appUtils/uppercase_textformatter.dart';
import '../../../constants/fonts_constant.dart';
import '../../../theme/app_color.dart';
import '../../../widgets/response_widget_animator.dart';

class TherapyPaymentSummaryScreen extends GetView<TherapyPaymentSummaryController>
{
  const TherapyPaymentSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return controller.onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        appBar: CustomAppbar(voidCallback: ()=>controller.onWillPop(context)),
        body: Obx(() => therapyPaymentSummaryBody())
      ),
    );
  }

  Widget therapyPaymentSummaryBody()
  {
    return [
    [
      56.h.toSizedBoxVertical,
      StringsConstant.paymentSummary.toHeading1().toHorizontalPadding(33.w),
      32.h.toSizedBoxVertical,
      [
        19.h.toSizedBoxVertical,
        "Therapy Details".toHeading3(fontFamily: FontsConstant.appRegularFont),
        8.27.h.toSizedBoxVertical,
        "${controller.receiveParams.value.doctorItem!.user!.name}".toHeading2(),
        8.27.h.toSizedBoxVertical,
        if(controller.receiveParams.value.selectedSlotList!.isNotEmpty && controller.receiveParams.value.selectedSlotList!.length==2) ...[
          "(${AppUtil.convertStringToDateFormat(controller.receiveParams.value.selectedSlotList![0].startDate,format: AppUtil.dateTimeMMMDHHMMA)} & ${AppUtil.convertStringToDateFormat(controller.receiveParams.value.selectedSlotList![1].startDate,format: AppUtil.dateTimeMMMDHHMMA)})"
              .toHeading3(fontFamily: FontsConstant.appRegularFont),
        ]
        else if(controller.receiveParams.value.selectedSlotList!.isNotEmpty && controller.receiveParams.value.selectedSlotList!.length==1) ...[
          "(${AppUtil.convertStringToDateFormat(controller.receiveParams.value.selectedSlotList![0].startDate,format: AppUtil.dateTimeMMMDHHMMA)})"
              .toHeading3(fontFamily: FontsConstant.appRegularFont),
        ],
        19.h.toSizedBoxVertical,

      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toHorizontalPadding(23.w).toContainer(
          color:AppColors.colorWhiteLilac
      ).toHorizontalPadding(33.w),
      17.57.h.toSizedBoxVertical,
      ResponseWidgetsAnimator(
          apiCallStatus: controller.creditHistoryApiCallStatus.value,
          loadingWidget: (){
            return showProgress().toCenter();
          },
          errorWidget: (){
            return Container();
          },
          successWidget: (){
            return  creditHistoryList().toHorizontalPadding(33.w);
          }
      ),
      17.57.h.toSizedBoxVertical,
      ResponseWidgetsAnimator(
          apiCallStatus: controller.therapyPlanApiCallStatus.value,
          loadingWidget: (){
            return showProgress().toCenter();
          },
          errorWidget: (){
            return Container();
          },
          successWidget: (){
            return  paymentSummaryItem().toHorizontalPadding(33.w);
          }
      ),
      24.h.toSizedBoxVertical,
      [
        [
          ImagesConstant.discount.toSvg(),
          "Use coupons".toText(fontSize: 18.sp),
        ].toRow().toHorizontalPadding(20.w),
        [
          toTextFormField(controller: controller.couponController, validator:null,inputFormatter: [UpperCaseTextFormatter()]).toExpanded(flex: 2).toForm(globalKey: controller.couponFormKey),
          12.w.toSizedBoxHorizontal,
          "Apply".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonWrapContent(height: 48.h,()=>controller.checkCouponValidation()).toExpanded(flex: 1)
        ].toRow(mainAxisSize: MainAxisSize.min,crossAxisAlignment:CrossAxisAlignment.start,).toHorizontalPadding(33.w),
        39.h.toSizedBoxVertical,
        [
          "Sub Total".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorStormDust),
          "${controller.currencySymbol}${controller.subtotal}".toHeading3(),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(33.w),

        if(controller.gst.value!=0) ...[
          15.h.toSizedBoxVertical,
          [
            "GST (${controller.therapyPlan.value.region!.tax!.rate}%)".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorStormDust),
            "${controller.currencySymbol}${controller.gst}".toHeading3(),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(33.w),
        ],
        25.54.h.toSizedBoxVertical,
        [
          StringsConstant.confirmAndTermsCondition.toHeading5(fontFamily: FontsConstant.appRegularFont).onTapWidget((){}),
          5.w.toSizedBoxHorizontal,
          StringsConstant.termsConditionsCaption.toHeading5(fontFamily: FontsConstant.appRegularFont,textDecoration: TextDecoration.underline),
        ].toRow(mainAxisAlignment: MainAxisAlignment.center).toHorizontalPadding(20.w).toHorizontalPadding(33.w),
        25.54.h.toSizedBoxVertical,
      ].toColumn().toVisibility(controller.receiveParams.value.planId!.isNotEmpty)
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toSingleChildScrollView.toExpanded(),
      [
        [
          "${controller.currencySymbol}${controller.grandTotal}".toHeading2(),
          "TOTAL".toHeading2(color: AppColors.colorCharcoalGrey,fontFamily: FontsConstant.appRegularFont)
        ].toColumn(),
        [
          "Confirm & Send".toHeading2(fontFamily: FontsConstant.appRegularFont),
          5.w.toSizedBoxHorizontal,
          // ImagesConstant.arrowForward.toSvg(color: AppColors.colorBlack),
          const Icon(Icons.arrow_forward_ios_sharp,color: AppColors.colorDarkBlue,size: 24)
        ].toRow().onTapWidget(()=>controller.redirectToBookingConfirmedScreen())

      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toSymmetricPadding(33.w, 16.h).toContainer(color: AppColors.colorPrimary)

    ].toColumn().toSafeArea;
  }
  
  
  Widget creditHistoryList()
  {
    return ListView.separated(
      itemCount: controller.creditHistoryList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
       return Padding(padding: EdgeInsets.only(top: 17.57.h));
      },
      itemBuilder: (context, index) {
       return creditHistoryItem(controller.creditHistoryList[index]);
      }, 
    );
  }

  Widget paymentSummaryItem()
  {
    return [
      [
        17.88.h.toSizedBoxVertical,
        "${controller.countX} X ${controller.therapyPlan.value.name} ${controller.session.value!=0?"(${controller.session} Credits)":""}".toHeading2().toHorizontalPadding(24.w),
        if(controller.discount.value!=0 && controller.therapyPlan.value.summary!.main!.rate!=0) ...[
          [
            "Discount (${controller.therapyPlan.value.summary!.main!.rate}%) :".toHeading3(fontFamily: FontsConstant.appRegularFont),
            "${controller.currencySymbol.value}${controller.discount}".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorStormDust),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(24.w),
        ],
        13.h.toSizedBoxVertical,

        if(controller.premiumDiscount.value!=0) ...[
          11.39.h.toSizedBoxVertical,
          [
            "Premium User Discount (0%) :".toHeading3(fontFamily: FontsConstant.appRegularFont),
            "₹0.00".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorStormDust),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(24.w),
        ],
        11.52.h.toSizedBoxVertical,
        const Divider(color: Color(0xFFD1E7FE),thickness: 1).toHorizontalPadding(12.w),
        12.h.toSizedBoxVertical,
        [
          "Total (After Discounts) :".toHeading3(fontFamily: FontsConstant.appRegularFont),
          "${controller.currencySymbol}${controller.subtotal}".toHeading3(),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(24.w),
        16.54.h.toSizedBoxVertical,
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toContainer(
          color: AppColors.colorWhiteLilac
      )
    ].toColumn();
  }

  Widget creditHistoryItem(CreditHistory creditHistory)
  {
    return [
      [
        17.88.h.toSizedBoxVertical,
        "${controller.countX} X ${creditHistory.name} (Wallet)".toHeading2().toHorizontalPadding(24.w),
        5.h.toSizedBoxVertical,
        [
          "Credit Being Used : 1".toHeading3(fontFamily: FontsConstant.appRegularFont),
          "₹0.00".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorStormDust),
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(24.w),
        5.h.toSizedBoxVertical,
        "Credit Remaining : ${controller.receiveParams.value.credit!-1}".toHeading3(fontFamily: FontsConstant.appRegularFont).toHorizontalPadding(24.w),
        16.54.h.toSizedBoxVertical,
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toContainer(
          color: AppColors.colorWhiteLilac
      )
    ].toColumn();
  }
}