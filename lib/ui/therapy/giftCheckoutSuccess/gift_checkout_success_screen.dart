import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class GiftCheckoutSuccessScreen extends GetView
{
  const GiftCheckoutSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundScreen,
      appBar: CustomAppbar(voidCallback: ()=>Get.back()),
      body: giftCheckoutSuccessScreen(),
    );
  }

  giftCheckoutSuccessScreen()
  {
    return [
      22.h.toSizedBoxVertical,
      [
        ImagesConstant.competedLarge.toSvg(),
        20.w.toSizedBoxHorizontal,
        [
          "Gift Sent Successfully".toText(fontSize: 18.sp),
          5.h.toSizedBoxVertical,
          StringsConstant.giftTherapySentToEmail.toHeading3(fontFamily: FontsConstant.notoSerifRegular),

        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toExpanded()

      ].toRow(mainAxisAlignment: MainAxisAlignment.start),
      18.h.toSizedBoxVertical,
    ].toColumn(mainAxisSize: MainAxisSize.min).toHorizontalPadding(24.w).toCard().toPaddingOnly(top: 88.h,left: 32.w,right: 32.w);
  }
}