import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_list_response.dart';
import 'package:mindpeers_mobile_flutter/enum/app_enum.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/club/more_clubs/more_club_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';
import 'package:skeletons/skeletons.dart';
import '../../../appUtils/app_util.dart';
import '../../../constants/fonts_constant.dart';

class MoreClubScreen extends GetView<MoreClubController> {
  const MoreClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
      body: Obx(() => moreClubScreenBody()),
    );
  }

  Widget moreClubScreenBody() {
    return Column(
      children: [
        20.h.toSizedBoxVertical,
        "Explore more clubs"
            .toHeading1(color: DarkThemeAppColors.colorTitle)
            .toAlign(alignment: Alignment.topLeft)
            .toHorizontalPadding(33.w),
        24.h.toSizedBoxVertical,
        ResponseWidgetsAnimator(
            apiCallStatus: controller.communityListApiStatus.value,
            loadingWidget: () {
              if (controller.communityOffset > 0) {
                return Obx(() => [
                      moreClubList().toHorizontalPadding(33.w),
                      showProgress().toCenter()
                    ].toColumn());
              } else {
                return moreClubSkeleton();
              }
            },
            errorWidget: () {
              return const SizedBox();
            },
            successWidget: () {
              return moreClubList().toHorizontalPadding(33.w);
            }).toExpanded(),
        20.h.toSizedBoxVertical
      ],
    ).toSafeArea;
  }

  Widget moreClubList() {
    return Obx(() => ListView.separated(
        controller: controller.scrollController,
        itemCount: controller.communityList.length,
        separatorBuilder: (context, index) {
          return Padding(padding: EdgeInsets.only(top: 20.h));
        },
        itemBuilder: (context, index) {
          return moreClubItem(index);
        }));
  }

  Widget moreClubItem(int index) {
    return Obx(() => Column(
          children: [
            Stack(
              children: [
                controller.communityList[index].image!.banner!
                    .toNetWorkBackgroundImage(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    [
                      overlapProfileView(index),
                      15.w.toSizedBoxHorizontal,
                      "${AppUtil.convertNumberToReadableFormat(controller.communityList[index].follower!.followerCount!)} ${controller.communityList[index].follower!.followerText!}"
                          .toHeading4(
                              color: DarkThemeAppColors.colorBlack,
                              fontFamily: FontsConstant.appRegularFont),
                    ].toRow(),
                    Obx(() => (controller.communityList[index].follow!
                        ? "Following"
                        : "Follow")
                        .toHeading4(color: DarkThemeAppColors.colorBlack)
                        .toCenter()).toRoundedButtonIcon(() {
                      controller.selectedIndex.value =index;
                      controller.updateFollowStatus(controller.communityList[index].id!, !controller.communityList[index].follow!);
                    },verticalPadding: 5.h,horizontalPadding: 10.w,isVisibleIcon: controller.communityList[index].follow!)
                  ],
                ).toPositioned(bottom: 18.h, left: 13.w, right: 13.w),
              ],
            ),
            16.h.toSizedBoxVertical,
            "${controller.communityList[index].name}"
                .toHeading2(color: DarkThemeAppColors.colorTitle)
                .toAlign(alignment: Alignment.topLeft),
            8.h.toSizedBoxVertical,
            "${controller.communityList[index].description}"
                .toHeading3(
                    color: DarkThemeAppColors.colorTitle,
                    fontFamily: FontsConstant.appRegularFont)
                .toAlign(alignment: Alignment.topLeft),
          ],
        ).onTapWidget(() {
          controller.backToVentScreen(controller.communityList[index]);
        }));
  }

  Widget overlapProfileView(int index) {
    if (controller.communityList[index].follower!.followerImages != null &&
        controller.communityList[index].follower!.followerImages!.isNotEmpty) {
      if (controller.communityList[index].follower!.followerImages!.length >
          1) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 24.h,
              width: 24.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: DarkThemeAppColors.colorPrimary, width: 2.w)),
              child: controller
                  .communityList[index].follower!.followerImages![0]
                  .toProfileRoundedNetWorkImage(),
            ),
            Container(
              height: 24.h,
              width: 24.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: DarkThemeAppColors.colorPrimary, width: 2.w)),
              child: controller
                  .communityList[index].follower!.followerImages![1]
                  .toProfileRoundedNetWorkImage(),
            ).toPositioned(left: 10.w),
          ],
        );
      } else {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 24.h,
              width: 24.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: DarkThemeAppColors.colorPrimary, width: 2.w)),
              child: controller
                  .communityList[index].follower!.followerImages![0]
                  .toProfileRoundedNetWorkImage(),
            ),
          ],
        );
      }
    } else {
      return const SizedBox();
    }
  }

  Widget moreClubSkeleton() {
    return SkeletonListView(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Column(
          children: [
            20.h.toSizedBoxVertical,
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  shape: BoxShape.rectangle, width: 1.sw, height: 150.h),
            ),
            15.h.toSizedBoxVertical,
            const SkeletonLine(
              style: SkeletonLineStyle(
                height: 5,
                width: 90,
              ),
            ),
            5.h.toSizedBoxVertical,
            const SkeletonLine(
              style: SkeletonLineStyle(
                height: 5,
                maxLength: 2,
              ),
            )
          ],
        );
      },
    ).toHorizontalPadding(20.w);
  }
}
