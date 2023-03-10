import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/doctor_list_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/search/search_therapist_controller.dart';

import '../../../constants/fonts_constant.dart';
import '../../../constants/strings_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_theme.dart';

class SearchTherapistsScreen extends GetView<SearchTherapistsController> {
  const SearchTherapistsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorBackgroundScreen,
        body: Obx(() => searchTherapistsScreenBody()));
  }

  Widget searchTherapistsScreenBody() {
    return [
      searchBarView(),
      if (controller.searchText.isEmpty) ...[
        searchTherapistsHintView()
      ] else if (controller.doctorList.isNotEmpty) ...[
        searchResultView()
      ] else
        notFoundDataView()
    ].toColumn().toSafeArea;
  }

  Widget searchBarView() {
    return searchFieldView()
        .toPaddingOnly(left: 5.w, right: 33.w)
        .toAlign(alignment: Alignment.center)
        .toContainer(height: 80.h, color: AppColors.colorAppBar);
  }

  Widget searchTherapistsHintView() {
    return [
      ImagesConstant.search.toSvg(width: 90.w, height: 90.h),
      "Search therapists".toHeading2(),
      11.h.toSizedBoxVertical,
      "Eg: Siddharth khelkar shukla".toHeading3(
          color: AppColors.colorSubtitleTextColor,
          fontFamily: FontsConstant.appRegularFont)
    ]
        .toColumn(mainAxisAlignment: MainAxisAlignment.center)
        .toCenter()
        .toExpanded();
  }

  Widget searchFieldView() {
    return [
      IconButton(
          onPressed: () => Get.back(),
          splashRadius: 18,
          icon: ImagesConstant.back.toSvg()),
      TextFormField(
        autofocus: true,
        controller: controller.searchController,
        keyboardType: TextInputType.text,
        style: AppTheme.heading2
            .copyWith(fontFamily: FontsConstant.appRegularFont),
        decoration: InputDecoration(
            isDense: true,
            prefixIcon: IconButton(
              icon: ImagesConstant.search
                  .toSvg(color: AppColors.colorSubtitleTextColor),
              onPressed: null,
            ),
            hintText: "Search",
            hintStyle: AppTheme.heading2.copyWith(
                color: AppColors.colorSubtitleTextColor,
                fontFamily: FontsConstant.appRegularFont),
            contentPadding:
                EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorWhite, width: 0.w),
                borderRadius: BorderRadius.circular(43.0.r)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorWhite, width: 0.w),
                borderRadius: BorderRadius.circular(43.0.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorWhite, width: 0.w),
                borderRadius: BorderRadius.circular(43.0.r)),
            filled: true,
            fillColor: AppColors.colorWhite),
        onChanged: (value) {
          controller.searchText.value = value;
          if (value.length >= 3) {
            controller.filterText.value = value;
          }
        },
      ).toExpanded()
    ].toRow().toVerticalPadding(10.h);
  }

  Widget notFoundDataView() {
    return [
      ImagesConstant.notFoundImg.toSvg(),
      36.86.h.toSizedBoxVertical,
      "Oops, we couldn't find anything related to your search :("
          .toHeading2(textAlign: TextAlign.center),
      13.h.toSizedBoxVertical,
      "Please try again using different words".toHeading3(
          fontFamily: FontsConstant.appRegularFont,
          color: AppColors.colorSubtitleTextColor,
          textAlign: TextAlign.center)
    ]
        .toColumn(mainAxisAlignment: MainAxisAlignment.center)
        .toHorizontalPadding(33.w)
        .toCenter()
        .toExpanded();
  }

  Widget searchResultView() {
    return [
      34.h.toSizedBoxVertical,
      "Search results".toHeading2().toAlign(alignment: Alignment.topLeft),
      26.h.toSizedBoxVertical,
      ListView.separated(
        itemCount: controller.doctorList.length,
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(top: 22.h));
        },
        itemBuilder: (context, index) {
          return searchItem(controller.doctorList[index]);
        },
      ).toExpanded(),
      26.h.toSizedBoxVertical,
    ].toColumn().toContainer().toHorizontalPadding(33.w).toExpanded();
  }

  Widget searchItem(DoctorItem doctorItem) {
    return Column(
      children: [
        7.12.h.toSizedBoxVertical,
        doctorItem.user!.rating!
            .toRatingView()
            .toAlign(alignment: Alignment.topRight)
            .toPaddingOnly(right: 7.87.w),
        [
          [
            "${doctorItem.user?.name}".toHeading3(color: AppColors.colorBlack),
            "(${doctorItem.pronouns})"
                .toHeading5(fontFamily: FontsConstant.appRegularFont),
            13.23.h.toSizedBoxVertical,
            if (doctorItem.specialisations != null &&
                doctorItem.specialisations!.isNotEmpty) ...[
              "${doctorItem.specialisations![0].name}".toHeading4(
                  color: AppColors.colorBlackCow,
                  fontFamily: FontsConstant.appRegularFont),
            ],
            if (controller.getDegrees(doctorItem).isNotEmpty) ...[
              3.57.h.toSizedBoxVertical,
              "Qualification : ${controller.getDegrees(doctorItem)}".toHeading4(
                  color: AppColors.colorBlackCow,
                  fontFamily: FontsConstant.appRegularFont)
            ],
            2.36.h.toSizedBoxVertical,
            StringsConstant.moreDetailsCaption
                .toHeading4(
                    color: AppColors.colorDarkBlue,
                    fontFamily: FontsConstant.appRegularFont,
                    textDecoration: TextDecoration.underline)
                .onTapWidget(() => Get.toNamed(Routes.doctorDetails))
          ]
              .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
              .toSizedBoxWidth(200.w),
          "${doctorItem.user!.profile}"
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
            child: doctorItem.schedule != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      [
                        StringsConstant.availableOn.toHeading4(
                            color: AppColors.colorBlack,
                            fontFamily: FontsConstant.appRegularFont),
                        ImagesConstant.calendar.toSvg(height: 30, width: 30),
                        "${AppUtil.getMMMDYDateFormat(doctorItem.schedule)}"
                            .toHeading4(
                                color: AppColors.colorBlack,
                                fontFamily: FontsConstant.appRegularFont)
                      ].toRow(),
                      StringsConstant.bookNow
                          .toHeading3(
                              color: AppColors.colorDarkBlue,
                              textDecoration: TextDecoration.underline)
                          .toTextButton(
                              () => Get.toNamed(Routes.therapyBooking))
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
}
