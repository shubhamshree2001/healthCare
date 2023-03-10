import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapyBooking/therapy_booking_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import '../../../appUtils/validation_util.dart';
import '../../../constants/fonts_constant.dart';

class TherapyBookingScreen extends GetView<TherapyBookingController>
{
  const TherapyBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: AppColors.colorBackgroundScreen,
     appBar: CustomAppbar(voidCallback: () {Get.back();}),
     body: Obx(() => therapyBookingBody()),
   );
  }

  Widget therapyBookingBody()
  {
    return [
      78.h.toSizedBoxVertical,
      "Enter Your Booking Details".toHeading1(),
      7.h.toSizedBoxVertical,
      "Mindcoach: ${controller.doctorItem.value.user!=null?controller.doctorItem.value.user?.name:""}".toHeading3(fontFamily: FontsConstant.appRegularFont),
      [
        25.16.h.toSizedBoxVertical,
        "Date of birth:".toHeading2(fontFamily: FontsConstant.appRegularFont),
        10.h.toSizedBoxVertical,
        [
          "${controller.dob}".toHeading3(fontFamily: FontsConstant.appRegularFont),

          ImagesConstant.dropdown.toSvg(height: 15,width: 15,color: AppColors.colorPrimary)
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).paddingSymmetric(horizontal: 15.w,vertical: 11.h).toContainer(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.colorPrimary,width: 0.5.w),
              color: AppColors.colorWhite,
            )
        ).toSizedBoxWidth(150.w).onTapWidget((){
          controller.selectDob();
        }),
      ].toColumn().toVisibility(controller.isShowDobPicker.value),

      27.16.h.toSizedBoxVertical,
      "Describe the problems you are facing:".toHeading2(fontFamily: FontsConstant.appRegularFont),
      10.h.toSizedBoxVertical,
      toTextFormField(controller: controller.descriptionController, validator: null,maxLines: 3,readOnly: controller.readOnly.value),
      [
        27.16.h.toSizedBoxVertical,
        [
          "Guardian name:".toHeading2(fontFamily: FontsConstant.appRegularFont),
          2.w.toSizedBoxHorizontal,
          ImagesConstant.info.toSvg(color: AppColors.colorPrimary,width: 30.w,height: 30.h).onTapWidget(()=>openInfoBottomSheet(title: BookTherapyStringConstants.guardianInfoTitle, message: BookTherapyStringConstants.guardianInfoMessage))
        ].toRow(),
        10.h.toSizedBoxVertical,
        toTextFormField(controller: controller.guardianNameController, validator:(value)=>BookingTherapyValidation.validateGuardianName(value!),readOnly: controller.readOnly.value),
        27.16.h.toSizedBoxVertical,
        [
          "Guardian email:".toHeading2(fontFamily: FontsConstant.appRegularFont),
          2.w.toSizedBoxHorizontal,
          ImagesConstant.info.toSvg(color: AppColors.colorPrimary,width: 30.w,height: 30.h).onTapWidget(()=>openInfoBottomSheet(title: BookTherapyStringConstants.guardianInfoTitle, message: BookTherapyStringConstants.guardianInfoMessage))
        ].toRow(),
        10.h.toSizedBoxVertical,
        toTextFormField(controller: controller.guardianEmailController, validator: (value)=>BookingTherapyValidation.validateGuardianEmail(value!),keyboardType: TextInputType.emailAddress,readOnly: controller.readOnly.value),
        27.16.h.toSizedBoxVertical,
        [
          "Guardian phone:".toHeading2(fontFamily: FontsConstant.appRegularFont),
          2.w.toSizedBoxHorizontal,
          ImagesConstant.info.toSvg(color: AppColors.colorPrimary,width: 30.w,height: 30.h).onTapWidget(()=>openInfoBottomSheet(title: BookTherapyStringConstants.guardianInfoTitle, message: BookTherapyStringConstants.guardianInfoMessage))
        ].toRow(),
        10.h.toSizedBoxVertical,
        [
          controller.countryCodeList.toMobileCodeDropdown(selectedCountryCode: controller.selectedCountryCode.value, onChange: (countryCodeItem) {controller.selectedCountryCode.value=countryCodeItem!;},readOnly: controller.readOnly.value).toSizedBox(47.h, 93.w),
          15.85.w.toSizedBoxHorizontal,
          toTextFormField(controller: controller.guardianPhoneController,validator:(value)=>BookingTherapyValidation.validateGuardianPhone(value!),keyboardType: TextInputType.phone,errorMaxLines: 2,readOnly: controller.readOnly.value).toExpanded(),
        ].toRow(crossAxisAlignment: CrossAxisAlignment.start),
      ].toColumn().toVisibility(!controller.isAdult.value),

      27.16.h.toSizedBoxVertical,
      Wrap(
        direction: Axis.vertical,
        children: [
          [
            "Mode:".toHeading2(fontFamily: FontsConstant.appRegularFont),
            17.w.toSizedBoxHorizontal,
            Wrap(
              spacing: 8,
              children: List.generate(controller.modeList.length, (index){
                return Transform(
                  transform:Matrix4.identity()..scale(0.9),
                  child: ChoiceChip(
                    label: controller.modeList[index].toHeading3(fontFamily: FontsConstant.appRegularFont,textAlign: TextAlign.center).toSizedBoxWidth(45.w),
                    selected: controller.defaultModeSelectedIndex.value==index,
                    selectedColor: AppColors.colorPrimary,
                    onSelected: (value){
                      controller.defaultModeSelectedIndex.value = value ? index : controller.defaultModeSelectedIndex.value;
                    },
                    backgroundColor: AppColors.colorWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.r)),
                      side:BorderSide(
                          color: AppColors.colorPrimary,
                          width: 1.w
                      ),
                    ),
                    elevation: 1,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.symmetric(horizontal:10),
                  ),
                );
              }),
            )
          ].toRow(),
        ],
      ),
      27.16.h.toSizedBoxVertical,
      "Next available date(s):".toHeading2(fontFamily: FontsConstant.appRegularFont),
      10.h.toSizedBoxVertical,
      [
        "${controller.availableSelectedDate}".toHeading3(fontFamily: FontsConstant.appRegularFont),

        ImagesConstant.dropdown.toSvg(height: 15,width: 15,color: AppColors.colorPrimary)
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).paddingSymmetric(horizontal: 15.w,vertical: 11.h).toContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColors.colorPrimary,width: 0.5.w),
            color: AppColors.colorWhite,
          )
      ).toSizedBoxWidth(150.w).onTapWidget(() {

        showDialog(context: Get.context!, builder: (context){
         return  showSyncfusionDatePicker(controller.scheduleList,onSubmit:(value){
           var dateTime=value as DateTime;
           controller.setAvailableSlots(dateTime);
           Navigator.pop(Get.context!);
         },initialSelectedDate: controller.initialSelectedDate);
        });
      }),
      27.16.h.toSizedBoxVertical,
      "Available time slot:".toHeading2(fontFamily: FontsConstant.appRegularFont),
      10.h.toSizedBoxVertical,
      Wrap(
        children: List.generate(controller.availableTimeSlotList.length, (index){
         return Container(
           width: 80.w,
           height: 48.h,
           alignment: Alignment.center,
           padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
           decoration: BoxDecoration(
             color: controller.availableTimeSlotList[index].isChecked?AppColors.colorPrimary:AppColors.colorWhite,
             borderRadius: BorderRadius.all(Radius.circular(4.r)),
             border: Border.all(color: AppColors.colorPrimary,width: 1.w)
           ),
           child: AppUtil.getTimeHHMMA(controller.availableTimeSlotList[index].startDate).toHeading3(fontFamily: FontsConstant.appRegularFont),
         ).toPaddingOnly(right: 10.w,bottom: 10.h).onTapWidget(() {
            controller.checkAvailableSlotValidation(index);
         });
        }
      )
      ),

      if(controller.selectedSlotList.isNotEmpty) ...[
        27.16.h.toSizedBoxVertical,
        "Selected slots:".toHeading2(fontFamily: FontsConstant.appRegularFont),
        10.h.toSizedBoxVertical,
      ],
      Wrap(
        spacing: 1,
        children: List.generate(controller.selectedSlotList.length, (index){
          return Transform(
            transform:Matrix4.identity()..scale(0.9),
            child: Chip(
              label: AppUtil.convertDateTimeToMMMDYHHMMADateFormat(controller.selectedSlotList[index].startDate).toHeading3(fontFamily: FontsConstant.appRegularFont,textAlign: TextAlign.start),
              backgroundColor: AppColors.colorWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
                side:BorderSide(
                    color: AppColors.colorPrimary,
                    width: 1.w
                ),
              ),
              elevation: 1,
              deleteIconColor: AppColors.colorIcon,
              deleteIcon:  const Icon(Icons.close,color: AppColors.colorIcon,size: 18),
              onDeleted: (){
                controller.deleteSelectedSlotItem(index);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ).toVerticalPadding(5.h).onTapWidget(() {
            }),
          );
        }),
      ),
      21.79.h.toSizedBoxVertical,
      "Note:".toHeading3(),
      11.h.toSizedBoxVertical,
      StringsConstant.slotsCannotBeCancelled.toHeading3(fontFamily: FontsConstant.appRegularFont),
      35.23.h.toSizedBoxVertical,
      Row(
        children: [
          StringsConstant.cancel.toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonMatchParent(()=>Get.back(),color: AppColors.colorWhite).toExpanded(),
          10.w.toSizedBoxHorizontal,
          StringsConstant.next.toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonMatchParent(()=>controller.checkTherapyBookingValidation()).toExpanded()
        ],
      ),
      35.23.h.toSizedBoxVertical,
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toForm(globalKey: controller.therapyBookingFormKey).toHorizontalPadding(33.w).toSingleChildScrollView.toSafeArea;
  }

}