import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapySlotDetails/therapy_slot_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import '../../../appUtils/uppercase_textformatter.dart';
import '../../../data/models/therapyModel/therapy_gift_plan_response.dart';
import '../../../theme/app_color.dart';
import '../../../widgets/common_widget.dart';

class TherapySlotDetails extends GetView<TherapySlotDetailsController> {
  const TherapySlotDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundScreen,
      appBar: CustomAppbar(
        voidCallback: () => Get.back(),
      ),
     body: controller.obx((state) => Obx(
             () => therapySlotDetails()
     ),
       onLoading: showProgress(),
     )
    );
  }

  Widget therapySlotDetails() {
    return [
      78.h.toSizedBoxVertical,
      "Slot Details".toHeading1(),
      24.47.h.toSizedBoxVertical,
      [
        18.h.toSizedBoxVertical,
        [
          "Therapist:".toHeading3(fontFamily: FontsConstant.appRegularFont),
          2.w.toSizedBoxHorizontal,
          "${controller.doctorItem.value.user!.name}".toHeading2(),
        ].toRow(),
        11.h.toSizedBoxVertical,
        if(controller.selectedSlotList.isNotEmpty && controller.selectedSlotList.length==2) ...[
          "(${AppUtil.convertStringToDateFormat(controller.selectedSlotList[0].startDate,format: AppUtil.dateTimeMMMDHHMMA)} & ${AppUtil.convertStringToDateFormat(controller.selectedSlotList[1].startDate,format: AppUtil.dateTimeMMMDHHMMA)})"
              .toHeading3(fontFamily: FontsConstant.appRegularFont),
        ]
        else if(controller.selectedSlotList.isNotEmpty && controller.selectedSlotList.length==1) ...[
          "(${AppUtil.convertStringToDateFormat(controller.selectedSlotList[0].startDate,format: AppUtil.dateTimeMMMDHHMMA)})"
              .toHeading3(fontFamily: FontsConstant.appRegularFont),
        ],
        18.h.toSizedBoxVertical,
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          .toHorizontalPadding(23.w)
          .toContainer(color: AppColors.colorWhiteLilac),
      25.h.toSizedBoxVertical,
      (controller.session.value>0?"Therapy Credit plan":"Select a plan").toHeading1(),
      24.h.toSizedBoxVertical,
      if(controller.session.value>0 && controller.session.value<4) ...[
        creditPlanItem(),
        25.h.toSizedBoxVertical,
        "Add on ".toHeading1(),
        10.h.toSizedBoxVertical,
        planItemListView()
      ]else if(controller.session.value>3) ...[
       creditPlanItem(),
       25.h.toSizedBoxVertical,
      ]
      else ...[
        planItemListView()
      ],
      20.h.toSizedBoxVertical,
      if(controller.session.value<4) ...[
        (controller.session.value>0?"Select A Different Plan":"View More Plans")
            .toHeading3(
            fontFamily: FontsConstant.appRegularFont,
            color: AppColors.colorPalatinateBlue,
            textDecoration: TextDecoration.underline)
            .toTextButton(()=>openPlanListBottomSheet()
        )
            .toAlign(alignment: Alignment.center),
      ],
      40.h.toSizedBoxVertical,
      [
        ImagesConstant.gift.toSvg(),
        "Got a gift?".toHeading2(
            fontFamily: FontsConstant.appRegularFont,
            textDecoration: TextDecoration.underline),
      ].toRow().onTapWidget(() {
        openRedeemAGiftBottomSheet();
      }),

      38.h.toSizedBoxVertical,
     controller.btnPayNow.value
          .toHeading2(fontFamily: FontsConstant.appRegularFont)
          .toSquareButtonMatchParent(
              () => controller.getTherapyOrder()),


      30.h.toSizedBoxVertical,
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .toHorizontalPadding(33.w)
        .toSingleChildScrollView
        .toSafeArea;
  }

  Widget planItemListView() {
    return ListView.separated(
      itemCount: controller.session.value>0?1:controller.therapyPlanList.length>2?2:controller.therapyPlanList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return Padding(padding: EdgeInsets.only(top: 16.h));
      },
      itemBuilder: (BuildContext context, int index) {
        return planItem(AppColors.colorWhite, controller.therapyPlanList,index);
      },
    );
  }

  Widget creditPlanItem() {
    return Stack(
      children: [
        [
          9.h.toSizedBoxVertical,
          "Low Balance"
              .toHeading3(
                  color: AppColors.colorRed,
                  fontFamily: FontsConstant.appRegularFont)
              .toAlign(alignment: Alignment.topRight)
              .toPaddingOnly(right: 12.w).toVisibility(controller.user.value.units!.session!<4),
          [
            "${controller.user.value.units?.session}".toText(fontSize: 24.sp, color: controller.user.value.units!.session!<4?const Color(0xFFDA0000):AppColors.colorTitleText),
            "Credit Balance".toHeading3(
                color: AppColors.colorTitleText,
                fontFamily: FontsConstant.appRegularFont)
          ].toColumn(),
          ImagesConstant.competedLarge
              .toSvg(width: 48.w, height: 48.h)
              .toAlign(alignment: Alignment.bottomRight)
              .toPaddingOnly(right: 10.w, bottom: 10.h)
        ].toColumn().toContainer(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: AppColors.colorPrimary, width: 1),
                color: AppColors.colorHawkesBlue)),
        ImagesConstant.flower
            .toSvg()
            .toAlign(alignment: Alignment.bottomLeft).toPositioned(bottom: 0,top: 0),
      ],
    );
  }

  Widget planItem(Color bgColor,List<TherapyGiftPlan> therapyPlanList,int index) {
    return Obx(() => Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        [
          [
            21.28.h.toSizedBoxVertical,
            if(therapyPlanList[index].discount!=null && therapyPlanList[index].discount!=0) ...[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.colorMediumGreen),
                child: "Save ${therapyPlanList[index].discount}%"
                    .toHeading5(
                    color: AppColors.colorWhite,
                    fontFamily: FontsConstant.appRegularFont)
                    .toSymmetricPadding(8.w, 3.5.h),
              ).toAlign(alignment: Alignment.topRight).toPaddingOnly(right: 31.w),
            ],
            "${therapyPlanList[index].name}"
                .toHeading2()
                .toAlign(alignment: Alignment.topLeft),
            2.h.toSizedBoxVertical,
            [
              [
                if(therapyPlanList[index].standard!=null && therapyPlanList[index].standard!) ...[
                  "1".toHeading1().toAlign(alignment: Alignment.topLeft),
                ]else ...[
                  "${therapyPlanList[index].units?.session}".toHeading1().toAlign(alignment: Alignment.topLeft)
                ],
                3.w.toSizedBoxHorizontal,
                "Session"
                    .toHeading2(fontFamily: FontsConstant.appRegularFont)
                    .toAlign(alignment: Alignment.topLeft),
              ].toRow(),
              [
                if(therapyPlanList[index].region?.currency?.code=="USD") ...[
                  "\$ ${therapyPlanList[index].summary!.perBase}"
                      .toHeading3(
                      fontFamily: FontsConstant.appRegularFont,
                      textAlign: TextAlign.start)
                      .toPaddingOnly(right: therapyPlanList[index].standard!?35.w:15.w),
                ] else ...[
                  "${therapyPlanList[index].summary!.perBase} INR"
                      .toHeading3(
                      fontFamily: FontsConstant.appRegularFont,
                      textAlign: TextAlign.start)
                      .toPaddingOnly(right: therapyPlanList[index].standard!?35.w:15.w),
                ],
                if(therapyPlanList[index].standard!=null && !therapyPlanList[index].standard!) ...[
                  "Per Session"
                      .toHeading4(
                      fontFamily: FontsConstant.appRegularFont,
                      textAlign: TextAlign.start)
                      .toPaddingOnly(right: 18.w),
                ],
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            ].toRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start),
            if(AppUtil.getValidateDays(therapyPlanList[index].time)!=0) ...[
              "${AppUtil.getValidateDays(therapyPlanList[index].time)} Day Validity"
                  .toHeading4(
                  fontFamily: FontsConstant.appRegularFont,
                  color: AppColors.colorSubtitleTextColor)
                  .toAlign(alignment: Alignment.topLeft),
            ] else ...[
              10.h.toSizedBoxVertical,
            ],
            if(controller.selectedPlanIndex.value==index) ...[
              ImagesConstant.competedLarge
                  .toSvg(width: 40.w, height: 40.h)
                  .toPaddingOnly(right: 10.w)
                  .toAlign(alignment: Alignment.topRight),
            ] else ...[
              30.h.toSizedBoxVertical,
            ],
            11.h.toSizedBoxVertical,
          ].toColumn().toPaddingOnly(left: 16.w).toContainer(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color:index==controller.selectedPlanIndex.value?AppColors.colorPrimary:const Color(0xFFD5D5D5), width: 1),
                  color: controller.selectedPlanIndex.value==index?AppColors.colorWhite:bgColor
              )
          ),

          if(controller.selectedPlanIndex.value==index) ...[
            Container(
                height: 12.h,
                width: 1.sw,
                decoration: BoxDecoration(
                    color: const Color(0xFFAAAAD6),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(29.r))))
                .toAlign(alignment: Alignment.center)
                .toHorizontalPadding(12.w)
          ],
        ].toColumn(),

        if(therapyPlanList[index].badge!=null && therapyPlanList[index].badge!.isNotEmpty) ...[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27.r),
                color: AppColors.colorPrimary),
            child: "Best Value"
                .toHeading4(fontFamily: FontsConstant.appRegularFont)
                .toSymmetricPadding(10.w, 6.h),
          ).toAlign(alignment: Alignment.topCenter).toPositioned(top: -10),
        ]
      ],
    ).toPaddingOnly(top: 10).onTapWidget(() {

      if(controller.session.value>0 && controller.session.value<4)
        {
          if(controller.selectedPlanIndex.value!=-1)
            {
              controller.selectedPlanIndex.value=-1;
            }
          else
            {
              controller.selectedPlanIndex.value=index;
            }
          controller.updateUI();
        }
      else
        {
          controller.selectedPlanIndex.value=index;
        }
      controller.setSelectedItemForSheet();

    }));
  }

  Widget planItemCopy(Color bgColor,TherapyGiftPlan therapyPlan,int index) {
    return Obx(() => Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        [
          [
            21.28.h.toSizedBoxVertical,
            if(therapyPlan.discount!=null && therapyPlan.discount!=0) ...[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.colorMediumGreen),
                child: "Save ${therapyPlan.discount}%"
                    .toHeading5(
                    color: AppColors.colorWhite,
                    fontFamily: FontsConstant.appRegularFont)
                    .toSymmetricPadding(8.w, 3.5.h),
              ).toAlign(alignment: Alignment.topRight).toPaddingOnly(right: 31.w),
            ],
            "${therapyPlan.name}"
                .toHeading2()
                .toAlign(alignment: Alignment.topLeft),
            2.h.toSizedBoxVertical,
            [
              [
                if(therapyPlan.standard!=null && therapyPlan.standard!) ...[
                  "${controller.selectedSlotList.length*1}".toHeading1().toAlign(alignment: Alignment.topLeft),
                ]else ...[
                  "${therapyPlan.units?.session}".toHeading1().toAlign(alignment: Alignment.topLeft)
                ],
                3.w.toSizedBoxHorizontal,
                "Session"
                    .toHeading2(fontFamily: FontsConstant.appRegularFont)
                    .toAlign(alignment: Alignment.topLeft),
              ].toRow(),
              [
                if(therapyPlan.region?.currency?.code=="USD") ...[

                  "\$ ${therapyPlan.standard!=null && therapyPlan.standard!?therapyPlan.summary!.perBase!*controller.selectedSlotList.length:therapyPlan.summary!.perBase}"
                      .toHeading3(
                      fontFamily: FontsConstant.appRegularFont,
                      textAlign: TextAlign.start)
                      .toPaddingOnly(right: therapyPlan.standard!?35.w:15.w),
                ] else ...[
                  "${therapyPlan.standard!=null && therapyPlan.standard!?therapyPlan.summary!.perBase!*controller.selectedSlotList.length:therapyPlan.summary!.perBase} INR"
                      .toHeading3(
                      fontFamily: FontsConstant.appRegularFont,
                      textAlign: TextAlign.start)
                      .toPaddingOnly(right: therapyPlan.standard!?35.w:15.w),
                ],
                if(therapyPlan.standard!=null && !therapyPlan.standard!) ...[
                  "Per Session"
                      .toHeading4(
                      fontFamily: FontsConstant.appRegularFont,
                      textAlign: TextAlign.start)
                      .toPaddingOnly(right: 18.w),
                ],
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            ].toRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start),
            if(AppUtil.getValidateDays(therapyPlan.time)!=0) ...[
              "${AppUtil.getValidateDays(therapyPlan.time)} Day Validity"
                  .toHeading4(
                  fontFamily: FontsConstant.appRegularFont,
                  color: AppColors.colorSubtitleTextColor)
                  .toAlign(alignment: Alignment.topLeft),
            ] else ...[
              10.h.toSizedBoxVertical,
            ],
            if(controller.selectedPlanIndexCopy.value==index) ...[
              ImagesConstant.competedLarge
                  .toSvg(width: 40.w, height: 40.h)
                  .toPaddingOnly(right: 10.w)
                  .toAlign(alignment: Alignment.topRight),
            ] else ...[
              30.h.toSizedBoxVertical,
            ],
            11.h.toSizedBoxVertical,
          ].toColumn().toPaddingOnly(left: 16.w).toContainer(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color:index==controller.selectedPlanIndexCopy.value?AppColors.colorPrimary:const Color(0xFFD5D5D5), width: 1),
                  color: controller.selectedPlanIndexCopy.value==index?AppColors.colorWhite:bgColor
              )
          ),

          if(controller.selectedPlanIndexCopy.value==index) ...[
            Container(
                height: 12.h,
                width: 1.sw,
                decoration: BoxDecoration(
                    color: const Color(0xFFAAAAD6),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(29.r))))
                .toAlign(alignment: Alignment.center)
                .toHorizontalPadding(12.w)
          ],
        ].toColumn(),

        if(therapyPlan.badge!=null && therapyPlan.badge!.isNotEmpty) ...[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27.r),
                color: AppColors.colorPrimary),
            child: "Best Value"
                .toHeading4(fontFamily: FontsConstant.appRegularFont)
                .toSymmetricPadding(10.w, 6.h),
          ).toAlign(alignment: Alignment.topCenter).toPositioned(top: -10),
        ]
      ],
    ).toPaddingOnly(top: 10).onTapWidget(() {
      controller.selectedPlanIndexCopy.value=index;
      if(controller.session.value>0 && controller.session.value<4)
        {
          controller.btnPlanSheet.value="Continue with ${therapyPlan.units!.session} Session Plan";
          controller.isShowBtnPlanSheet.value=true;
        }
    }));
  }

  openPlanListBottomSheet() {
    Get.bottomSheet(
        [
          32.h.toSizedBoxVertical,
          "Select a plan".toHeading1(),
          40.h.toSizedBoxVertical,
          Obx(() => ListView.separated(
            itemCount: controller.therapyPlanListCopy.length,
            separatorBuilder: (context, index) {
              return Padding(padding: EdgeInsets.only(top: 16.h));
            },
            itemBuilder: (context, index) {
              return planItemCopy(AppColors.colorGhostWhite,controller.therapyPlanListCopy[index],index);
            },
          ).toExpanded()),
          30.h.toSizedBoxVertical,
          Obx(() =>  controller.btnPlanSheet.value.toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonMatchParent(() {
            controller.swappingTherapyPlan();
            Navigator.pop(Get.context!);
          }).toVisibility(controller.isShowBtnPlanSheet.value)),
          20.h.toSizedBoxVertical
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .toHorizontalPadding(40.w)
            .toSizedBoxHeight(0.8.sh),
        backgroundColor: AppColors.colorGhostWhite,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))));
  }

  openRedeemAGiftBottomSheet() {
    Get.bottomSheet(
        [
          32.h.toSizedBoxVertical,
          [
            ImagesConstant.giftRedeemImage.toSvg(height: 48.h,width:48.w),
            14.w.toSizedBoxHorizontal,
            "Redeem a gift".toHeading1(),
          ].toRow(),
          30.h.toSizedBoxVertical,
          toTextFormField(
              controller: controller.redeemController,
              validator: null,
              inputFormatter:[UpperCaseTextFormatter()]
          ),
          22.h.toSizedBoxVertical,
          "Redeem".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonMatchParent(()=>controller.checkRedeemValidation()),
          40.h.toSizedBoxVertical,
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .toHorizontalPadding(33.w).toSingleChildScrollView,
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
}
