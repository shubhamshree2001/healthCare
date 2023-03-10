import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleFIlterResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guides_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';

class GuidesSelectFilterScreen extends GetView<GuidesController> {
  const GuidesSelectFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      backgroundColor: AppColors.colorBlueMci,
      body: guidesFilterBody(),
    );
  }

  Widget guidesFilterBody() {
    return Obx(() => SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                  itemCount: controller.listofFilters.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return Padding(padding: EdgeInsets.only(top: 15.h));
                  },
                  itemBuilder: (context, index) {
                    return filterItem(controller.listofFilters[index]);
                  }),
            ],
          ),
        )));
  }

  Widget filterItem(ListModuleFilter listModuleFilterItem) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: const Color(0XFF122847),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        listModuleFilterItem.name!,
        style: TextStyle(
          color: Color(0XFFE6E6E6),
        ),
      ),
    );
  }
}
