import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/club/club_controller.dart';
class NewClubWidget extends GetWidget<ClubController>
{
  const NewClubWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: controller.featureInfoScreen.value.asset!.length,
          options: CarouselOptions(
              onPageChanged: (index, reason) {
                controller.selectedNewClubItem.value=index;
              },
              enlargeCenterPage: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1,
              autoPlay: true,
              reverse: false
          ),
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
            return newClubItem(controller.featureInfoScreen.value.asset![itemIndex]);
          },
        ),
        42.h.toSizedBoxVertical,
        DotsIndicator(
          dotsCount: controller.featureInfoScreen.value.asset!.length,
          position: controller.selectedNewClubItem.value.toDouble(),
          decorator: const DotsDecorator(
            color: DarkThemeAppColors.colorWhite,
            activeColor:  Color(0XFF4753BE),
          ),
        ),
        38.h.toSizedBoxVertical,
        "Enter the club".toHeading3(color: DarkThemeAppColors.colorBackgroundScreen).toSquareButton(horizontalPadding: 15.w,() {
          LocalStorage.setIsShowNewClubSliderView(false);
          controller.isShowNewClubDialog.value=false;
        }),
      ],
    ).toHorizontalPadding(40.w));
  }

  Widget newClubItem(String asset)
  {
    return Column(
      children: [
        asset.toNetWorkBackgroundImage().toExpanded()
       ],
    );
  }

}