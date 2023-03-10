import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/settingScreen/settings_screen.dart';
import 'package:mindpeers_mobile_flutter/ui/dashboard/dashboard_controller.dart';
import 'package:mindpeers_mobile_flutter/ui/dashboard/home_screen.dart';

import '../../constants/fonts_constant.dart';
import '../club/club_screen.dart';
import '../therapy/therapy_screen.dart';

class DashboardScreen extends GetView<DashboardController> {
  DashboardScreen({Key? key}) : super(key: key);

  final List<Widget> screens = <Widget>[
    const HomeScreen(),
    const TherapyScreen(),
    const SettingScreen(),
    const HomeScreen(),
    const ClubScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorBackgroundScreen,
      body: Obx(() => screens.elementAt(controller.selectedIndex.value)),
      bottomNavigationBar: Obx(() => bottomNavigationItems()),
    );
  }

  Widget bottomNavigationItems() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: DefaultTabController(
              length: 5,
              child: SizedBox(
                height: 0,
                child: TabBar(
                  controller: controller.tabController,
                  labelPadding: EdgeInsets.zero,
                  onTap: (value) {
                    controller.selectedIndex.value = value;
                  },
                  indicatorColor: AppColors.colorAccent,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3.0,
                  tabs: [
                    SizedBox(
                      width: 40.w,
                      child: const Tab(
                        height: 0,
                        text: "",
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                      child: const Tab(
                        height: 0,
                        text: "",
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                      child: const Tab(
                        height: 0,
                        text: "",
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                      child: const Tab(
                        height: 0,
                        text: "",
                      ),
                    ),
                    SizedBox(
                      width: 40.w,
                      child: const Tab(
                        height: 0,
                        text: "",
                      ),
                    )
                  ],
                ),
              )),
        ),
        Container(
          color: Colors.black,
          height: GetPlatform.isAndroid ? 74.h : 90.h,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.colorBlack,
            selectedItemColor: AppColors.colorWhite,
            unselectedItemColor: AppColors.colorGooseGrey,
            selectedLabelStyle: TextStyle(
                color: AppColors.colorWhite,
                fontSize: 10.sp,
                fontFamily: FontsConstant.appBoldFont),
            unselectedLabelStyle: TextStyle(
                color: AppColors.colorGooseGrey,
                fontSize: 10.sp,
                fontFamily: FontsConstant.appBoldFont),
            selectedIconTheme: IconThemeData(size: 20.sp),
            unselectedIconTheme: IconThemeData(size: 20.sp),
            currentIndex: controller.selectedIndex.value,
            onTap: (value) {
              controller.tabController.animateTo(value);
              controller.selectedIndex.value = value;
            },
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: SvgPicture.asset(ImagesConstant.homeActive)),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    height: 25.h,
                    width: 25.w,
                    child: SvgPicture.asset(ImagesConstant.home),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Therapy',
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    height: 25.h,
                    width: 25.w,
                    child: SvgPicture.asset(ImagesConstant.therapyActive),
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    height: 25.h,
                    width: 25.w,
                    child: SvgPicture.asset(ImagesConstant.therapy),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'For You',
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: SvgPicture.asset(ImagesConstant.forYouActive)),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: SvgPicture.asset(ImagesConstant.forYouIcon)),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Games',
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: SvgPicture.asset(ImagesConstant.games,
                          color: AppColors.colorAccent)),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: SvgPicture.asset(ImagesConstant.games)),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Community',
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: SvgPicture.asset(ImagesConstant.communityActive)),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: SvgPicture.asset(ImagesConstant.community)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
