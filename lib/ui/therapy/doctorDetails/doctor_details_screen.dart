import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/doctorDetails/doctor_details_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';

import '../../../appUtils/app_util.dart';

class DoctorDetailsScreen extends GetView<DoctorDetailsController> {
  const DoctorDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(voidCallback: () => Get.back()),
      body: controller.obx((state) => Obx(() => doctorDetailsScreen()),
          onLoading: showProgress().toCenter()
      ),
    );
  }

  Widget doctorDetailsScreen() {
    return [
      15.38.h.toSizedBoxVertical,
      [
        [
          controller.doctorItem.value.user!.profile!
              .toNetWorkImage(height: 130.h, width: 124.w),
          ImagesConstant.share.toSvg().toContainer(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: AppColors.colorPrimary)).onTapWidget(() {
                    controller.shareData();
          })
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
        15.38.h.toSizedBoxVertical,
        [
          "${controller.doctorItem.value.user!.name}"
              .toHeading1()
              .toSizedBoxWidth(250.w),
          [
            const Icon(Icons.star, size: 15, color: AppColors.colorWhite),
            5.2.w.toSizedBoxHorizontal,
            "${controller.doctorItem.value.user!.rating}"
                .toHeading4(color: AppColors.colorWhite)
                .toPaddingOnly(top: 2.h),
          ].toRow().toSymmetricPadding(5.w, 3.h).toContainer(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3.r)),
                  color: AppColors.colorMediumGreen),
              alignment: Alignment.center)
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
        "(${controller.doctorItem.value.pronouns})"
            .toHeading3(fontFamily: FontsConstant.appRegularFont),
        22.85.h.toSizedBoxVertical,
        StringsConstant.about.toHeading1(),
        15.83.h.toSizedBoxVertical,
        if (controller.doctorItem.value.specialisations != null &&
            controller.doctorItem.value.specialisations!.isNotEmpty) ...[
          "${controller.doctorItem.value.specialisations![0].name}".toHeading3(
              fontFamily: FontsConstant.appRegularFont,
              color: AppColors.colorBlackCow),
        ],
        3.57.h.toSizedBoxVertical,
        if (controller.getDegrees(controller.doctorItem.value).isNotEmpty) ...[
          3.57.h.toSizedBoxVertical,
          "Qualification : ${controller.getDegrees(controller.doctorItem.value)}"
              .toHeading3(
                  fontFamily: FontsConstant.appRegularFont,
                  color: AppColors.colorBlackCow)
        ],
        15.83.h.toSizedBoxVertical,
        "${controller.doctorItem.value.about}"
            .toHeading3(fontFamily: FontsConstant.appRegularFont),
        40.83.h.toSizedBoxVertical,
        StringsConstant.reviews.toHeading1(),
        29.h.toSizedBoxVertical,
        Obx(() => controller.reviewList.isNotEmpty
            ? reviewListView()
            : StringsConstant.noReviewYet
                .toHeading2(fontFamily: FontsConstant.appRegularFont)
        ),
        30.h.toSizedBoxVertical,

        if(controller.reviewTotal.value>controller.reviewList.length) ...[
          StringsConstant.seeMore
              .toHeading2(
              fontFamily: FontsConstant.appRegularFont,
              textDecoration: TextDecoration.underline)
              .toTextButton(() {
                controller.getTherapyReviews(controller.doctorItem.value.user!.id!, controller.doctorItem.value.user!.slug!, controller.reviewLimit, controller.reviewOffset.value);
               })
              .toAlign(alignment: Alignment.center)
        ]
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          .toHorizontalPadding(33.w)
          .toSingleChildScrollView
          .toExpanded(),
      if (controller.doctorItem.value.schedule != null) ...[
        [
          [
            StringsConstant.availableOn.toHeading3(
                color: AppColors.colorBlack,
                fontFamily: FontsConstant.appRegularFont),
            ImagesConstant.calendar.toSvg(height: 35, width: 35),
            AppUtil.getMMMDYDateFormat(controller.doctorItem.value.schedule)
                .toHeading3(
                    color: AppColors.colorBlack,
                    fontFamily: FontsConstant.appRegularFont)
          ].toRow(),
          StringsConstant.bookSessionCaption
              .toHeading2(
                  color: AppColors.colorDarkBlue,
                  textDecoration: TextDecoration.underline)
              .toTextButton(() {
                controller.redirectToTherapyBookingScreen();
          })
        ]
            .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .toSymmetricPadding(24.w, 8.h)
            .toContainer(color: AppColors.colorFog)
      ] else
        StringsConstant.noSlotsAvailable
            .toHeading3(
                color: AppColors.colorBlack,
                fontFamily: FontsConstant.appRegularFont)
            .toVerticalPadding(30.h)
            .toAlign(alignment: Alignment.center)
            .toContainer(color: AppColors.colorFog)
    ].toColumn();
  }


  Widget reviewListView() {

    return ResponseWidgetsAnimator(
        apiCallStatus: controller.reviewListApiCallStatus.value,
        loadingWidget: (){
          if(controller.reviewOffset==3)
          {
            return showProgress().toCenter();
          }
          else
          {
            return ListView.separated(
              itemCount: controller.reviewList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return Padding(padding: EdgeInsets.only(top: 20.h));
              },
              itemBuilder: (context, index) {
                return reviewsItem(controller.reviewList[index]);
              },
            );
          }
        },
        errorWidget: (){
          return StringsConstant.noReviewYet
              .toHeading2(fontFamily: FontsConstant.appRegularFont);
        },
        successWidget: (){
          return ListView.separated(
            itemCount: controller.reviewList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return Padding(padding: EdgeInsets.only(top: 20.h));
            },
            itemBuilder: (context, index) {
              return reviewsItem(controller.reviewList[index]);
            },
          );
        }
    );
  }



  Widget reviewsItem(String review) {
    return [
      [
        [
          ImagesConstant.profilePlaceholder.toSvg(height: 60.h, width: 60.w),
          8.w.toSizedBoxHorizontal,
          "User x".toHeading2(),
        ].toRow(),
        [
          const Icon(Icons.star, size: 15, color: AppColors.colorWhite),
          5.2.w.toSizedBoxHorizontal,
          "4.0".toHeading4(color: AppColors.colorWhite).toPaddingOnly(top: 2),
        ].toRow().toSymmetricPadding(5.w, 3.h).toContainer(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3.r)),
                color: AppColors.colorMediumGreen),
            alignment: Alignment.center)
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      8.h.toSizedBoxHorizontal,
      "$review"
          .toHeading3(fontFamily: FontsConstant.appRegularFont)
          .toAlign(alignment: Alignment.topLeft)
    ].toColumn().toSymmetricPadding(13.w, 13.h).toContainer(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13.r)),
            color: AppColors.colorMagnolia));
  }
}
