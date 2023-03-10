import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';

class EmptyVent extends GetWidget
{
  final String msg;
  const EmptyVent({
    Key? key,
    this.msg ="What's something you really want to get off your chest today? Vent it out!"
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       ImagesConstant.ventoutEmpty.toSvg(),
       28.h.toSizedBoxVertical,
       msg.toHeading3(color: DarkThemeAppColors.colorTitle,textAlign: TextAlign.center).toCenter()
      ],
    ).toSymmetricPadding(33.w,50.h);
  }

}