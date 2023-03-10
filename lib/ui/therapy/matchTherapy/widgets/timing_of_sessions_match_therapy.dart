import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/matchTherapy/match_therapy_controller.dart';

import '../../../../constants/fonts_constant.dart';

class TimingOfSessionMatchTherapy extends GetWidget<MatchTherapyController>
{
  const TimingOfSessionMatchTherapy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return [
      "Timing of sessions".toHeading1(),
      29.h.toSizedBoxVertical,
      ListView.separated(
          itemCount: 4,
           shrinkWrap: true,
           separatorBuilder:(context,index){
            return  Padding(padding: EdgeInsets.only(top: 30.h));
           }  ,
          itemBuilder: (context,index)
              {
                return timingItem();
              }
      ),
      35.h.toSizedBoxVertical,
      [
        "Previous".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonWrapContent(() {
          controller.animateToPage(1);
        }).toExpanded(flex: 1),
        20.w.toSizedBoxHorizontal,
        "Next".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonWrapContent(() {
        }).toExpanded(flex: 1),
      ].toRow()

    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget timingItem()
  {
    return [
      const Icon(Icons.check_circle_outline,color: AppColors.colorBlack,size: 18),
      10.w.toSizedBoxHorizontal,
      "Option 1 choice".toHeading2(fontFamily: FontsConstant.appRegularFont)

    ].toRow();
  }

}