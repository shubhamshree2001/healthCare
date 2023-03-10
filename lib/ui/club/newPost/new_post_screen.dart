import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/club/newPost/new_post_controller.dart';
import '../../../constants/images_constant.dart';

class NewPostScreen extends GetView<NewPostController>
{
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
      appBar: AppBar(
        backgroundColor: DarkThemeAppColors.colorAppBar,
        elevation: 0,
        leading: IconButton(
          splashRadius: 18,
          icon: ImagesConstant.back.toSvg(color: DarkThemeAppColors.colorWhite),
          onPressed: ()=>Get.back(),
        ),
        actions: [
          IconButton(
            splashRadius: 18,
            icon: ImagesConstant.moreIcon.toSvg(),
            onPressed: (){
              openMoreOptionBottomSheet();
            },
          )

        ],
      ),
      body: newPostScreenBody(),
    );
  }

  Widget newPostScreenBody()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            [
              ImagesConstant.profilePlaceholder.toSvg(width: 48,height: 48),
              9.w.toSizedBoxHorizontal,
              toTransparentTextFormField(controller:controller.postController, validator:null,maxLines: 20,fillColor: Colors.transparent,onChange:(String? value){
                if(value!=null && value.isNotEmpty)
                  {
                    controller.isEnablePostButton.value= true;
                  }
                else
                  {
                    controller.isEnablePostButton.value= false;
                  }
                },hintText: controller.postFieldHint.value).toExpanded()
            ].toRow(crossAxisAlignment: CrossAxisAlignment.start),
          ],
        ).toSingleChildScrollView.toExpanded(),
        [
          Obx(() => Row(
            children: [
              CupertinoSwitch(
                activeColor: DarkThemeAppColors.colorPrimary,
                trackColor: DarkThemeAppColors.colorSubTitle,
                thumbColor: DarkThemeAppColors.colorBackgroundScreen,
                onChanged: (bool value) {
                  controller.anonymousSwitch.value = value;
                },
                value: controller.anonymousSwitch.value,
              ),
              8.w.toSizedBoxHorizontal,
              "Posting as \n${controller.anonymousSwitch.value?"anonymous":controller.userName}".toHeading3(color: DarkThemeAppColors.colorSubTitle)
            ],
          )),
          Obx(() =>  "Post".toHeading2(color:DarkThemeAppColors.colorBlack).toSquareButton(() {
            if(controller.postController.text.isNotEmpty)
              {
                controller.postVent();
              }
            },enable: controller.isEnablePostButton.value))
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)

      ],
    ).toSymmetricPadding(33.w,40.h).toSafeArea;
  }

  openMoreOptionBottomSheet() {
    return Get.bottomSheet(
        Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 33.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const Divider(color: Color(0xFFC5C5C5),thickness: 4,).toSizedBoxWidth(42.w).toCenter(),
                SizedBox(height: 43.33.h),
                [
                  ImagesConstant.flag.toSvg(color:DarkThemeAppColors.colorWhite),
                  16.w.toSizedBoxHorizontal,
                  (controller.isSensitive.value?"Remove Trigger warning":"Add Trigger warning").toHeading2(color: DarkThemeAppColors.colorTitle)
                ].toRow().onTapWidget(() {
                  Get.back();
                  controller.isSensitive.value = !controller.isSensitive.value;
                }),
                SizedBox(height: 47.h),
                [
                  ImagesConstant.community24.toSvg(color: DarkThemeAppColors.colorWhite),
                  16.w.toSizedBoxHorizontal,
                  "Community Guidelines".toHeading2(color: DarkThemeAppColors.colorTitle)
                ].toRow(),
                SizedBox(height: 47.h),
              ],
            ),
          ),
        )),
        backgroundColor: DarkThemeAppColors.colorBgBottomSheet,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: false,
        persistent: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))));
  }

}