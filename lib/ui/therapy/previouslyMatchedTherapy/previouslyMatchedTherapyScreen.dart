import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../constants/images_constant.dart';
import '../../../constants/strings_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_color.dart';

class PreviouslyMatchedTherapyScreen extends GetView {
  const PreviouslyMatchedTherapyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundScreen,
      appBar: CustomAppbar(voidCallback: () => Get.back()),
      body: previouslyMatchedTherapyBody(),
    );
  }

  previouslyMatchedTherapyBody() {
    return [
      28.h.toSizedBoxVertical,
      "Previously matched therapists".toHeading1(),
      15.h.toSizedBoxVertical,
      "Last matched on 11 Mar 2022"
          .toHeading3(fontFamily: FontsConstant.appRegularFont),
      40.h.toSizedBoxVertical,
      matchTherapistsListView(),
      30.h.toSizedBoxVertical,
      matchAgainView(),
      20.h.toSizedBoxVertical,
      StringsConstant.needHelp
          .toHeading2(
              fontFamily: FontsConstant.appRegularFont,
              textDecoration: TextDecoration.underline)
          .toAlign(alignment: Alignment.center),
      20.h.toSizedBoxVertical,
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .toHorizontalPadding(33.w)
        .toSingleChildScrollView
        .toSafeArea;
  }

  Widget matchTherapistsListView() {
    return ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(top: 30.h));
        },
        itemBuilder: (context, index) {
          return expertItem(index);
        });
  }

  Widget expertItem(int index) {
    return Column(
      children: [
        7.12.h.toSizedBoxVertical,
        4.0
            .toRatingView()
            .toAlign(alignment: Alignment.topRight)
            .toPaddingOnly(right: 7.87.w),
        [
          [
            "Riya".toHeading3(color: AppColors.colorBlack),
            "(She/Her)".toHeading5(fontFamily: FontsConstant.appRegularFont),
            13.23.h.toSizedBoxVertical,
            "Counselling Psychologist".toHeading4(
                color: AppColors.colorBlackCow,
                fontFamily: FontsConstant.appRegularFont),
            3.57.h.toSizedBoxVertical,
            "Qualification : M.Sc".toHeading4(
                color: AppColors.colorBlackCow,
                fontFamily: FontsConstant.appRegularFont),
            2.36.h.toSizedBoxVertical,
            StringsConstant.moreDetailsCaption
                .toHeading4(
                    color: AppColors.colorDarkBlue,
                    fontFamily: FontsConstant.appRegularFont,
                    textDecoration: TextDecoration.underline)
                .onTapWidget(() => Get.toNamed(Routes.doctorDetails))
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          "https://cdn.mindpeers.co/users/profile/b999736d-244d-48d3-b50c-98bfde63e639.png"
              .toNetWorkImage(height: 83.h, width: 78.94.w)
              .toAlign(alignment: Alignment.topRight)
        ]
            .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
            .toPaddingOnly(left: 20.07.w, right: 24.w),
        19.h.toSizedBoxVertical,
        Container(
          decoration: BoxDecoration(
              color: AppColors.colorTitanWhite,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
            child: index % 2 == 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      [
                        StringsConstant.availableOn.toHeading4(
                            color: AppColors.colorBlack,
                            fontFamily: FontsConstant.appRegularFont),
                        ImagesConstant.calendar.toSvg(height: 30, width: 30),
                        "Feb 2, 2021".toHeading4(
                            color: AppColors.colorBlack,
                            fontFamily: FontsConstant.appRegularFont)
                      ].toRow(),
                      StringsConstant.bookNow
                          .toHeading3(
                              color: AppColors.colorDarkBlue,
                              textDecoration: TextDecoration.underline)
                          .toTextButton(() {})
                    ],
                  )
                : StringsConstant.noSlotsAvailable
                    .toHeading4(
                        color: AppColors.colorBlack,
                        fontFamily: FontsConstant.appRegularFont)
                    .toVerticalPadding(20.h)
                    .toAlign(alignment: Alignment.center),
          ),
        )
      ],
    ).toCard(
      elevation: 5,
      shadowColor: const Color(0x00000029),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }

  Widget matchAgainView() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.colorLinkWater,
          borderRadius: BorderRadius.all(Radius.circular(8.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            25.55.h.toSizedBoxVertical,
            ImagesConstant.matchTherapist
                .toSvg(height: 110.89.h, width: 168.74.w),
            18.49.h.toSizedBoxVertical,
            StringsConstant.findTherapistForYou
                .toHeading1()
                .toSizedBoxWidth(231.w)
                .toAlign(alignment: Alignment.topLeft),
            15.79.h.toSizedBoxVertical,
            [
              StringsConstant.matchAgain.toHeading3(
                  color: AppColors.colorDarkBlue,
                  textDecoration: TextDecoration.underline),
              ImagesConstant.rightArrow.toSvg()
            ].toRow().onTapWidget(
                () => Get.toNamed(Routes.previouslyMatchedTherapy)),
            22.h.toSizedBoxVertical
          ],
        ),
      ),
    );
  }
}
