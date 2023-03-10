import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/vents_replies_list_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/club/expandPost/expand_post_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/widgets/post_card.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';
import '../../../appUtils/app_util.dart';
import '../../../constants/fonts_constant.dart';
import '../../../constants/images_constant.dart';

class ExpandPostScreen extends GetView<ExpandPostController> {
  const ExpandPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      body: Obx(() => expandPostBody()),
    );
  }

  Widget expandPostBody() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.h.toSizedBoxVertical,
            ResponseWidgetsAnimator(
                apiCallStatus: controller.ventRepliesListApiStatus.value,
                loadingWidget: (){
                  return showProgress();
                },
                errorWidget: (){
                  return const SizedBox();
                },
                successWidget: (){
                  return topView();
                }
            ),
            25.h.toSizedBoxVertical,
            ResponseWidgetsAnimator(
                apiCallStatus: controller.ventRepliesListApiStatus.value,
                loadingWidget: (){
                  return showProgress();
                },
                errorWidget: (){
                  return const SizedBox();
                },
                successWidget: (){
                  return replyList();
                }
            ),
            25.h.toSizedBoxVertical,

          ],
        ).toSingleChildScrollView.toHorizontalPadding(33.w).toExpanded(),
        Obx(() =>  Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 25.h),
          decoration: const BoxDecoration(
              color:Color(0xFF2E2E2E)
          ),
          child: Row(
            children: [
              Obx(() => [
                controller.vent.value.isLiked!=null && controller.vent.value.isLiked!?ImagesConstant.heartActive.toSvg():
                ImagesConstant.heart24.toSvg(color: DarkThemeAppColors.colorWhite),
                5.w.toSizedBoxHorizontal,
                AppUtil.convertNumberToReadableFormat(controller.vent.value.likesCount!).toHeading3(color: DarkThemeAppColors.colorWhite)
              ].toRow().onTapWidget(() {
                controller.updateVent(controller.vent.value.id!, !controller.vent.value.isLiked!);
              })),
              20.w.toSizedBoxHorizontal,
              [
                ImagesConstant.reply24.toSvg(color: DarkThemeAppColors.colorWhite),
                5.w.toSizedBoxHorizontal,
                AppUtil.convertNumberToReadableFormat(controller.replyList.length).toHeading3(color: DarkThemeAppColors.colorWhite)
              ].toRow().onTapWidget(() {
                openReplyBottomSheet();
              }),
              20.w.toSizedBoxHorizontal,
              ImagesConstant.share24.toSvg().onTapWidget(() {
                controller.shareData(controller.vent.value.share!);
              }),
              20.w.toSizedBoxHorizontal,
              ImagesConstant.gift24.toSvg().onTapWidget(() {
                controller.getPlanList(controller.vent.value);
              }),
              20.w.toSizedBoxHorizontal,
            ],
          ),
        ))

      ],
    );
  }


  Widget topView()
  {
    return Obx(() => Column(
      children: [
        [
          [
            if(controller.vent.value.isAnonymous!=null && controller.vent.value.isAnonymous!) ...[
              "${controller.communityConfig.value.anonymousProfile}".toProfileNetWorkImage(width: 48.w,height: 48.h),
            ]else ...[
            "${controller.vent.value.image}".toProfileNetWorkImage(width: 48.w,height: 48.h),
          ],
            12.w.toSizedBoxHorizontal,
            [
              "${controller.vent.value.userName}".toHeading2(color: DarkThemeAppColors.colorTitle).toAlign(),
              AppUtil.getTimeAgo(controller.vent.value.ventTime!=null?controller.vent.value.ventTime!:"").toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont).toAlign(),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          ].toRow(),
          ImagesConstant.moreIcon.toSvg().onTapWidget(() {}).toVisibility(false)
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
        12.h.toSizedBoxVertical,
        "${controller.vent.value.message}".toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont,).toAlign(),
        40.h.toSizedBoxVertical,
        if(controller.vent.value.resourceObjects!=null && controller.vent.value.resourceObjects!.isNotEmpty) ...[
          resourceListView(controller.vent.value,cardColor: DarkThemeAppColors.colorBackgroundCard)
        ],
        40.h.toSizedBoxVertical,
        if(controller.replyList.isNotEmpty) ...[
          "Replies to @ ${controller.vent.value.userName}".toHeading1(color: DarkThemeAppColors.colorTitle).toAlign(),
        ]
      ],
    ));
  }

  Widget replyList()
  {
    return Column(
      children: [
        ListView.separated(
          itemCount: controller.replyList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return Padding(padding: EdgeInsets.only(top: 20.h));
          },
          itemBuilder: (context, index) {
            if(controller.replyList[index].locked!)
            {
              return replyLockedItem(controller.replyList[index]);
            }
            else
              {
                return replyItem(controller.replyList[index]);
              }

          },
        )
      ],
    );
  }

  Widget replyLockedItem(Reply reply)
  {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13.r)),
          color: const Color(0xFF383838)
      ),
      child: Column(
        children: [
          12.h.toSizedBoxVertical,
          [
            reply.avatar!.toProfileNetWorkImage(width: 48.w,height: 48.h),
            12.w.toSizedBoxHorizontal,
            [
              [
                reply.userName!.toHeading2(color: DarkThemeAppColors.colorTitle),
                5.w.toSizedBoxHorizontal,
                ImagesConstant.verifiedTherapist.toSvg(width: 20.w,height: 20.h).toVisibility(reply.verified!=null && reply.verified!?true:false)
              ].toRow(),
              AppUtil.getTimeAgo(reply.ventTime!).toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)

          ].toRow(),
          8.h.toSizedBoxVertical,
          if(controller.communityConfig.value.lockedContentImage?.ventReply!=null)
            controller.communityConfig.value.lockedContentImage!.ventReply!.toNetWorkBackgroundImage().onTapWidget(() {
              controller.redirectToPlanScreen();
            }),
         // reply.message!.toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont,).toAlign(),
          12.h.toSizedBoxVertical,
        ],
      ).toHorizontalPadding(16.w),
    ).onTapWidget(() {

    });
  }

  Widget replyItem(Reply reply)
  {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13.r)),
          color: const Color(0xFF383838)
      ),
      child: Column(
        children: [
          12.h.toSizedBoxVertical,
          [
            reply.avatar!.toProfileNetWorkImage(width: 48.w,height: 48.h),
            12.w.toSizedBoxHorizontal,
            [
              reply.userName!.toHeading2(color: DarkThemeAppColors.colorTitle),
              AppUtil.getTimeAgo(reply.ventTime!).toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)

          ].toRow(),
          8.h.toSizedBoxVertical,
          reply.message!.toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont,).toAlign(),
          12.h.toSizedBoxVertical,
          ],
      ).toHorizontalPadding(16.w),
    ).onTapWidget(() {

    });
  }

  openReplyBottomSheet() {
    return Get.bottomSheet(
        SingleChildScrollView(
          child:Obx(() =>  Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                decoration: const BoxDecoration(
                  color: Color(0xFF515151),
                ),
                child:"Replies to @ ${controller.anonymousSwitch.value?"anonymous":controller.userName}".toHeading3(color: DarkThemeAppColors.colorTitle).toAlign(alignment: Alignment.topLeft),
              ),
              26.h.toSizedBoxVertical,
              toTransparentTextFormField(controller: controller.postController, validator: null,fillColor: Colors.transparent,hintColor: DarkThemeAppColors.colorSubTitle,textColor: DarkThemeAppColors.colorTitle,hintText: "${controller.communityConfig.value.replyVentPlaceholder}",maxLines: 5,onChange: (value){
                if(value!=null && value.isNotEmpty)
                {
                  controller.isEnablePostButton.value= true;
                }
                else
                {
                  controller.isEnablePostButton.value= false;
                }
              }).toHorizontalPadding(20.w),
              40.h.toSizedBoxVertical,
              [
                Row(
                  children: [
                    CupertinoSwitch(
                      activeColor: DarkThemeAppColors.colorPrimary,
                      trackColor: DarkThemeAppColors.colorSubTitle,
                      thumbColor: DarkThemeAppColors.colorBackgroundScreen,
                      onChanged: (bool value) {
                        controller.anonymousSwitch.value = value;
                      },
                      value: controller.anonymousSwitch.value,
                    ),
                    8.w.toSizedBoxHorizontal,
                    "Posting as \n${controller.anonymousSwitch.value?"anonymous":controller.userName}".toHeading3(color: DarkThemeAppColors.colorTitle)
                  ],
                ),
                "Reply".toHeading2(color:DarkThemeAppColors.colorBlack).toSquareButton(() {
                  controller.sendPost();
                  Get.back();
                },enable: controller.isEnablePostButton.value)
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(20.w),

              26.h.toSizedBoxVertical,
            ],
          )),
        ),
        backgroundColor:  DarkThemeAppColors.colorBgBottomSheet,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false,
        persistent: false,

    );
  }
}
