import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/guidesModel/listModuleResponse.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/guides/guides_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/custom_appbar.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import '../../../constants/fonts_constant.dart';

class GuidesScreen extends GetView<GuidesController> {
  const GuidesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDarkAppbar(voidCallback: () => Get.back()),
      backgroundColor: AppColors.colorBlueMci,
      body: guidesLandingScreenBody(),
    );
  }

  Widget guidesLandingScreenBody() {
    return Obx(() => SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thought guides',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Relatable thoughts, explained by psychologists',
                    style: TextStyle(
                      color: Color(0XFFBCBCBC),
                    ),
                  ),
                ),
                Container(
                  height: 53.0,
                  width: 368,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color(0XFF122847),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      hintText: "Search for a guide",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: const Color(0XFF122847),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          '    All   ',
                          style: TextStyle(
                            color: Color(0XFFE6E6E6),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: const Color(0XFF122847),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Anxiety",
                          //controller.listofFilters[0].name!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.guidesSelectFIlterScreen);
                        },
                        child: Row(
                          children: const [
                            Text(
                              'More filters',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.more,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),

                      //SvgPicture.asset(ImagesConstant.morefilter)
                    ],
                  ),
                ),
                SizedBox(height: 35.29.h),
                ListView.separated(
                    itemCount: controller.listModules.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return Padding(padding: EdgeInsets.only(top: 15.h));
                    },
                    itemBuilder: (context, index) {
                      return moduleItem(controller.listModules[index]);
                    }),
              ],
            ),
          ),
        )));
  }

  Widget moduleItem(ListModule listModuletem) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.guideModule);
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Color(0XFF85A8DA),
        ),
        height: 130.0,
        width: 368.0,
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      listModuletem.image.toString(),
                      height: 135.h,
                      width: 100,
                    )),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(ImagesConstant.streams),
                          Text(
                            listModuletem.statistics!.streams!,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/time.svg'),
                        Text(
                          listModuletem.statistics!.time!,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (listModuletem.locked == true) ...[
                  Icon(Icons.lock),
                ],
                Container(
                  width: 150,
                  height: 35,
                  child: Text(
                    listModuletem.text!,
                    //softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Color(0XFF000000), fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: const Color(0XFFFFFFFF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            listModuletem.filters![0],
                            style: TextStyle(
                              color: Color(0XFFE294962),
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.more)
                      // SvgPicture.asset(
                      //   ImagesConstant.moreModule,
                      //   color: Colors.black,
                      //   height: 48.h,
                      //   width: 48.w,
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget searchFieldView() {
    return [
      TextFormField(
        autofocus: true,
        controller: controller.searchController,
        keyboardType: TextInputType.text,
        style: AppTheme.heading2
            .copyWith(fontFamily: FontsConstant.appRegularFont),
        decoration: InputDecoration(
            isDense: true,
            prefixIcon: IconButton(
              icon: ImagesConstant.search
                  .toSvg(color: AppColors.colorSubtitleTextColor),
              onPressed: null,
            ),
            hintText: "Search",
            hintStyle: AppTheme.heading2.copyWith(
                color: AppColors.colorSubtitleTextColor,
                fontFamily: FontsConstant.appRegularFont),
            contentPadding:
                EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorWhite, width: 0.w),
                borderRadius: BorderRadius.circular(43.0.r)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorWhite, width: 0.w),
                borderRadius: BorderRadius.circular(43.0.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.colorWhite, width: 0.w),
                borderRadius: BorderRadius.circular(43.0.r)),
            filled: true,
            fillColor: AppColors.colorWhite),
        onChanged: (value) {
          controller.searchText.value = value;
          if (value.length >= 3) {
            controller.filterText.value = value;
          }
        },
      ).toExpanded()
    ].toRow().toVerticalPadding(10.h);
  }
}
