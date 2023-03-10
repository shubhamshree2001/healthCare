import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:googleapis/people/v1.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guideAudioTemppelate/audioTempelateController.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guides_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class GuidesAudioTempelateScreen
    extends GetView<GuidesAudioTemelateController> {
  const GuidesAudioTempelateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      backgroundColor: AppColors.colorBlueMci,
      body: audioTempelateBody(),
    );
  }

  Widget audioTempelateBody() {
    return SafeArea(
        child: Column(
      children: [
        Text(
          "there is a Knot in my chest",
          style: AppTheme.boldChinesewhite28spTextStyle,
        ),
        Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.network(
                  "",
                  width: double.infinity,
                  height: 350.h,
                  fit: BoxFit.cover,
                )),
            Center(
                child: CircleAvatar(
              radius: 35.r,
              child: IconButton(
                icon: Icon(controller.isPlaying.value == false
                    ? Icons.pause
                    : Icons.play_arrow),
                onPressed: () async {
                  if (controller.isPlaying.value) {
                    await controller.audioPlayer.pause();
                  } else {
                    //await controller.audioPlayer.play();
                  }
                },
                iconSize: 50,
              ),
            )),
            //Text(controller.formatTime())
          ],
        ),
      ],
    ));
  }
}
