import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/mvciResultResponse.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciBeginQuestion/mciQuestionScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciBeginQuestion/mci_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../appUtils/validation_util.dart';
import 'package:dots_indicator/dots_indicator.dart';

class MciReportScreen extends GetView<MciController> {
  const MciReportScreen({Key? key}) : super(key: key);

  // void initState() {
  //   Future.delayed(Duration(milliseconds: 30000), () {
  //     controller.isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return
        //loadingGif();
        Scaffold(
      backgroundColor: AppColors.colorBlueMci,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.colorBlueMci,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              color: AppColors.colorWhite,
            )),
      ),
      body: mciReportScreenBody(),
    );
  }

  // Widget loadingGif() {
  //   return Scaffold(
  //       backgroundColor: Color(0xff0e0e0e),
  //       body: SafeArea(
  //         child: Center(
  //           child: Image.asset(
  //             "assets/mci-80.gif",
  //             width: 1.sw,
  //           ),
  //         ),
  //       ));
  // }

  Widget mciReportScreenBody() {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Obx(() => SingleChildScrollView(child: reportBody())),
    ));
  }

  Widget reportBody() {
    return Column(
      children: [
        SizedBox(height: 16.h),
        if (controller.getReport.isNotEmpty &&
            controller.getReport[0].type == "SCORE" &&
            controller.getReport[0].cards != null) ...[
          Text(
            "${controller.getReport[0].heading}",
            //StringsConstant.totalStrengths,
            style: AppTheme.boldChinesewhite21spTextStyle,
          ),
          SizedBox(height: 39.h),
          //strengthsIndicator(),
          SizedBox(
            height: 600.h,
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return strengthsIndicator(
                      controller.getReport[0].cards![index]);
                },
                separatorBuilder: (context, index) {
                  return Padding(padding: EdgeInsets.only(top: 15.h));
                },
                itemCount: controller.getReport[0].cards!.length),
          ),
        ],
        if (controller.getReport.isNotEmpty &&
            controller.getReport[1].type == "REMARK" &&
            controller.getReport[1].cards != null) ...[
          SizedBox(height: 45.34.h),
          Text("${controller.getReport[1].heading}",
              //StringsConstant.strengthDetails,
              style: AppTheme.boldChinesewhite21spTextStyle),
          SizedBox(height: 25.h),
          CarouselSlider.builder(
            itemCount: controller.getReport[1].cards!.length,
            itemBuilder: (context, itemIndex, pageViewIndex) {
              return reportDetailSlider(context, itemIndex,
                  controller.getReport[1].cards![itemIndex]);
            },
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                controller.selectedStrengthIndex.value = index;
              },
              enlargeCenterPage: true,
              //autoPlay: true,
              //aspectRatio: 16 / 9,
              //autoPlayCurve: Curves.fastOutSlowIn,
              //enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 1,
            ),
          ),
          SizedBox(height: 26.h),
          DotsIndicator(
            dotsCount: controller.getReport[1].cards!.length,
            position: controller.selectedStrengthIndex.value.toDouble(),
            decorator: const DotsDecorator(
              color: AppColors.coloeSlider,
              activeColor: AppColors.coloractiveSlide,
            ),
          ),
        ],
      ],
    );
  }

  Widget strengthsIndicator(Cards card) {
    return Row(
      children: [
        SvgPicture.network("${card.image}"),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "    ${card.heading}",
              style: AppTheme.text14blackStyle,
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                SizedBox(
                  width: 217.w,
                  child: LinearPercentIndicator(
                    backgroundColor: AppColors.colorProgressBackground,
                    progressColor: AppColors.colorShowProgress,
                    percent: (card.score!) / 100,
                    barRadius: Radius.circular(14.r),
                    lineHeight: 13.h,
                    animation: true,
                    animationDuration: 1500,
                  ),
                ),
                SizedBox(width: 17.w),
                Text(
                  "${card.score}",
                  style: AppTheme.text16blackStyle,
                )
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget reportDetailSlider(BuildContext context, index, Cards card) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
        color: AppColors.colorBlueProgress,
      ),
      padding: const EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28.h),
            Text(
              '${card.heading}',
              style: AppTheme.heading1,
            ),
            SizedBox(height: 25.h),
            SizedBox(
              height: 85.h,
              child: Text(
                "${card.text}",
                //StringsConstant.aspirationDetails,
                style: AppTheme.matchParentButtonTextStyle,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
