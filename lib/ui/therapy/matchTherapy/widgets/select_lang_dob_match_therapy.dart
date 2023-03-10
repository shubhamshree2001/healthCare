import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/matchTherapy/match_therapy_controller.dart';

import '../../../../constants/fonts_constant.dart';
import '../../../../constants/images_constant.dart';
import '../../../../theme/app_color.dart';

class SelectDobLangMatchTherapy extends GetWidget<MatchTherapyController>
{
  const SelectDobLangMatchTherapy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return [
   "What is your date of birth?".toHeading1(),
    27.43.h.toSizedBoxVertical,
     [
       "APR 24,2021".toHeading3(fontFamily: FontsConstant.appRegularFont),

       ImagesConstant.dropdown.toSvg(height: 15,width: 15,color: AppColors.colorIcon)
     ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).paddingSymmetric(horizontal: 15.w,vertical: 11.h).toContainer(
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(8.r),
           border: Border.all(color: AppColors.colorPrimary,width: 0.5.w),
           color: AppColors.colorWhite,
         )
     ).toSizedBoxWidth(150.w),
     27.43.h.toSizedBoxVertical,
     StringsConstant.whatLanAreYouComfort.toHeading1(),
     25.85.h.toSizedBoxVertical,
     [
       "Select languages".toHeading3(fontFamily: FontsConstant.appRegularFont,color: AppColors.colorSubtitleTextColor),
        ImagesConstant.dropdown.toSvg(height: 15,width: 15,color: AppColors.colorIcon)
     ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).paddingSymmetric(horizontal: 15.w,vertical: 11.h).toContainer(
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(8.r),
           border: Border.all(color: AppColors.colorPrimary,width: 0.5.w),
           color: AppColors.colorWhite,
         )
     ),
     40.h.toSizedBoxVertical,
     StringsConstant.next.toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonMatchParent(() {
       controller.animateToPage(1);
     })


   ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toSingleChildScrollView;
  }

}