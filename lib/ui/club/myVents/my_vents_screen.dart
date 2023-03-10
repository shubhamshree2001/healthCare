import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/club/widgets/empty_vent.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import '../../../constants/images_constant.dart';
import '../../../constants/strings_constant.dart';
import '../../../data/models/clubModels/vent_list_response.dart';
import '../../../widgets/response_widget_animator.dart';
import '../widgets/post_card.dart';
import 'my_vents_controller.dart';

class MyVentsScreen extends GetView<MyVentController>
{
  const MyVentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
      appBar:CustomDarkAppbar(voidCallback: (){Get.back();}),
      body: Obx(() => myVentsScreenBody()),
    );
  }

  myVentsScreenBody()
  {
    return Column(
      children: [
        23.h.toSizedBoxVertical,
        "My Vents".toHeading1(color: DarkThemeAppColors.colorTitle).toAlign(alignment: Alignment.topLeft),
        27.h.toSizedBoxVertical,
        ResponseWidgetsAnimator(
          apiCallStatus: controller.ventListApiStatus.value,
          loadingWidget: (){
            return showProgress();
          },
          errorWidget: (){
            return const EmptyVent();
          },
          successWidget:(){
            return myVentsScreen();
          },
        ).toExpanded(),

        20.h.toSizedBoxVertical,
      ],
    ).toHorizontalPadding(33.w).toSafeArea;
  }


  Widget myVentsScreen()
  {
    return Obx(() =>  ListView.separated(
      itemCount: controller.ventList.length,
      separatorBuilder: (context,index){
        return Padding(padding: EdgeInsets.only(top: 20.h));
      },
      itemBuilder: (context,index){
        return postCardType(controller.ventList[index], index);
      },
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
      controller.shareData(vent.share!);
    }, onTabLike: () {
      controller.selectedVentIndex.value = index;
      controller.updateVent(vent.id!, !vent.isLiked!,null,null,null);
    }, onTabVent: () {
      controller.redirectToExpandPostScreen(vent.id!);
    }, onTabSendGift: () {
      if(controller.communityConfig.value.sendGiftMessage!=null && controller.communityConfig.value.sendGiftMessage!.isNotEmpty)
      {
        controller.getPlanList(vent);
      }

    },isShowMore: true, onTabMoreOption: () {
      openMoreOptionBottomSheet(vent,index);
    });
  }

  openMoreOptionBottomSheet(Vent vent,int index) {
    return Get.bottomSheet(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const Divider(color: Color(0xFFC5C5C5),thickness: 4,).toSizedBoxWidth(42.w).toCenter(),
                SizedBox(height: 43.33.h),
                [
                  (vent.isAnonymous!?ImagesConstant.eye:ImagesConstant.hideEye).toSvg(color: DarkThemeAppColors.colorWhite),
                  16.w.toSizedBoxHorizontal,
                  (vent.isAnonymous!?"Show name":"Anonymous post").toHeading2(color: DarkThemeAppColors.colorTitle)
                ].toRow().onTapWidget(() {
                  controller.updateVent(vent.id!, null, !vent.isAnonymous!, null,null);
                  Get.back();
                }),
                SizedBox(height: 47.h),
                [
                  ImagesConstant.delete.toSvg(color: DarkThemeAppColors.colorWhite),
                  16.w.toSizedBoxHorizontal,
                  "Delete".toHeading2(color: DarkThemeAppColors.colorTitle)
                ].toRow().onTapWidget(() {
                  Get.back();
                 controller.deleteVentConfirmationDialog(vent);
                }),
                SizedBox(height: 47.h),
                [
                  ImagesConstant.flag.toSvg(color: DarkThemeAppColors.colorWhite),
                  16.w.toSizedBoxHorizontal,
                  (vent.isSensitive!?"Remove Trigger warning":"Add Trigger warning").toHeading2(color: DarkThemeAppColors.colorTitle)
                ].toRow().onTapWidget(() {
                  controller.updateVent(vent.id!, null, null,!vent.isSensitive!,null);
                  Get.back();
                }),
                SizedBox(height: 37.h),
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