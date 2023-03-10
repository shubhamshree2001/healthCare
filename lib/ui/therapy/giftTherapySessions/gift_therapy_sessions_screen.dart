import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_gift_plan_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/giftTherapySessions/gift_therapy_session_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class GiftTherapySessions extends GetView<GiftTherapySessionController> {
  const GiftTherapySessions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: CustomAppbar(
        voidCallback: () => Get.back(),
      ),
      body: controller.obx((state) => Obx(() => giftTherapyScreenBody()),
          onLoading: showProgress()),
    );
  }

  Widget giftTherapyScreenBody() {
    return [
      80.h.toSizedBoxVertical,
      ImagesConstant.giftSessions.toSvg().toAlign(alignment: Alignment.center),
      26.74.h.toSizedBoxVertical,
      StringsConstant.gifTherapySessions
          .toHeading1()
          .toAlign(alignment: Alignment.center),
      7.h.toSizedBoxVertical,
      StringsConstant.sendSomeoneTheGift
          .toHeading3(fontFamily: FontsConstant.appRegularFont)
          .toAlign(alignment: Alignment.center),
      giftTherapyListView(),
      100.68.h.toSizedBoxVertical,
      "Gift ${controller.therapyGiftPlanList[controller.selectedPlanIndex.value].units!.session} Sessions"
          .toHeading2(fontFamily: FontsConstant.appRegularFont)
          .toRoundedButtonMatchParent(
              () => controller.redirectToTherapyRecipientScreen())
          .toHorizontalPadding(32.w)

      // StringsConstant.termsConditionsCaption.toHeading3(fontFamily: FontsConstant.appRegularFont,textDecoration: TextDecoration.underline).toTextButton(() { }).toAlign(alignment: Alignment.center),
      //  50.h.toSizedBoxVertical,
    ].toColumn().toSingleChildScrollView;
  }

  Widget giftTherapyListView() {
    return ListView.separated(
      itemCount: controller.therapyGiftPlanList.length,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) =>
          Padding(padding: EdgeInsets.only(left: 12.w)),
      itemBuilder: (context, index) =>
          giftItem(controller.therapyGiftPlanList[index], index),
    ).toSizedBoxHeight(300.h).toHorizontalPadding(27.w);
  }

  Widget giftItem(TherapyGiftPlan therapyGiftPlan, int index) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        [
          [
            15.h.toSizedBoxVertical,
            if (therapyGiftPlan.units != null &&
                therapyGiftPlan.units!.session != null) ...[
              "${therapyGiftPlan.units!.session}"
                  .toHeading1()
                  .toAlign(alignment: Alignment.center),
            ],
            "Sessions"
                .toHeading2(fontFamily: FontsConstant.appRegularFont)
                .toAlign(alignment: Alignment.center),
            4.63.h.toSizedBoxVertical,
            if (AppUtil.getValidateDays(therapyGiftPlan.time) != 0) ...[
              "${AppUtil.getValidateDays(therapyGiftPlan.time)} Day Validity"
                  .toHeading5(
                      color: AppColors.colorSmokeyGrey,
                      fontFamily: FontsConstant.appRegularFont)
                  .toAlign(alignment: Alignment.center),
            ],
            Divider(
                color: controller.selectedPlanIndex.value == index
                    ? AppColors.colorWhite
                    : AppColors.colorGainsboro,
                thickness: 1),
            "${therapyGiftPlan.region?.currency?.symbol}${therapyGiftPlan.summary?.perBase}\n Each"
                .toHeading3(
                    fontFamily: FontsConstant.appRegularFont,
                    textAlign: TextAlign.center)
                .toAlign(alignment: Alignment.center),
            8.06.h.toSizedBoxVertical,
            if (therapyGiftPlan.discount != null &&
                therapyGiftPlan.discount != 0) ...[
              "Save ${therapyGiftPlan.discount}%"
                  .toHeading5(
                      color: AppColors.colorWhite,
                      fontFamily: FontsConstant.appRegularFont)
                  .toAlign(alignment: Alignment.center)
                  .toSymmetricPadding(6.w, 2.5.h)
                  .toContainer(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          color: AppColors.colorMediumGreen))
                  .toHorizontalPadding(5.w),
            ] else ...[
              "0"
                  .toHeading4(fontFamily: FontsConstant.appRegularFont)
                  .toAlign(alignment: Alignment.center),
              3.h.toSizedBoxVertical,
            ],
            15.h.toSizedBoxVertical,
          ].toColumn().toHorizontalPadding(10.w).toContainer(
              width: 103.94.w,
              decoration: BoxDecoration(
                  color: index == controller.selectedPlanIndex.value
                      ? AppColors.colorHawkesBlue
                      : AppColors.colorWhite,
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  border: Border.all(
                      color: index == controller.selectedPlanIndex.value
                          ? AppColors.colorPrimary
                          : AppColors.colorIron,
                      width: 2.w))),
          if (index == controller.selectedPlanIndex.value) ...[
            Container(
                    height: 6.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                        color: const Color(0xFFAAAAD6),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(23.r),
                            bottomRight: Radius.circular(23.r))))
                .toAlign(alignment: Alignment.center)
          ]
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.center)
            .toPositioned(top: 10),
        if (therapyGiftPlan.badge != null &&
            therapyGiftPlan.badge!.isNotEmpty) ...[
          "${therapyGiftPlan.badge}"
              .toHeading4(fontFamily: FontsConstant.appRegularFont)
              .toAlign(alignment: Alignment.center)
              .toSymmetricPadding(2.w, 3.h)
              .toContainer(
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27.r),
                      color: AppColors.colorPrimary))
              .toAlign(alignment: Alignment.topCenter)
              .toPaddingOnly(left: 8.w, right: 8.w),
        ],
      ],
    )
        .toSizedBox(190.h, 103.94.w)
        .toAlign(alignment: Alignment.center)
        .onTapWidget(() {
      controller.selectedPlanIndex.value = index;
    });
  }
}
