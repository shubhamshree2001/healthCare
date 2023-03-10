import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/mciModel/listMciQuestion.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciBeginQuestion/mci_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';
import 'dart:math' as math;
import '../../../../appUtils/validation_util.dart';

class MciQuestionScreen extends GetView<MciController> {
  const MciQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.colorBlueMci,
      body: Obx(() => mciQuestionListBody()),
    );
  }

  Widget mciQuestionListBody() {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 35.h),
          LinearProgressIndicator(
            backgroundColor: AppColors.colorWhite,
            valueColor: AlwaysStoppedAnimation(AppColors.colorBlueProgress),
            minHeight: 5.h,
            value: controller.initial.value,
          ),
          if (controller.mciQuestionList[0].type == "MCI") ...[
            SizedBox(height: 35.h),
            mciQuestionImage(),
          ] else if (controller.mciQuestionList[1].type == "DEMOGRAPHIC" &&
              controller.mciQuestionList[1].heading!.isNotEmpty) ...[
            SizedBox(height: 50.h),
            Text(
              "${controller.mciQuestionList[1].heading}",
              //"To calculate your results we need some basic information",
              style: AppTheme.text16blackStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.h,
            ),
            Expanded(child: mciQuestionPageView()),
          ]
          // ResponseWidgetsAnimator(
          //     apiCallStatus: controller.getMciQuestionListApiStatus.value,
          //     loadingWidget: () {
          //       return showProgress().toCenter().toExpanded();
          //     },
          //     errorWidget: () {
          //       return SizedBox();
          //     },
          //     successWidget: () {
          //       return
        ],
      ),
    );
  }

  Widget mciQuestionImage() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.string(
              controller.getSvg(),
              fit: BoxFit.cover,
              width: 428.w,
            ),
          ),
          mciQuestionPageView()
        ],
      ),
    );
  }

  Widget mciQuestionPageView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: SizedBox(
        child: PageView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageViewController,
            onPageChanged: (index) {
              controller.selectedMciQuestionPageIndex.value = index;
              var mciQuestion = controller.mciQuestionList[
                  controller.selectedMciQuestionPageIndex.value];
              mciQuestion.startTime = DateTime.now().toUtc().toIso8601String();
              controller.mciQuestionList[
                  controller.selectedMciQuestionPageIndex.value] = mciQuestion;
              // controller.questionArrivalTime.value =
              //     DateTime.now().toIso8601String();
              // print("${controller.questionArrivalTime.value}");
            },
            itemCount: controller.mciQuestionList.length,
            itemBuilder: (BuildContext context, index) {
              return mciQuestionOptions(controller.mciQuestionList[index]);
            }),
      ),
    );
  }

  Widget mciQuestionOptions(Question mciQuestionList) {
    controller.optionsList.value = mciQuestionList.options!;
    return Column(
      children: [
        Text("${mciQuestionList.question}",
            textAlign: TextAlign.center,
            style: AppTheme.boldChinesewhite21spTextStyle),
        SizedBox(height: 35.h),
        Obx(
          () => Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return mciOptionsList(controller.optionsList[index], index);
              },
              separatorBuilder: (context, index) {
                return Padding(padding: EdgeInsets.only(top: 10.h));
              },
              itemCount: controller.optionsList.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget mciOptionsList(Option options, int index) {
    return InkWell(
      onTap: () {
        //Get.toNamed(Routes.mciReportScreen);
        if (controller.mciQuestionList.isNotEmpty) {
          print("cjmhjghgfhdgfvfcbvcbvnvjg");
          print(controller.selectedMciQuestionPageIndex.value);
          var mciQuestion = controller
              .mciQuestionList[controller.selectedMciQuestionPageIndex.value];
          mciQuestion.endTime = DateTime.now().toUtc().toIso8601String();
          controller.mciQuestionList[
              controller.selectedMciQuestionPageIndex.value] = mciQuestion;
        }
        controller.handleSelectedOption(index);
        controller.moveToNextQuestion();
        controller.increaseProgressIndicator();
        if (controller.mciQuestionList.length > 0 &&
            controller.mciQuestionList.length - 1 ==
                controller.selectedMciQuestionPageIndex.value) {
          controller.mciTestResponse();
          //Get.toNamed(Routes.reportProgress);
          //controller.loadReportScreen();
        }
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        shadowColor: const Color(0x01013133),
        color: AppColors.colorBlueProgress,
        child: Container(
          width: 1.sw,
          height: 110.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          decoration: BoxDecoration(
              boxShadow: [
                options.isChecked
                    ? const BoxShadow(
                        color: Color(0xff1D409B),
                        offset: Offset(
                          0.0,
                          3.0,
                        ),
                        blurRadius: 0.5,
                        spreadRadius: 0.0,
                      )
                    : //BoxShadow
                    const BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      )
              ],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(12.r),
              ),
              color: options.isChecked
                  ? Color(0xff8BABFF)
                  : AppColors.colorBlueProgress),
          child: Text(
            "${options.name}",
            style: AppTheme.heading2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
