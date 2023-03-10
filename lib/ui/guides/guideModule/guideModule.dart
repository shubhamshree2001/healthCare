import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:googleapis/container/v1.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guides_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../data/models/guidesModel/getModuleResponse.dart';

class GuidesModuleScreen extends GetView<GuidesController> {
  const GuidesModuleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      backgroundColor: AppColors.colorBlueMci,
      body: guideModuleBody(),
    );
  }

  Widget guideModuleBody() {
    return SafeArea(
        child: Column(
      children: [
        ListView.separated(
            itemCount: controller.listModules[0].filters!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return Padding(padding: EdgeInsets.only(top: 15.h));
            },
            itemBuilder: (context, index) {
              return filterItem(controller.listModules[index]);
            }),
        SizedBox(height: 15.h),
        Text(
          "Ready? Let's do this!",
          style: AppTheme.inputFieldTextStyle,
        ),
        SizedBox(height: 20.h),
        ListView.separated(
            itemCount: controller.listOfModuleTopics.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return Padding(padding: EdgeInsets.only(top: 15.h));
            },
            itemBuilder: (context, index) {
              return moduleItem(controller.listOfModuleTopics[index]);
            }),
        SizedBox(height: 250.h),
        matchParentCustomButton(StringsConstant.start, () {
          Get.toNamed(Routes.guideCaptionScreen);
        })
      ],
    ));
  }

  Widget filterItem(ListModule listModuleItem) {
    return Container(
      width: 10.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: const Color(0XFF122847),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        listModuleItem.filters![0],
        style: TextStyle(
          color: Color(0XFFE6E6E6),
        ),
      ),
    );
  }

  Widget moduleItem(TopicElement topics) {
    return Container(
      color: AppColors.colorWhite,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                SizedBox(
                  height: 56.h,
                  width: 56.w,
                  child: CircleAvatar(
                    backgroundColor: AppColors.colorJeansBlue,
                    child: Text(""),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topics.topic,
                        style: AppTheme.boldChineseBlackColor16spTextStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 12.h)
        ],
      ),
    );
  }
}
