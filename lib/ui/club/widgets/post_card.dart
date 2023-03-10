import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_config_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import '../../../constants/fonts_constant.dart';
import '../../../constants/images_constant.dart';
import '../../../data/models/clubModels/vent_list_response.dart';
import '../../../theme/dark_theme_app_color.dart';

 Widget welcomeCard(Vent vent)
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
            vent.avatar!.toRoundedNetWorkImage(width: 48.w,height: 48.h),
            12.w.toSizedBoxHorizontal,
            vent.userName!.toHeading2(color: DarkThemeAppColors.colorTitle),
          ].toRow(),
          8.h.toSizedBoxVertical,
          vent.message!.toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont),
          23.h.toSizedBoxVertical,
          "${vent.cta?.text}".toHeading2(color: DarkThemeAppColors.colorBackgroundScreen).toSquareButton(() {
            Get.toNamed(Routes.newPost);
          }),
            16.h.toSizedBoxVertical,
        ],
      ).toHorizontalPadding(16.w),
    ).onTapWidget(() {
    });
  }

  Widget ventCard(
      Vent vent,{
        required VoidCallback onTabSensitive,
        required VoidCallback onTabShare,
        required VoidCallback onTabLike,
        required VoidCallback onTabVent,
        required VoidCallback onTabSendGift,
        required VoidCallback onTabMoreOption,
        bool isShowMore = false
      })
  {

    CommunityConfig communityConfig = LocalStorage.getCommunityConfig();
    String likeUrl = communityConfig.reactions![0].coloredUrl!;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13.r)),
          color: const Color(0xFF383838)
      ),
      child: Column(
        children: [
          12.h.toSizedBoxVertical,
          [
            [
              vent.avatar!.toRoundedNetWorkImage(width: 48.w,height: 48.h),
              12.w.toSizedBoxHorizontal,
              [
                (vent.isAnonymous!?"Anonymous":vent.userName!).toHeading2(color: DarkThemeAppColors.colorTitle),
                AppUtil.getTimeAgo(vent.ventTime!).toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont),
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)

            ].toRow(),

            ImagesConstant.pin.toSvg().onTapWidget(() {}).toVisibility(vent.pinned!),
            if(isShowMore) ...[
              ImagesConstant.moreIcon.toSvg().onTapWidget(onTabMoreOption).toVisibility(isShowMore)
            ],
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toHorizontalPadding(16.w),
          8.h.toSizedBoxVertical,
          Stack(
            children: [
              [
                if(vent.message!.length>132) ...[
                  vent.message!.substring(0,131).toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont).toAlign(),
                ] else ...[
                  vent.message!.toHeading3(color: DarkThemeAppColors.colorSubTitle,fontFamily: FontsConstant.appRegularFont).toAlign(),
                ],
                if(countNumberOfLines(vent.message!)>2 || vent.message!.length>132) ...[
                  1.h.toSizedBoxVertical,
                  "… more".toHeading3(color: const Color(0xFF00DFEB),fontFamily: FontsConstant.appRegularFont).toAlign(alignment: Alignment.topLeft),
                ]
              ].toColumn().toHorizontalPadding(16.w),
              sensitiveView().onTapWidget(onTabSensitive).toVisibility(vent.isSensitive!)
            ],
          ),
          if(vent.resourceObjects!=null && vent.resourceObjects!.isNotEmpty) ...[
            resourceListView(vent).toPaddingOnly(top:16.h).toHorizontalPadding(16.w),
          ],
          16.h.toSizedBoxVertical,
          Row(
            children: [
              [
                vent.isLiked!?ImagesConstant.heartActive.toSvg():
                ImagesConstant.heart24.toSvg(color: DarkThemeAppColors.colorWhite),
                5.w.toSizedBoxHorizontal,
                AppUtil.convertNumberToReadableFormat(vent.likesCount!).toHeading3(color: DarkThemeAppColors.colorWhite)
              ].toRow().onTapWidget(onTabLike).toExpanded(),
              [
                ImagesConstant.reply24.toSvg(color: DarkThemeAppColors.colorWhite),
                5.w.toSizedBoxHorizontal,
                AppUtil.convertNumberToReadableFormat(vent.repliesCount!).toHeading3(color: DarkThemeAppColors.colorWhite)
              ].toRow().toExpanded(),
              [
                ImagesConstant.share24.toSvg(color: DarkThemeAppColors.colorWhite).onTapWidget(onTabShare),
                5.w.toSizedBoxHorizontal,
                "".toHeading2()
              ].toRow().toExpanded(),
              if(vent.isGiftingEnabled!) ...[
                [
                  ImagesConstant.gift24.toSvg(color: DarkThemeAppColors.colorWhite).onTapWidget(onTabSendGift),
                  5.w.toSizedBoxHorizontal,
                  "".toHeading2()
                ].toRow().toExpanded()
              ]

            ],
          ).toHorizontalPadding(10.w).toHorizontalPadding(16.w),

          12.h.toSizedBoxVertical,
        ],
      ),
    ).onTapWidget(onTabVent);
  }

  Widget promoCard(Vent vent)
  {
    return  Stack(
      alignment: Alignment.center,
      children: [
        "${vent.backgroundImage}".toNetWorkBackgroundImage(),
        [
          "${vent.text}".toHeading2(color: DarkThemeAppColors.colorBlack).toExpanded(),
          "${vent.image}".toNetWorkImage()
        ].toRow().toSymmetricPadding(20.w, 20.h).onTapWidget(() {
          Get.toNamed(Routes.plan);
        }
        )
      ],
    );
  }


  Widget resourceListView(Vent vent,{Color cardColor=DarkThemeAppColors.colorBackgroundScreen})
  {
    return ListView.separated(
        itemCount: vent.resourceObjects!.length,
       physics: const NeverScrollableScrollPhysics(),
       shrinkWrap: true,
       separatorBuilder: (context,index){
        return Padding(padding: EdgeInsets.only(top: 5.h));
       },
        itemBuilder: (context,index){
          return resourceItem(index,vent,cardColor);
        },
    );
  }

  Widget resourceItem(int index,Vent vent,Color cardColor)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 16.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.all(Radius.circular(13.r)),
      ),
      child: Column(
        children: [
          ImagesConstant.openLink.toSvg(color: DarkThemeAppColors.colorWhite).toAlign(alignment: Alignment.topRight),
          ImagesConstant.fileIcon.toSvg().toAlign(alignment: Alignment.center),
          18.h.toSizedBoxVertical,
          vent.resourceObjects![index].name!.toHeading3(color: DarkThemeAppColors.colorTitle).toAlign(alignment: Alignment.center),
        ],
      ),
    ).onTapWidget(() async {
      if(vent.resourceObjects![index].locked!=null && vent.resourceObjects![index].locked!){
        Get.toNamed(Routes.plan);
      }
      else if(vent.resourceObjects![index].url!=null && vent.resourceObjects![index].url!.isNotEmpty)
        {
          launchWebUrl(vent.resourceObjects![index].url!);
        }
    });
  }

  Widget sensitiveView()
  {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
      decoration: BoxDecoration(
         color: const Color(0xFF383838).withOpacity(0.9),
          boxShadow: const [
            BoxShadow(
              //offset: Offset(2, 2),
              blurRadius: 10,
              blurStyle: BlurStyle.inner,
            )
          ]
      ),
      child: Column(
        children: [
          "This post may contain sensitive content".toHeading3(fontFamily: FontsConstant.appRegularFont,color: DarkThemeAppColors.colorSubTitle),
          7.h.toSizedBoxVertical,
          ImagesConstant.hideEye.toSvg(color: DarkThemeAppColors.colorWhite,width: 30,height: 30),
          17.h.toSizedBoxVertical,
          "View anyway".toHeading3(color: DarkThemeAppColors.colorTitle,textDecoration: TextDecoration.underline),

        ],
      ),
    );
  }


  int  countNumberOfLines(String text)
  {
    final numLines = '\n'.allMatches(text).length + 1;
    return numLines;
  }
