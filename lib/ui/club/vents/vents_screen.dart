import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/vent_list_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/club/vents/vents_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/widgets/post_card.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';
import '../../../constants/strings_constant.dart';
import '../../../data/models/clubModels/community_info_response.dart';
import '../../../repository/clubRepo/club_repo_impl.dart';
import '../../../service/graph_ql_configuration.dart';
import '../../../widgets/skelton_loader.dart';

class VentsScreen extends GetView<VentsController>
{
  const VentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(VentsController(clubRepo: Get.put(ClubRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
    return Scaffold(
      backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
      body: Obx(() => ventScreenBody()),
      floatingActionButton: Obx(() => SpeedDial(
        children: [
          SpeedDialChild(
              child: ImagesConstant.myVents.toSvg(),
              labelWidget: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 10.w),
                // height: 20,
                decoration: BoxDecoration(
                  color: DarkThemeAppColors.colorWhite,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: "My Vents".toHeading3(),
              ),
              onTap: (){
                controller.redirectToMyVentScreen();
              }
          ),
          SpeedDialChild(
              child: ImagesConstant.pencil.toSvg(),
              labelWidget: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 10.w),
                // height: 20,
                decoration: BoxDecoration(
                  color: DarkThemeAppColors.colorWhite,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: "Write a vent".toHeading3(),
              ),
              onTap: (){
                controller.redirectToPostVentScreen();
              }
          ),
        ],
        backgroundColor: DarkThemeAppColors.colorPrimary,
        overlayColor: Colors.transparent,
        spacing: 10,
        onPress: !controller.isHaveMyVents.value?(){
          controller.redirectToPostVentScreen();
        }:null,
        onOpen: (){
        },
        onClose: (){

        },
        activeChild: ImagesConstant.cross.toSvg(),
        child: ImagesConstant.plusIcon.toSvg(),
      ),)
    );
  }

  Widget ventScreenBody()
  {
    return Stack(
      children: [
       Column(
    children: [
    14.h.toSizedBoxVertical,
      ResponseWidgetsAnimator(
        apiCallStatus: controller.communityListApiStatus.value,
        loadingWidget: (){
          return clubListSkeleton().toSizedBoxHeight(127.h);
        },
        errorWidget: (){
          return const SizedBox();
        },
        successWidget:(){
          return clubListTopView();
        },
      ),
      [
        37.h.toSizedBoxVertical,
        ResponseWidgetsAnimator(
          apiCallStatus: controller.ventListApiStatus.value,
          loadingWidget: (){
            if (controller.ventOffset > 0) {
              return ventList();
            } else {
              return showProgress();
            }
          },
          errorWidget: (){
            return const SizedBox();
          },
          successWidget:(){
            return ventList();
          },
        ),
        28.h.toSizedBoxVertical,
      ].toColumn().toHorizontalPadding(30.w)

      ],
    ).toSingleChildScrollView.toSafeArea,

       if(controller.community.value.hasNewContent?.color!=null && controller.community.value.hasNewContent!.color!.isNotEmpty) ...[
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             "New Post".toHeading3(color: DarkThemeAppColors.colorBlack).toRoundedButtonIcon(() {
               controller.getVentList(controller.community.value.id!);
             }).toCenter().toPositioned(top: 250.h)
           ],
         )
       ]
      ],
    );
  }

  Widget clubListTopView()
  {
    return Obx(() => Column(
      children: [
        roundedClubList().toSizedBoxHeight(140.h),
        16.5.h.toSizedBoxVertical,
        const Divider(color: DarkThemeAppColors.colorSubTitle,thickness: 0.5),
        23.5.h.toSizedBoxVertical,
        [
          [
            controller.community.value.name!.toHeading2(color: DarkThemeAppColors.colorTitle),
            [
              overlapProfileView(),
              15.w.toSizedBoxHorizontal,
              if(controller.community.value.follower?.followerCount!=null && controller.community.value.follower?.followerText!=null ) ...[
                "${AppUtil.convertNumberToReadableFormat(controller.community.value.follower!.followerCount!)} ${controller.community.value.follower!.followerText!}".toHeading4(color: DarkThemeAppColors.colorTitle,fontFamily: FontsConstant.appRegularFont),
              ]
            ].toRow().onTapWidget(() { openAboutBottomSheet();})
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
          20.5.h.toSizedBoxVertical,
          [
            TextButton.icon(
                onPressed: (){
                  controller.updateFollowStatus(controller.community.value.id!, !controller.community.value.follow!);
                },
                icon: ImagesConstant.checked24.toSvg(color: DarkThemeAppColors.colorWhite).toVisibility(controller.community.value.follow!),
                label: (controller.follow.value?"Following":"Follow").toHeading3(color: DarkThemeAppColors.colorTitle).toPaddingOnly(left: 4.w,right: 8.w),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.r),
                          side:  const BorderSide(
                              color: DarkThemeAppColors.colorPrimary,
                              width: 2
                          )
                      )
                  ),
                )
            ),
            [
              TextButton.icon(
                onPressed: (){
                  controller.shareData(controller.community.value.share!);
                },
                icon: ImagesConstant.share24.toSvg(color: DarkThemeAppColors.colorWhite),
                label: "Share".toHeading3(color: DarkThemeAppColors.colorTitle),
              ),
              TextButton.icon(
                onPressed: (){
                  openAboutBottomSheet();
                  },
                icon: ImagesConstant.info.toSvg(color: DarkThemeAppColors.colorWhite),
                label: "About".toHeading3(color: DarkThemeAppColors.colorTitle),
              ),
            ].toRow()
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
        ].toColumn().toHorizontalPadding(30.w)
      ],
    ));
  }

  Widget roundedClubList()
  {
    return Obx(() => ListView.separated(
        controller: controller.scrollController,
        itemCount: controller.communityList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        separatorBuilder: (context,index){
          return Padding(padding: EdgeInsets.only(left: 23.r));
        },
        itemBuilder: (context,index)
        {
          if(index==0)
          {
            return moreClubItem(controller.communityList[index]);
          }
          return roundedClubItem(index);
        }
    ).toPaddingOnly(left: 30.w,right: 10.w));
  }


  Widget roundedClubItem(int index)
  {
    return Obx(() => Stack(
      children: [
        Column(
          children: [
            Container(
              height: 84.h,
              width: 84.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: controller.communityList[index].isSelected?DarkThemeAppColors.colorPrimary:Color(0xFF2E2E2E),width: 5.w)
              ),
              child: controller.communityList[index].image!.icon!.toNetWorkImage().toPadding(2),
            ),
            10.h.toSizedBoxVertical,
            controller.communityList[index].name!.toHeading4(fontFamily: controller.communityList[index].isSelected?FontsConstant.appBoldFont:FontsConstant.appRegularFont,color: controller.communityList[index].isSelected?DarkThemeAppColors.colorTitle:DarkThemeAppColors.colorSubTitle,textAlign: TextAlign.center).toCenter().toExpanded()
          ],
        ).toSizedBoxWidth(100.w).onTapWidget((){
          controller.communityList[index].hasNewContent?.color=null;
          controller.isIntervalStart.value =false;
          controller.handleClubList(index);
        }),

        if(controller.communityList[index].hasNewContent?.color!=null && controller.communityList[index].hasNewContent!.color!.isNotEmpty) ...[
          Container(
            height: 17.h,
            width: 17.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFF8556)
            ),
          ).toPositioned(right: 20)
        ]

      ],
    )
    );
  }

  Widget moreClubItem(Community community)
  {
    return Column(
      children: [
        Container(
          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
          height: 84.h,
          width: 84.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color:const Color(0xFF2E2E2E),width: 5.w)
          ),
          child: community.image!.icon!.toNetWorkImage().toPadding(2),
        ),
        19.h.toSizedBoxVertical,
        community.name!.toHeading4(fontFamily: FontsConstant.appRegularFont,color:DarkThemeAppColors.colorSubTitle)
      ],
    ).onTapWidget(()=>controller.redirectToMoreClubScreen());
  }



  Widget overlapProfileView()
  {
    if(controller.community.value.follower?.followerImages!=null && controller.community.value.follower!.followerImages!.isNotEmpty)
      {
        if(controller.community.value.follower?.followerImages !=null && controller.community.value.follower!.followerImages!.length>1)
          {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 24.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: DarkThemeAppColors.colorPrimary,width: 2.w)
                  ),
                  child: controller.community.value.follower?.followerImages![0].toProfileRoundedNetWorkImage(),
                ),
                Container(
                  height: 24.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: DarkThemeAppColors.colorPrimary,width: 2.w)
                  ),
                  child: controller.community.value.follower!.followerImages![1].toProfileRoundedNetWorkImage(),
                ).toPositioned(left: 10.w),
              ],
            );
          }
        else
          {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 24.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: DarkThemeAppColors.colorPrimary,width: 2.w)
                  ),
                  child: controller.community.value.follower!.followerImages![0].toProfileRoundedNetWorkImage(),
                ),
              ],
            );
          }
      }
    else
      {
        return const SizedBox();
      }
  }

  Widget ventList()
  {
    return Obx(() => ListView.separated(
        controller: controller.ventScrollController,
        itemCount:  controller.isCommunityLocked.value?controller.ventList.length+1:controller.ventList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context,index){
          return Padding(padding: EdgeInsets.only(top: 20.r));
        },
        itemBuilder: (context,index)
        {
          if(controller.isCommunityLocked.value && index == controller.ventList.length)
            {
              if(controller.communityConfig.value.lockedContentImage?.vent!=null && controller.communityConfig.value.lockedContentImage!.vent!.isNotEmpty)
                {
                  return controller.communityConfig.value.lockedContentImage!.vent!.toNetWorkBackgroundImage().onTapWidget(() {
                    Get.toNamed(Routes.plan);
                  });
                }
            }
          return postCardType(controller.ventList[index], index);
        }
    ));
  }


  Widget postCardType(Vent vent,int index)
  {
    switch(vent.type)
    {
      case VentCardType.welcome:
        return welcomeCard(vent);
      case VentCardType.ventCard:
        return ventCardType(vent,index);
      case VentCardType.promoCard:
        return promoCard(vent);
      default:
        return SizedBox();
    }
  }

  Widget ventCardType(Vent vent,int index)
  {
    return ventCard(vent,onTabSensitive: (){
      vent.isSensitive = false;
      controller.ventList[index] = vent;
    }, onTabShare: () {
      controller.shareData(vent.share);
    }, onTabLike: () {
      controller.selectedVentIndex.value = index;
      controller.updateVent(vent.id!, !vent.isLiked!);
    }, onTabVent: () {
       controller.redirectToExpandPostScreen(vent.id!);
    }, onTabSendGift: () {
      if(controller.communityConfig.value.sendGiftMessage!=null && controller.communityConfig.value.sendGiftMessage!.isNotEmpty)
        {
          controller.getPlanList(vent);
        }

    }, onTabMoreOption: () {  });
  }


  openAboutBottomSheet() {
    return Get.bottomSheet(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const Divider(color: Color(0xFFC5C5C5),thickness: 4,).toSizedBoxWidth(42.w).toCenter(),
                SizedBox(height: 23.33.h),
                "About this club".toHeading1(color: DarkThemeAppColors.colorTitle).toCenter(),
                SizedBox(height: 29.h),
                [
                  "${controller.communityInfo.value.name}".toHeading3(color: DarkThemeAppColors.colorTitle),
                  Obx(() => (controller.follow.value
                      ? "Following"
                      : "Follow")
                      .toHeading4(color: DarkThemeAppColors.colorBlack)
                      .toCenter()).toRoundedButtonIcon(() {
                    controller.updateFollowStatus(controller.community.value.id!, !controller.community.value.follow!);
                  },verticalPadding: 5.h,horizontalPadding: 10.w,isVisibleIcon:false)
                ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                SizedBox(height: 19.h),
                "${controller.communityInfo.value.description}".toHeading3(fontFamily: FontsConstant.appRegularFont,color: DarkThemeAppColors.colorSubTitle),
                SizedBox(height: 22.h),
                if(controller.communityInfo.value.moderators!=null && controller.communityInfo.value.moderators!.isNotEmpty) ...[
                  facilitatorListview()
                ],
                20.h.toSizedBoxVertical,
                [
                  overlapProfileView(),
                  30.w.toSizedBoxHorizontal,
                  if(controller.community.value.follower?.followerCount!=null && controller.community.value.follower?.followerText!=null ) ...[
                    "${AppUtil.convertNumberToReadableFormat(controller.community.value.follower!.followerCount!)} ${controller.community.value.follower!.followerText!}".toHeading4(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont),
                  ]

                 /* if(controller.communityInfo.value.follower?.followerText!=null && controller.communityInfo.value.follower?.followerCount!=null) ...[
                    "${controller.communityInfo.value.follower?.followerCount!} ${controller.communityInfo.value.follower?.followerText!}".toHeading4(color: DarkThemeAppColors.colorBlack,fontFamily: FontsConstant.appRegularFont),
                  ]*/
                ].toRow(),
                35.h.toSizedBoxVertical,
                [
                  [
                    ImagesConstant.reportIssueIcon.toSvg(color: DarkThemeAppColors.colorTitle),
                    "Report an Issue".toHeading4(color: DarkThemeAppColors.colorTitle,textDecoration: TextDecoration.underline)
                  ].toRow().onTapWidget(() {
                    Get.back();
                    if(controller.communityConfig.value.feedback!=null)
                      {
                        openReportAnIssueBottomSheet();
                      }

                  }),
                  if(controller.communityInfo.value.resources!=null && controller.communityInfo.value.resources!.isNotEmpty) ...[
                    "View worksheets".toHeading3(color: DarkThemeAppColors.colorBackgroundScreen).toCenter().toSquareButton(() {
                      Get.back();
                      controller.redirectToWorksheetScreen();
                    },horizontalPadding: 10.w,verticalPadding: 15.h)
                  ]
                ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                26.h.toSizedBoxVertical,
              ],
            ),
          ),
        ),
        backgroundColor: DarkThemeAppColors.colorBgBottomSheet,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false,
        persistent: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))));
  }

  Widget facilitatorListview()
  {
    return ListView.separated(
        itemCount: controller.communityInfo.value.moderators!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context,index){
          return Padding(padding: EdgeInsets.only(top: 10.h));
        },
      itemBuilder: (context,index){
          return facilitatorItem(controller.communityInfo.value.moderators![index]);
      },
    );
  }

  Widget facilitatorItem(Moderator moderator)
  {
    return [
      Container(
        height: 38.h,
        width: 38.w,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: "${moderator.photo}".toProfileRoundedNetWorkImage(),
      ),
      18.w.toSizedBoxHorizontal,
      [
        [
          "${moderator.name}".toHeading4(color: DarkThemeAppColors.colorTitle).toAlign(alignment: Alignment.topLeft),
          8.w.toSizedBoxHorizontal,
          ImagesConstant.verifiedTherapist.toSvg().toVisibility(moderator.verified!)
        ].toRow(),
        "${moderator.title}".toHeading4(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont)
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)

    ].toRow();
  }


  openReportAnIssueBottomSheet() {
    return Get.bottomSheet(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const Divider(color: Color(0xFFC5C5C5),thickness: 4,).toSizedBoxWidth(42.w).toCenter(),
                SizedBox(height: 37.33.h),
                "${controller.communityConfig.value.feedback!.question}".toHeading2(color: DarkThemeAppColors.colorTitle),
                SizedBox(height: 18.5.h),
                toTransparentTextFormField(controller:controller.feedbackController, validator: null,maxLines: 7,textColor: DarkThemeAppColors.colorBlack),
                SizedBox(height: 26.5.h),
                "Send feedback".toHeading3(color: DarkThemeAppColors.colorBackgroundScreen).toSquareButton(() {
                  controller.sendFeedback();
                  },horizontalPadding: 10.w).toAlign(alignment: Alignment.bottomRight),
                26.h.toSizedBoxVertical,
              ],
            ),
          ),
        ),
        backgroundColor: DarkThemeAppColors.colorBgBottomSheet,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false,
        persistent: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))));
  }


}