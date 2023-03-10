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
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/club/eventDetails/events_details_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';

class EventDetails extends GetView<EventDetailsController>
{
  const EventDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
       appBar: CustomDarkAppbar(voidCallback: ()=>Get.back()),
       body:Obx(() =>responseWidget()),
     );
  }

  Widget responseWidget()
  {
    return ResponseWidgetsAnimator(
        apiCallStatus: controller.boatApiStatus.value,
        loadingWidget: (){
          return showProgress();
        },
        errorWidget: (){
          return const SizedBox();
        },
        successWidget:(){
          return eventDetails();
        }
    );
  }


  Widget eventDetails()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            20.h.toSizedBoxVertical,
            "${controller.boat.value.image}".toNetWorkBackgroundImage(),
            24.h.toSizedBoxVertical,
            [
              "${controller.boat.value.enrolled?.enrolledText}".toHeading2(color: const Color(0xFFFF0000)),
              ImagesConstant.share24.toSvg().onTapWidget(() {
                controller.shareData(controller.boat.value.share);
              })
            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            25.h.toSizedBoxVertical,
            "${controller.boat.value.title}".toHeading1(color: DarkThemeAppColors.colorTitle).toAlign(),
            12.h.toSizedBoxVertical,
            "${controller.boat.value.description}".toText(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont,fontSize: AppFontSize.heading3).toAlign(),
            12.h.toSizedBoxVertical,
            "Session facilitated by:".toHeading2(color: DarkThemeAppColors.colorTitle).toAlign(),
            15.h.toSizedBoxVertical,
            [
              [
                "${controller.boat.value.facilitator?.photo}".toNetWorkImage(width: 40.w,height: 40.h),
                15.w.toSizedBoxHorizontal,
                [
                  [
                    "${controller.boat.value.facilitator?.name}".toHeading2(color: DarkThemeAppColors.colorTitle),
                    5.w.toSizedBoxHorizontal,
                    ImagesConstant.verifiedTherapist.toSvg(width: 20.w,height: 20.h).toVisibility(controller.boat.value.facilitator?.verified!=null && controller.boat.value.facilitator!.verified?true:false)
                  ].toRow(),
                  "${controller.boat.value.facilitator?.title}".toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont),

                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
              ].toRow(),

              /* [
            ImagesConstant.delete.toSvg(color: DarkThemeAppColors.colorWhite),
            "Notify".toHeading3(fontFamily: FontsConstant.appRegularFont,color: DarkThemeAppColors.colorSubTitle)
          ].toColumn()*/

            ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
            27.h.toSizedBoxVertical,

            Container(
              decoration: BoxDecoration(
                  color: DarkThemeAppColors.colorBackgroundCard,
                  borderRadius: BorderRadius.circular(9.r)),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    [
                      if(controller.boat.value.startAt!=null && controller.boat.value.startAt!.isNotEmpty) ...[
                        [
                          AppUtil.convertStringToDateFormat(controller.boat.value.startAt,format: AppUtil.mmm).toHeading2(color: DarkThemeAppColors.colorTitle),
                          9.h.toSizedBoxVertical,
                          AppUtil.convertStringToDateFormat(controller.boat.value.startAt,format: AppUtil.dd).toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont)
                        ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
                      ],
                      10.w.toSizedBoxHorizontal,
                      const VerticalDivider(color: DarkThemeAppColors.colorPrimary,thickness:1),
                      10.w.toSizedBoxHorizontal,
                      if(controller.boat.value.startAt!=null &&
                          controller.boat.value.startAt!.isNotEmpty &&
                          controller.boat.value.endAt!=null &&
                          controller.boat.value.endAt!.isNotEmpty
                      ) ...[
                        [
                          AppUtil.convertStringToDateFormat(controller.boat.value.startAt,format: AppUtil.EEEE).toHeading2(color: DarkThemeAppColors.colorTitle),
                          9.h.toSizedBoxVertical,
                          "${AppUtil.convertStringToDateFormat(controller.boat.value.startAt,format: AppUtil.hhmma)} - ${AppUtil.convertStringToDateFormat(controller.boat.value.endAt,format: AppUtil.hhmma)}".toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont)
                        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center),
                      ],
                    ].toRow(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                      decoration: BoxDecoration(
                          color: const Color(0xFF16A9B1),
                          borderRadius: BorderRadius.circular(4.r)
                      ),
                      child:  [
                        ImagesConstant.notified.toSvg(color: DarkThemeAppColors.colorWhite),
                        "Notify".toHeading3(fontFamily: FontsConstant.appRegularFont,color: DarkThemeAppColors.colorTitle)
                      ].toColumn(),
                    ).onTapWidget(() {
                      controller.notifyEvent(controller.boat.value.id!);
                    })

                  ],
                ).toSymmetricPadding(20.w,14.h),
              ),
            ),
            28.h.toSizedBoxVertical,
          ],
        ).toSingleChildScrollView,
        [
          if(controller.boat.value.cta?.text!=null && controller.boat.value.cta!.text!.isNotEmpty) ...[
            "${controller.boat.value.cta!.text}".toHeading2(color: DarkThemeAppColors.colorBlack,textAlign: TextAlign.center).toSquareButton(() {
               if(controller.boat.value.locked!)
                 {
                   controller.redirectToPlanScreen();
                 }
               else
                 {
                   controller.getMeetLink(controller.boat.value.id!);
                 }
            },verticalPadding: 15.h).toSizedBoxWidth(1.sw)
          ]
        ].toColumn().toPaddingOnly(bottom: 20.w)
      ],
    ).toHorizontalPadding(33.w);
  }
}