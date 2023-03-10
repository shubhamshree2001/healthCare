import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/therapyModel/resource_list_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapyHomework/homework_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';

class TherapyHomework extends GetView<HomeworkController>
{
  const TherapyHomework({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundScreen,
      appBar: CustomAppbar(voidCallback: ()=>Get.back()),
      body: Obx(()=>therapyHomework()),
    );
  }
  Widget therapyHomework()
  {
    return [
      40.h.toSizedBoxVertical,
      StringsConstant.homework.toHeading1(),
      31.h.toSizedBoxVertical,
      ResponseWidgetsAnimator(
          apiCallStatus: controller.homeWorkSessionApiCallStatus.value,
          loadingWidget: () {
            return showProgress().toCenter();
          },
          errorWidget: () {
            return Container();
          },
          successWidget: () {
            return Obx(() => [
              [
                //"Mar 21, 2022 5 pm"
                AppUtil.convertStringToDateFormat(controller.selectedHomeworkSession.value.schedule,format: AppUtil.dateTimeMMMDYHHMMA)
                    .toHeading4(fontFamily: FontsConstant.appRegularFont)
                    .toSizedBoxWidth(80.w),
                16.w.toSizedBoxHorizontal,
                "${controller.selectedHomeworkSession.value.doctor}"
                    .toHeading4(fontFamily: FontsConstant.appRegularFont)
                    .toSizedBoxWidth(147.w),
              ].toRow(),
              ImagesConstant.dropdown
                  .toSvg(color: AppColors.colorBlack, width: 20, height: 20)
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .toSymmetricPadding(15.w, 8.h)
                .toContainer(
                decoration: BoxDecoration(
                    border:
                    Border.all(color: AppColors.colorPrimary, width: 1),
                    color: AppColors.colorWhite,
                    borderRadius:
                    BorderRadius.all(Radius.circular(7.84.r))))
                .onTapWidget(() {
              openHomeworkListBottomSheet();
            }
            ));
          }
      ),
      33.85.h.toSizedBoxVertical,
      ResponseWidgetsAnimator(
          apiCallStatus: controller.homeWorkApiCallStatus.value,
          loadingWidget: (){
            return showProgress().toCenter();
          },
          errorWidget: (){
            return Container();
          },
          successWidget: (){
            return [
              StringsConstant.notes.toText(fontSize: 18.sp).toAlign(alignment: Alignment.topLeft),
              14.h.toSizedBoxVertical,
              controller.homework.value.note!.toText(fontFamily: FontsConstant.appRegularFont,fontSize: AppFontSize.heading3).toAlign(alignment: Alignment.topLeft),
              60.h.toSizedBoxVertical,
              ListView.separated(
                itemCount: controller.fileList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context,index){
                  return Padding(padding: EdgeInsets.only(top: 24.h));
                },
                itemBuilder: (context,index){
                  return  [
                    "Resource ${index+1}".toText(fontSize: 18.sp),
                    [
                      ImagesConstant.download.toSvg(color: AppColors.colorIcon,width: 40,height: 40),
                      StringsConstant.downloads.toHeading2(fontFamily: FontsConstant.appRegularFont,textDecoration: TextDecoration.underline),
                    ].toRow()

                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween);
                },
              ),
              20.h.toSizedBoxVertical
            ].toColumn();
          }
      )
      ,
      ResponseWidgetsAnimator(
          apiCallStatus: controller.resourceApiCallStatus.value,
          loadingWidget: (){
            return showProgress().toCenter();
          },
          errorWidget:(){
            return Container();
          },
          successWidget: (){
            return resourcesListView();
          }
      ),
      30.h.toSizedBoxVertical,
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toHorizontalPadding(33.w).toSingleChildScrollView.toSafeArea;
  }

  
  Widget resourcesListView()
  {
    return ListView.separated(
        itemCount: controller.resourceList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context,index){
          return Padding(padding: EdgeInsets.only(top: 24.h));
        },
      itemBuilder: (context,index){
         return resourcesItem(controller.resourceList[index]);
      },
        
    );
  }

  Widget resourcesItem(Resource resource)
  {
    return [
    [
      "${resource.title}".toHeading1().toExpanded(),
      "${resource.mobileImage}".toNetWorkImage().paddingOnly(left: 20.w)
    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toSymmetricPadding(25.w, 16.h).toContainer(
        decoration: BoxDecoration(
            color: AppColors.colorLinkWater,
            borderRadius: BorderRadius.all(Radius.circular(8.r))
        )
    )
    ].toColumn(mainAxisAlignment: MainAxisAlignment.center);
  }


  openHomeworkListBottomSheet() {
     Get.bottomSheet(
         [
           27.h.toSizedBoxVertical,
           "List of your homework".toHeading2(),
           20.5.h.toSizedBoxVertical,
           ListView.separated(
             itemCount: controller.homeWorkSessionList.length,
             separatorBuilder: (context, index) {
               return Padding(padding: EdgeInsets.only(top: 10.h));
             },
             itemBuilder: (context, index) {
               return   [
                 AppUtil.convertStringToDateFormat(controller.homeWorkSessionList[index].schedule,format: AppUtil.dateTimeMMMDYHHMMA).toHeading4(fontFamily: FontsConstant.appBoldFont).toSizedBoxWidth(80.w),
                 "${controller.homeWorkSessionList[index].doctor}".toHeading4(fontFamily: FontsConstant.appRegularFont)
               ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).toSymmetricPadding(21.w,10.h).toContainer(
                   decoration: BoxDecoration(
                       border: Border.all(color: AppColors.colorPrimary,width: 1),
                       color: controller.selectedHomeworkSession.value.session==controller.homeWorkSessionList[index].session?AppColors.colorPrimary.withOpacity(0.2):AppColors.colorMagnolia,
                       borderRadius: BorderRadius.all(Radius.circular(4.r))
                   )
               ).onTapWidget(() {
                 controller.selectedHomeworkSession.value=controller.homeWorkSessionList[index];
                 controller.getHomework(controller.homeWorkSessionList[index].session!);
                 Navigator.pop(Get.context!);
               });
             },
           ).toExpanded(),
           20.h.toSizedBoxVertical
         ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toHorizontalPadding(33.w).toSizedBoxHeight(0.4.sh),
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