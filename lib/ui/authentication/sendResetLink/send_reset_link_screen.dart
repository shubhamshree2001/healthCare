import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/sendResetLink/send_reset_link_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

import '../../../constants/strings_constant.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/common_widget.dart';

class SendResetLinkScreen extends GetView<SendResetLinkController> {
  const SendResetLinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorGhostWhite,
      appBar: CustomAppbar(voidCallback: () => Get.back()),
      body: sendResetLinkScreenBody(),
    );
  }

  Widget sendResetLinkScreenBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 27.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    StringsConstant.sendResetLinkTitle,
                    style: AppTheme.titleChineseBlackBoldTextStyle,
                  ),
                ),
                SizedBox(height: 19.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Obx(
                        () => Text(
                          "${controller.email}",
                          style: AppTheme.boldChineseBlackColor16spTextStyle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      InkWell(
                        child: Text(
                          StringsConstant.change,
                          style: AppTheme.underlineTextStyle,
                        ),
                        onTap: () => Get.back(),
                      )
                    ],
                  ),
                ),

                /*  Row(
                  children: [
                   Obx(() =>  Text(
                     "${controller.email}",
                     style: AppTheme.boldChineseBlackColor16spTextStyle,
                   ),),
                    SizedBox(width: 3.w),
                    TextButton(
                        onPressed: ()=>Get.back(),
                        child: Text(
                          StringsConstant.change,
                          style: AppTheme.underlineTextStyle,
                        )
                    )
                  ],
                ),*/
                SizedBox(height: 35.h),
              ],
            ),
            Column(
              children: [
                SvgPicture.asset(ImagesConstant.illustrationImg,
                    height: 237.h, width: 370.w),
                SizedBox(height: 114.h),
                matchParentCustomButton(StringsConstant.sendResetLink,
                    () => controller.sendLinkForgotPass()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
