import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/doctor_list_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/bookSessions/book_session_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';

import '../../../appUtils/app_util.dart';
import '../../../repository/therapyRepo/therapy_repo_impl.dart';
import '../../../service/graph_ql_configuration.dart';
import '../../../theme/app_color.dart';

class BookSessionsScreen extends GetView<BookSessionController> {
  const BookSessionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BookSessionController(
        therapyRepo: Get.put(TherapyRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundScreen,
        body: Obx(() => bookSessionsBody())
    );
  }

  Widget bookSessionsBody() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: [
        34.h.toSizedBoxVertical,
        getMatchedView(),
        34.h.toSizedBoxVertical,
        ResponseWidgetsAnimator(
            apiCallStatus: controller.doctorListApiCallStatus.value,
            loadingWidget: (){
              if(controller.doctorOffset>0)
                {
                  return expertsListView();
                }
              else
                {
                  return showProgress();
                }
            },
            errorWidget:(){
              return const SizedBox();
            },
            successWidget: (){
              return expertsListView();
            }
        )
      ].toColumn(),
    ).toSafeArea;

  }

  Widget getMatchedView() {
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
              StringsConstant.getMatched.toHeading3(
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

  Widget expertsListView() {
    return [
      StringsConstant.meetOurExperts
          .toHeading1(
              fontFamily: FontsConstant.appBoldFont,
              color: AppColors.colorBlack)
          .toAlign(),
      27.28.h.toSizedBoxVertical,
      ListView.separated(
        itemCount: controller.doctorList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(top: 25.h));
        },
        itemBuilder: (context, index) {
          return expertItem(controller.doctorList[index]);
        },
      ),
      27.28.h.toSizedBoxVertical,
    ].toColumn();
  }

  Widget expertItem(DoctorItem doctorItem) {
    return Column(
      children: [
        7.12.h.toSizedBoxVertical,
        4.0
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
                .onTapWidget(() =>
                    controller.redirectToDoctorDetails(doctorItem.user!.slug!))
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
                          AppUtil.getMMMDYDateFormat(doctorItem.schedule)
                              .toHeading4(
                                  color: AppColors.colorBlack,
                                  fontFamily: FontsConstant.appRegularFont)
                        ].toRow(),
                        StringsConstant.bookNow
                            .toHeading3(
                                color: AppColors.colorDarkBlue,
                                textDecoration: TextDecoration.underline)
                            .toTextButton(() => controller
                                .redirectToTherapyBookingScreen(doctorItem))
                      ],
                    )
                  : StringsConstant.noSlotsAvailable
                      .toHeading4(
                          color: AppColors.colorBlack,
                          fontFamily: FontsConstant.appRegularFont)
                      .toVerticalPadding(20.h)
                      .toAlign(alignment: Alignment.center),
            ))
      ],
    ).toCard(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
