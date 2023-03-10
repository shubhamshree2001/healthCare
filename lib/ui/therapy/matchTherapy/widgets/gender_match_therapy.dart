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

class GenderMatchTherapy extends GetWidget<MatchTherapyController>
{
  const  GenderMatchTherapy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  [
      "What is your gender?".toHeading1(),
      29.h.toSizedBoxVertical,
      ListView.separated(
          itemCount: 4,
          shrinkWrap: true,
          separatorBuilder:(context,index){
            return  Padding(padding: EdgeInsets.only(top: 30.h));
          }  ,
          itemBuilder: (context,index)
          {
            return genderItem();
          }
      ),
      35.h.toSizedBoxVertical,
      [
        "Previous".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonWrapContent(() {
          controller.animateToPage(0);
        }).toExpanded(flex: 1),
        20.w.toSizedBoxHorizontal,
        "Next".toHeading2(fontFamily: FontsConstant.appRegularFont).toSquareButtonWrapContent(() {
          controller.animateToPage(2);
        }).toExpanded(flex: 1),
      ].toRow()

    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);


  }

  Widget genderItem()
  {
    return [
      const Icon(Icons.radio_button_off,color: AppColors.colorBlack,size: 18),
      10.w.toSizedBoxHorizontal,
      "Option 1 choice".toHeading2(fontFamily: FontsConstant.appRegularFont)

    ].toRow();
  }

  onTap(TapDownDetails details, context) {
    var size = MediaQuery.of(context).size;
    var offset = details.globalPosition;

    if(controller.overlayEntry!=null && controller.overlayEntry!.mounted)
      {
        controller.overlayEntry?.remove();
        controller.overlayEntry=null;
      }

    controller.overlayState = Overlay.of(context);

    controller.overlayEntry =  OverlayEntry(
        builder: (BuildContext context) => Positioned(
            left: offset.dx + 300 >= size.width ? offset.dx - 300 : offset.dx,
            top: offset.dy + 200 >= size.height ? offset.dy - 200 : offset.dy,
            child: Material(
              color: Colors.transparent,
              child: Container(
                  width: 300,
                  height: 200,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5.0,
                            ),
                          ]),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.center,
                        direction: Axis.vertical,
                        spacing: 10,
                        children: const <Widget>[
                          Text(
                            'Main Text',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Text('sub text 1'),
                          Text('sub text 2'),
                          Text('sub text 3'),
                          Text('sub text 4')
                        ],
                      ))),
            )));
    controller.overlayState?.insert(controller.overlayEntry!);
  }

}