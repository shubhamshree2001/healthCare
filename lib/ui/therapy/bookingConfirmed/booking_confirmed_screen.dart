import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/recommend_friend_rating_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/therapy_recommendations_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/bookingConfirmed/booking_confirmed_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';

import '../../../constants/fonts_constant.dart';
import '../../../constants/images_constant.dart';

class BookingConfirmedScreen extends GetView<BookingConfirmedController>
{
  const BookingConfirmedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () {
        return controller.redirectToTherapyScreen();
      },
      child: Scaffold(
        backgroundColor: AppColors.colorBackgroundScreen,
        appBar: CustomAppbar(voidCallback: ()=>controller.redirectToTherapyScreen()),
        body:Obx(() => bookingConfirmedBody())
      ),
    );
  }

  Widget bookingConfirmedBody()
  {
    return [
      if(controller.receiveParams.value.routes==Routes.therapyBooking) ...[
        76.h.toSizedBoxVertical,
        bookingConfirmedItem("Appointment Rescheduled","More details will be shown in your dashboard")
      ] else ...[
        Obx(() => ResponseWidgetsAnimator(
          apiCallStatus: controller.paymentApiCallStatus.value,
          loadingWidget: (){
            return showProgress().toCenter();
          },
          errorWidget: (){
            return Container();
          },
          successWidget: (){
            return   [
              76.h.toSizedBoxVertical,
              if(controller.receiveParams.value.routes==Routes.giftTherapyCheckout) ...[
                bookingConfirmedItem("Gift Sent Successfully",  StringsConstant.giftTherapySentToEmail)
              ]
              else ...[
                bookingConfirmedItem("Booking Confirmed","More details will be shown in your dashboard"),
              ],
              25.h.toSizedBoxVertical,
              if(controller.receiveParams.value.routes==Routes.therapyPaymentSummary) ...[
                recommendedToFriendView().toVisibility(controller.isHideRecommendation.value),
              ],
              25.h.toSizedBoxVertical,
            ].toColumn();
          },
        )
        ),
        // feedbackSubmitted(),
        //  37.h.toSizedBoxVertical,
        Obx(() => ResponseWidgetsAnimator(
            apiCallStatus: controller.therapyRecommendApiCallStatus.value,
            loadingWidget: (){
              return showProgress().toCenter();
            },
            errorWidget: (){
              return Container();
            },
            successWidget: (){
              return   [
                (controller.therapyRecommendations.value.title ?? "").toHeading1().toAlign(alignment: Alignment.topLeft),
                10.53.h.toSizedBoxVertical,
                (controller.therapyRecommendations.value.description??"").toHeading3(fontFamily: FontsConstant.appRegularFont).toAlign(alignment: Alignment.topLeft),
                30.h.toSizedBoxVertical,
                therapyResourcesListView(),
              ].toColumn();
            }
        )
        ),
      ],
      30.h.toSizedBoxVertical,
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toHorizontalPadding(33.w).toSingleChildScrollView.toSafeArea;
  }


  Widget bookingConfirmedItem(String title,String message)
  {
    return  [
      22.h.toSizedBoxVertical,
      [
        ImagesConstant.competedLarge.toSvg(height: 48.h,width: 48.w),
        20.w.toSizedBoxHorizontal,
        [
          title.toText(fontSize: 18.sp),
          5.h.toSizedBoxVertical,
          message.toHeading3(fontFamily: FontsConstant.notoSerifRegular),

        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toExpanded()

      ].toRow(mainAxisAlignment: MainAxisAlignment.start),
      18.h.toSizedBoxVertical,
    ].toColumn(mainAxisSize: MainAxisSize.min).toHorizontalPadding(24.w).toCard();
  }

  Widget feedbackSubmitted()
  {
    return  [
      22.h.toSizedBoxVertical,
      [
        ImagesConstant.competedLarge.toSvg(height: 48.h,width: 48.w),
        20.w.toSizedBoxHorizontal,
        [
          "Feedback Submitted".toText(fontSize: 18.sp),
          5.h.toSizedBoxVertical,
          "Thank you for submitting your feedback".toHeading3(fontFamily: FontsConstant.notoSerifRegular),

        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toExpanded()

      ].toRow(mainAxisAlignment: MainAxisAlignment.start),
      18.h.toSizedBoxVertical,
    ].toColumn(mainAxisSize: MainAxisSize.min).toHorizontalPadding(24.w).toCard();
  }


  Widget recommendedToFriendView()
  {
    return  [
      22.h.toSizedBoxVertical,
      "How likely are you to recommend MindPeers to a friend?".toHeading2(),
      20.h.toSizedBoxVertical,
      GridView.builder(
          itemCount: controller.recommendedRatingList.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:  5,
            crossAxisSpacing: 25.0,
            mainAxisSpacing: 18.0,
          ),
          itemBuilder: (context,index){
            return recommendedRatingItem(controller.recommendedRatingList[index], index);
          }
      ),
      22.h.toSizedBoxVertical,

    ].toColumn(mainAxisSize: MainAxisSize.min).toHorizontalPadding(24.w).toCard();
  }

  Widget recommendedRatingItem(RecommendFriendRating item,int index)
  {
    return Obx(() => "${item.rating}".toHeading3().toPadding(5).toAlign(alignment: Alignment.center
    ).toContainer(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color:controller.selectedRatingIndex.value==index?item.colorBorder:Colors.transparent ,width: 1),
            color: controller.selectedRatingIndex.value==index?item.colorActive:item.colorInactive
        )
    ).onTapWidget(() {
      controller.selectedRatingIndex.value=index;
      controller.hideRecommendedView();
    }));
  }

  Widget therapyResourcesListView()
  {
    return ListView.separated(
      itemCount: controller.recommendationList.length,
       shrinkWrap: true,
       physics: const NeverScrollableScrollPhysics(),
       separatorBuilder: (context,index){
        return Padding(padding: EdgeInsets.only(top: 30.h));
       },
        itemBuilder: (context,index){
         return therapyResourceItem(controller.recommendationList[index],index);
        },
    );
  }

  Widget therapyResourceItem(Recommendation recommendation,int index)
  {
    return [
      [
        Stack(
          children: [
            Row(
              children: [
                recommendation.image!.toRoundedNetWorkImage(height: 90.h,width: 90.w,borderRadius: 8.r).toAlign(alignment: Alignment.topLeft).paddingOnly(left: 17.w,top: 20.h,bottom: 30.h),
                "${recommendation.title}".toHeading1().toAlign(alignment: Alignment.center).toPaddingOnly(top: 20.h,bottom: 20.h,left: 30.w,right: 40.w).toExpanded(),
              ],
            ),
            ImagesConstant.locked.toSvg().toAlign(alignment: Alignment.topRight).toVisibility(recommendation.locked!),
            Container(
                decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                    borderRadius: BorderRadius.circular(25.r)
                ),
              child: "${recommendation.kind}".toHeading4().toSymmetricPadding(8.w,5.h),
            ).toAlign(alignment: Alignment.bottomRight).toPositioned(bottom: 10,right: 10)
          ],
        ).toExpanded()
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
    ].toColumn().toContainer(
        decoration: BoxDecoration(
            color: AppColors.colorHawkesBlue,
            borderRadius: BorderRadius.all(Radius.circular(8.r))
        )
    );
  }
}

