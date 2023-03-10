import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideAudioTemppelate/audioTempelateController.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideBreathing/guideBreathingController.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guides_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class GuidesTranquilizerBreathingScreen
    extends GetView<GuidesBreathingController> {
  const GuidesTranquilizerBreathingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      backgroundColor: AppColors.colorBlueMci,
      body: tempelateBody(),
    );
  }

  Widget tempelateBody() {
    return SafeArea(
        child: Column(
      children: [SvgPicture.string(controller.anxiousSvg())],
    ));
  }
}
