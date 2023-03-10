import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/mantraTool/mantraController.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciBeginQuestion/mciQuestionScreen.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciBeginQuestion/mci_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';

import '../../../../appUtils/validation_util.dart';

class MantraLandingScreen extends GetView<MantraController> {
  const MantraLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBlueMci,
      body: mantraLandingScreenBody(),
    );
  }

  Widget mantraLandingScreenBody() {
    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: 90.h),
        SizedBox(height: 200.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "a",
                style: AppTheme.boldChinesewhite28spTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 26.h),
              Text(
                "b",
                style: AppTheme.white16sp,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 56.h),
              SizedBox(
                  width: 1.sw,
                  height: 61.h,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: Color(0XFFFFFFFF),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff16A9B1),
                            offset: Offset(
                              0.0,
                              3.0,
                            ),
                            blurRadius: 0.5,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          "j",
                          style: AppTheme.boldColorRangoonGreen16sp,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
              //],
            ],
          ),
        ),
      ],
    ));
  }
}
