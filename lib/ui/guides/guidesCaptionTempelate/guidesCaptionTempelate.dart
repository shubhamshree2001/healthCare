import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/getModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guides_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class GuidesCaptionScreen extends GetView<GuidesController> {
  const GuidesCaptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      backgroundColor: AppColors.colorBlueMci,
      body: Obx(() => guidesCationScreenBody()),
    );
  }

  Widget guidesCationScreenBody() {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: 10.h),
        LinearProgressIndicator(
          backgroundColor: AppColors.colorWhite,
          valueColor: AlwaysStoppedAnimation(AppColors.colorBlueProgress),
          minHeight: 5.h,
          value: controller.initial.value,
        ),
        SizedBox(height: 10.h),
        Expanded(child: cationPageView()),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.chevron_right),
        )
      ],
    ));
  }

  Widget cationPageView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: SizedBox(
        child: PageView.builder(
            scrollDirection: Axis.horizontal,
            //physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageViewController,
            onPageChanged: (index) {},
            itemCount: controller.listOfStories.length,
            itemBuilder: (BuildContext context, index) {
              return captionBody(controller.listOfStories[index]);
            }),
      ),
    );
  }

  Widget captionBody(Story storyItem) {
    return Column(
      children: [
        Text(
          controller.listOfModuleTopics[0].topic,
          style: AppTheme.text14blackStyle,
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(color: AppColors.colorDarkBlue),
          width: 1.sw,
          height: 150.h,
          child:
              Text(storyItem.captions![0], style: AppTheme.inputFieldTextStyle),
        ),
      ],
    );
  }
}
