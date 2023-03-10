import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/matchTherapy/widgets/gender_match_therapy.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/matchTherapy/widgets/select_lang_dob_match_therapy.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/matchTherapy/widgets/timing_of_sessions_match_therapy.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import 'match_therapy_controller.dart';

class MatchTherapyScreen extends GetView<MatchTherapyController>
{
   MatchTherapyScreen({Key? key}) : super(key: key);

  final  List<Widget> viewPagerItem = <Widget>[
    const SelectDobLangMatchTherapy(),
    const GenderMatchTherapy(),
    const TimingOfSessionMatchTherapy(),
  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomAppbar(voidCallback: ()=>Get.back()),
     body: matchTherapyBody(),

   );
  }

  Widget matchTherapyBody()
  {
    return [
      72.h.toSizedBoxVertical,
      [
        [
          "Basic Info".toHeading1(),
          "Up Next: Preferences".toHeading3(fontFamily: FontsConstant.appRegularFont)
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        "1 of 4".toHeading2().toAlign(alignment: Alignment.center).toContainer(
          height: 84.h,
          width: 84.w,
         decoration: BoxDecoration(
           shape: BoxShape.circle,
           color: AppColors.colorWhite,
           border: Border.all(color: AppColors.colorPrimary,width: 5)
         )
       )
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
      72.h.toSizedBoxVertical,
      matchTherapyViewPager()
    ].toColumn().toHorizontalPadding(33.w);
  }

  Widget matchTherapyViewPager()
  {
    return  PageView.builder(
      controller: controller.pageController,
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return viewPagerItem[index];
      },
    ).toExpanded();
  }

}