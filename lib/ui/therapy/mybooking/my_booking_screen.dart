import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/mybooking/my_booking_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';

import '../../../data/models/therapyModel/request/therapy_session_list_response.dart';
import '../../../repository/therapyRepo/therapy_repo_impl.dart';
import '../../../service/graph_ql_configuration.dart';

class MyBookingScreen extends GetView<MyBookingController> {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Get.put(MyBookingController(
        therapyRepo: Get.put(TherapyRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));

    return Scaffold(
      backgroundColor: AppColors.colorBackgroundScreen,
      body: Obx(() => myBookingBody()),
    );
  }

  Widget myBookingBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 31.h),
            Container(
              decoration: BoxDecoration(
                  color: AppColors.colorLinkWater,
                  borderRadius: BorderRadius.all(Radius.circular(8.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 31.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 108.w,
                      child: Text(
                        StringsConstant.giftSomeoneTherapy,
                        style: AppTheme.boldChineseBlackColor16spTextStyle,
                      ),
                    ),
                    SizedBox(
                        height: 66.h,
                        width: 73.w,
                        child: SvgPicture.asset(ImagesConstant.giftWithBg)),
                  ],
                ),
              ),
            ).onTapWidget(() =>Get.toNamed(Routes.giftTherapySession)
            ),
            SizedBox(height: 32.88.h),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                StringsConstant.upcomingSessions,
                style: AppTheme.titleChineseBlackBoldTextStyle,
              ),
            ),
            SizedBox(height: 33.h),
            Obx(() => ResponseWidgetsAnimator(
                apiCallStatus: controller.upcomingApiCallStatus.value,
                loadingWidget: (){
                  return showProgress().toCenter();
                },
                errorWidget: (){
                  return sessionNotFound(StringsConstant.toTakeFirstStep);
                },
                emptyWidget: (){
                  return sessionNotFound(StringsConstant.toTakeFirstStep);
                },
                successWidget: (){
                  return upcomingSessionListView();
                },
            )
            ),
            SizedBox(height: 17.h),
          /*  Padding(
              padding: EdgeInsets.symmetric(horizontal: 56.w),
              child: matchParentCustomButton(StringsConstant.matchWithTherapist,
                  () {
                // Get.toNamed(Routes.matchedTherapy);
              }),
            ),*/
            SizedBox(height: 38.h),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                StringsConstant.pastSessions,
                style: AppTheme.titleChineseBlackBoldTextStyle,
              ),
            ),
            SizedBox(height: 32.h),
            Obx(() => ResponseWidgetsAnimator(
                apiCallStatus: controller.passApiCallStatus.value,
                loadingWidget: (){
                  if(controller.pastLimit.value==3)
                    {
                      return showProgress().toCenter();
                    }
                  else
                    {
                      return pastSessionListView();
                    }
                  },
                errorWidget: (){
                  return sessionNotFound(StringsConstant.pastBookingWillShow);
                },
                successWidget: (){
                  return pastSessionListView();
                },
            )
            ),
            SizedBox(height: 20.h),
            if(controller.therapySessionPastTotal.value>controller.pastTherapySessionList.length) ...[
              "Show More".toHeading2(fontFamily: FontsConstant.appRegularFont,textDecoration: TextDecoration.underline).toTextButton(() {
                controller.getPastTherapySessionList(20, controller.therapySessionPastOffset);
              })
            ]
            // bookAgainTherapy(),
          //  SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget upcomingSessionListView()
  {
    return ListView.separated(
       itemCount: controller.upcomingTherapySessionList.length,
       shrinkWrap: true,
       physics: const NeverScrollableScrollPhysics(),
       separatorBuilder: (context,index){
          return Padding(padding: EdgeInsets.only(top: 10.h));
       },
      itemBuilder:(context,index){
          return upcomingSessionItem(controller.upcomingTherapySessionList[index]);
      },

    );
  }


  Widget upcomingSessionItem(ListTherapySession therapySession) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      color: AppColors.colorWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Text(
                    "${therapySession.session?.doctor?.name}",
                    style: AppTheme.h3BoldBlackTextStyle,
                  ),
                ),
                const Icon(Icons.more_vert,
                    color: AppColors.colorBlack, size: 24).onTapWidget(() {openAppointmentBottomSheet(therapySession);}),
              ],
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(AppUtil.convertStringToDateFormat(therapySession.session?.schedule?.startDate,format: AppUtil.dateTimeMMMDthYYYYHHMMA),
                    style: AppTheme.regularColorIronSideGrey12spTextStyle),
              ),
            ),
            SizedBox(height: 9.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("${CommunicationModeEnumValue.getValue(therapySession.session!.mode)} Session",
                    style: AppTheme.regularBlack14spTextStyle),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: AppColors.colorPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(6.r))),
                    child: SvgPicture.asset(ImagesConstant.calendar),
                  ).onTapWidget(() {
                    controller.googleMeet(therapySession);
                  }),
                  "Start Session".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonWrapContent(() {
                    controller.getMeetLink(therapySession.session!.id!);
                  },height: 50.h)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pastSessionListView()
  {
    return ListView.separated(
      itemCount: controller.pastTherapySessionList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context,index){
        return Padding(padding: EdgeInsets.only(top: 10.h));
      },
      itemBuilder:(context,index){
        return pastSessionItem(controller.pastTherapySessionList[index]);
      },

    );
  }

  Widget pastSessionItem(ListTherapySession therapySession) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      color: AppColors.colorWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 18.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "${therapySession.session?.doctor?.name}",
                  style: AppTheme.h3BoldBlackTextStyle,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(AppUtil.convertStringToDateFormat(therapySession.session?.schedule?.startDate,format: AppUtil.dateTimeMMMDthYYYYHHMMA),
                    style: AppTheme.regularColorIronSideGrey12spTextStyle),
              ),
            ),
            SizedBox(height: 9.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("${CommunicationModeEnumValue.getValue(therapySession.session!.mode)} Session",
                    style: AppTheme.regularBlack14spTextStyle),
              ),
            ),
            SizedBox(height: 10.h),
            if(therapySession.feedback !=null && !therapySession.feedback! && !therapySession.canceled!) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      StringsConstant.giveFeedback,
                      style: AppTheme.underlineBlack14sp,
                    )),
              ),
            ],

            if(therapySession.canceled!=null && therapySession.canceled!) ...[
              "Cancelled".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonWrapContent(() { },color: AppColors.colorSubtitleTextColor,height: 50.h).toPaddingOnly(right: 17.w).toAlign(alignment: Alignment.topRight)

            ] else if(therapySession.homework!=null && therapySession.homework!) ...[
              "View Homework".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonWrapContent(() {
               controller.redirectToHomeWorkScreen(therapySession);
              },color: AppColors.colorPrimary,height: 50.h).toPaddingOnly(right: 17.w).toAlign(alignment: Alignment.topRight)
            ]
            else ...[
              "Completed".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonWrapContent(() { },color: AppColors.colorSubtitleTextColor,height: 50.h).toPaddingOnly(right: 17.w).toAlign(alignment: Alignment.topRight)
            ],
          ],
        ),
      ),
    );
  }

  Widget sessionNotFound(String msg) {
    return Obx(() => Column(
      children: [
        if(controller.isShowLastTherapistCard.value && controller.pastTherapySessionList.isNotEmpty) ...[
          bookAgainTherapy()
        ]else ...[
          SizedBox(
              height: 141.11.h,
              width: 209.19.w,
              child: SvgPicture.asset(ImagesConstant.upcomingSessionNotFound)),
          SizedBox(height: 15.h),
          Align(
            alignment: Alignment.center,
            child: Text(
              msg,
              style: AppTheme.boldChineseBlackColor16spTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    ));
  }

  Widget bookAgainTherapy() {
    return Column(
      children: [
      "You don't have an upcoming session.".toHeading2(fontFamily: FontsConstant.appRegularFont),
       15.h.toSizedBoxVertical,
        [
          22.h.toSizedBoxVertical,
          [
            [
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Continue your therapy journey with ",
                        style: TextStyle(
                            color: AppColors.colorTitleText,
                            fontFamily: FontsConstant.appRegularFont,
                            fontSize: 14.sp)),
                    TextSpan(
                        text: "${controller.pastTherapySessionList[0].session!.doctor!.name}",
                        style: TextStyle(
                            color: AppColors.colorTitleText,
                            fontFamily: FontsConstant.appBoldFont,
                            fontSize: 14.sp)),
                  ])),
              16.h.toSizedBoxVertical,
              [
                StringsConstant.bookAgain.toHeading3(
                    color: AppColors.colorDarkBlue,
                    textDecoration: TextDecoration.underline),
                2.w.toSizedBoxHorizontal,
                ImagesConstant.rightArrow.toSvg()
              ].toRow(),
            ].toColumn().toExpanded(),
            "${controller.pastTherapySessionList[0].session!.doctor!.profile}"
                .toNetWorkImage(height: 83.h, width: 78.94.w)
                .paddingOnly(left: 20.w)
          ].toRow(),
          17.h.toSizedBoxVertical,
        ].toColumn().toHorizontalPadding(16.w).toContainer(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                border: Border.all(color: const Color(0xFFA1A1FF), width: 1),
                gradient: const LinearGradient(colors: [
                  Color(0xFFEFEFFF),
                  Color(0xFFCBCBFF),
                ])))
      ],
    );
  }

  openAppointmentBottomSheet(ListTherapySession therapySession) {
    Get.bottomSheet(
        [
          29.h.toSizedBoxVertical,
          "Actions".toHeading2().toHorizontalPadding(33.w),
          17.h.toSizedBoxVertical,
          [
            ImagesConstant.appointmentCalendar.toSvg(),
            "Reschedule appointment"
                .toHeading2(fontFamily: FontsConstant.appRegularFont)
          ]
              .toRow()
              .toSymmetricPadding(23.w, 10.h)
              .toContainer(color: Colors.transparent).onTapWidget(() {
            Navigator.pop(Get.context!);
            controller.rescheduleAppointment(therapySession);
          }),
          [
            ImagesConstant.cancelAppointmentCalendar.toSvg(),
            "Cancel appointment"
                .toHeading2(fontFamily: FontsConstant.appRegularFont)
          ]
              .toRow()
              .toSymmetricPadding(23.w, 10.h)
              .toContainer(color: Colors.transparent).onTapWidget(() {
                   Navigator.pop(Get.context!);
                   controller.cancelAppointment(therapySession);
                }
          ),
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .toSizedBoxHeight(0.35.sh),
        backgroundColor: AppColors.colorMagnolia,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false,
        persistent: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))));
  }
}
