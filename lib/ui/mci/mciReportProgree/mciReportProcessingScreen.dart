import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/mci/mciReportProgree/mciReportProgressController.dart';

class MciReportProgressScreen extends GetView<MciReportProgressController> {
  const MciReportProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0e0e0e),
        body: SafeArea(
          child: Center(
            child: Image.asset(
              "assets/mci-80.gif",
              width: 1.sw,
            ),
          ),
        ));
  }
}
