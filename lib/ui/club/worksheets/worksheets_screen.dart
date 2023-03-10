import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_info_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/ui/club/worksheets/worksheet_controller.dart';

import '../../../constants/images_constant.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/dark_theme_app_color.dart';
import '../../../widgets/common_widget.dart';

class WorkSheetsScreen extends GetView<WorksheetController>
{
  const WorkSheetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
      appBar: AppBar(
        backgroundColor: DarkThemeAppColors.colorAppBar,
        elevation: 0,
        leading: IconButton(
          splashRadius: 18,
          icon: ImagesConstant.cross.toSvg(color: DarkThemeAppColors.colorWhite),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => worksheetBody(),)
    );
  }

  Widget worksheetBody()
  {
    return Column(
      children: [
        16.h.toSizedBoxVertical,
        "All Worksheets"
            .toHeading1(color: DarkThemeAppColors.colorTitle)
            .toAlign(),
        22.h.toSizedBoxVertical,
        worksheetList(),
        16.h.toSizedBoxVertical
      ],
    ).toHorizontalPadding(33.w);
  }
  
  Widget worksheetList()
  {
    return ListView.separated(
        itemCount: controller.resourceList.length,
      shrinkWrap: true,
      separatorBuilder: (context,index){
          return Padding(padding: EdgeInsets.only(top: 26.h));
      },
      itemBuilder:(context,index){
          return worksheetItem(controller.resourceList[index]);
      },
    ).toExpanded();
  }

  Widget worksheetItem(ResourceItem resourceItem)
  {
    return Container(
      //  height: 111.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      decoration: BoxDecoration(
        color: DarkThemeAppColors.colorBackgroundCard,
        borderRadius: BorderRadius.all(Radius.circular(13.r)),
      ),
      child: Stack(
        children: [
          ImagesConstant.openLink.toSvg(color: DarkThemeAppColors.colorWhite).toAlign(alignment: Alignment.topRight),
          Row(
            children: [
              ImagesConstant.fileIcon.toSvg().toAlign(alignment: Alignment.center),
              16.w.toSizedBoxHorizontal,
              [
                resourceItem.name!.toHeading3(color: DarkThemeAppColors.colorTitle),
                4.h.toSizedBoxVertical,
                resourceItem.uploadedBy!.toHeading3(color: DarkThemeAppColors.colorSubTitle),
                AppUtil.convertStringToDateFormat(resourceItem.date,format: AppUtil.dateTimeMMMDthYYYY).toHeading3(color: DarkThemeAppColors.colorSubTitle)
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).toPaddingOnly(right: 25.w).toExpanded()
            ],
          ).toSymmetricPadding(10.w,20.h),
          10.h.toSizedBoxVertical
        ],
      ),
    ).onTapWidget(() {
      if(resourceItem.locked!=null && resourceItem.locked!){
        Get.toNamed(Routes.plan);
      }
      else if(resourceItem.url!=null && resourceItem.url!.isNotEmpty)
      {
        launchWebUrl(resourceItem.url!);
      }
    });
  }

}