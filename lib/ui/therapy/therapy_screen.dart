import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/mybooking/my_booking_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/therapy/therapy_controller.dart';

import '../../constants/fonts_constant.dart';
import '../../repository/therapyRepo/therapy_repo_impl.dart';
import '../../service/graph_ql_configuration.dart';
import 'bookSessions/book_sessions_screen.dart';

class TherapyScreen extends GetView<TherapyController> {
  const TherapyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TherapyController(
        therapyRepo: Get.put(TherapyRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
    return Scaffold(
        backgroundColor: AppColors.colorBackgroundScreen,
        body: therapyScreenBody());
  }

  Widget therapyScreenBody() {
    return SafeArea(
      child: Column(
        children: [
          [
            ImagesConstant.search.toSvg(),
            14.w.toSizedBoxHorizontal,
            "Search".toHeading2(fontFamily: FontsConstant.appRegularFont),
          ]
              .toRow()
              .toHorizontalPadding(15.w)
              .toContainer(
                  alignment: Alignment.center,
                  height: 48.h,
                  decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(22.r)))
              .onTapWidget(() => Get.toNamed(Routes.searchTherapists))
              .toHorizontalPadding(33.w)
              .toAlign(alignment: Alignment.center)
              .toContainer(height: 76.h, color: AppColors.colorAppBar),
          40.h.toSizedBoxVertical,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    StringsConstant.therapy,
                    style: AppTheme.titleChineseBlackBoldTextStyle,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  StringsConstant.therapyDescription,
                  style: AppTheme.regularBlack14spTextStyle,
                ),
                SizedBox(height: 45.h),
                DefaultTabController(
                    length: 2,
                    child: TabBar(
                      controller: controller.tabController,
                      indicatorColor: AppColors.colorAccent,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 2.0,
                      onTap: (int index) {
                        controller.onTabListeners(index);
                      },
                      tabs: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            "My Bookings",
                            style: AppTheme.boldChineseBlackColor16spTextStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            "Book Sessions",
                            style: AppTheme.boldChineseBlackColor16spTextStyle,
                          ),
                        )
                      ],
                    )),
                Expanded(
                  child: TabBarView(
                      controller: controller.tabController,
                      children: const [
                        MyBookingScreen(),
                        BookSessionsScreen()
                      ]),
                )
              ],
            ),
          ).toExpanded()
        ],
      ),
    );
  }
}
