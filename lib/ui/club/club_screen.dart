import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/repository/clubRepo/club_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/club/club_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/club/events/events_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/club/vents/vents_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/club/vents/widgets/new_club_widget.dart';
import '../../service/graph_ql_configuration.dart';

class ClubScreen extends GetView<ClubController>
{
  const ClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ClubController(clubRepo: Get.put(ClubRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
    return  Obx(() => Scaffold(
      backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
      body: controller.isShowNewClubDialog.value?const NewClubWidget():clubScreenBody(),
    ));
  }
  Widget clubScreenBody() {
    return SafeArea(
      child: Column(
          children: [
        SizedBox(height: 30.h),
        [
          "MindPeers Club".toHeading1(color:DarkThemeAppColors.colorTitle).toAlign(alignment: Alignment.topLeft).toHorizontalPadding(30.w),
          ImagesConstant.premium.toSvg(width: 40.w,height: 40.h).toVisibility(controller.isPaid.value)
        ].toRow(),
        SizedBox(height: 35.h),
        SizedBox(
          child:  Stack(
            children: [
              //const Divider(color: DarkThemeAppColors.textColor2,thickness: 0.5).toPositioned(top: 10.h),
              DefaultTabController(
                  length: 2,
                  child: TabBar(
                    controller: controller.tabController,
                    indicatorColor: DarkThemeAppColors.colorPrimary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3.0,
                    unselectedLabelColor: DarkThemeAppColors.colorTitle,
                    unselectedLabelStyle: const TextStyle(
                        color: DarkThemeAppColors.colorTitle,
                        fontFamily: FontsConstant.appBoldFont
                    ),
                    labelColor: DarkThemeAppColors.colorTitle,
                    labelStyle: const TextStyle(
                        color: DarkThemeAppColors.colorTitle,
                        fontFamily: FontsConstant.appBoldFont
                    ),
                    onTap:(int index){
                       controller.onTabListeners(index);
                    },
                    tabs: const [
                      Tab(
                        text: "VENTS",
                      ),
                      Tab(
                        text: "EVENTS",
                      )
                    ],
                  )).toHorizontalPadding(30.w),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
              controller: controller.tabController,
              children: const [VentsScreen(), EventsScreen()]),
        )
      ]
      )
    );
  }

}