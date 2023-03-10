import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/callback/callback.dart';

import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo_impl.dart';
import 'package:mindpeers_mobile_flutter/service/graph_ql_configuration.dart';

import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/ui/authentication/settings/settingScreen/setting_controller.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:store_redirect/store_redirect.dart';
import '../../../../routes/app_pages.dart';

class SettingScreen extends GetView<SettingController> implements CallBack {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SettingController(
        settingRepo: Get.put(SettingRepoImpl(
            graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFE9E9FF).withOpacity(1),
        // actionsIconTheme: IconThemeData(color: Colors.black),
        //iconTheme: IconThemeData(color: Colors.black),
        //shadowColor: Color(0xffE9E9FF),
        elevation: 0,
        toolbarHeight: 150.h,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: Text(
            StringsConstant.setting,
            style: AppTheme.titleChineseBlackBoldTextStyle,
          ),
        ),
      ),
      body: settingBody(),
    );
  }

  Widget settingBody() {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            settingItem(StringsConstant.personInfo, ImagesConstant.profileIcon,
                () => Get.toNamed(Routes.profile)),
            settingItem(StringsConstant.plans, ImagesConstant.plansIcon,
                () => Get.toNamed(Routes.activePlans)),
            settingItem(
                StringsConstant.changePassword,
                ImagesConstant.changepwIcon,
                () => Get.toNamed(Routes.settingResetPassword)),
            settingItem(StringsConstant.refer, ImagesConstant.referIcon,
                () => Get.toNamed(Routes.refer)),
            settingItem(StringsConstant.faq, ImagesConstant.faqIcon,
                () => controller.redirectToWebView(StringsConstant.faqsUrl)),
            settingItem(StringsConstant.about, ImagesConstant.aboutIcon,
                () => Get.toNamed(Routes.about)),
            settingItem(
              StringsConstant.logout,
              ImagesConstant.logoutIcon,
              () => //controller.logOut()
                  controller.googleSignOut(),
            ),
            settingItem(
              StringsConstant.deleteAccnt,
              ImagesConstant.deleteAccntIcon,
              () => openDeleteAccountBottomSheet(),
            ),
            SizedBox(
              height: 25.h,
            ),
            Obx(
              () => Column(
                children: [
                  if (controller.questions.value.starRatingQuestion != null &&
                      controller.questions.value.starRatingQuestion!.question
                          .isNotEmpty) ...[
                    Text(
                      "${controller.questions.value.starRatingQuestion!.question}",
                      style: AppTheme.boldChineseBlackColor16spTextStyle,
                    ),
                    SizedBox(height: 14.79.h),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Color(0xffF3EB00),
                      ),
                      onRatingUpdate: (double val) {
                        controller.rating.value = val;
                        controller.submitRating();
                        //print(controller.rating.value);
                        if (controller.rating.value < 4) {
                          return openFeedbackBottomSheet();
                        } else {
                          return openplayStoreDialogueBox();
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget settingItem(
      String btnName, String leftIcon, VoidCallback voidCallback) {
    return InkWell(
      child: ListTile(
        leading: SvgPicture.asset(
          leftIcon,
        ),
        title: Text(
          btnName,
          style: AppTheme.heading2,
        ),
      ),
      onTap: voidCallback,
    );
  }

  openFeedbackBottomSheet() {
    return Get.bottomSheet(
        Container(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 43.w, vertical: 33.26.h),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "${controller.questions.value.userFeedbackQuestion!.question}",
                      //StringsConstant.feedback,
                      style: AppTheme.boldChineseBlackColor16spTextStyle,
                    ),
                  ),
                  SizedBox(height: 23.h),
                  SizedBox(
                    height: 92.h,
                    width: 338.27.w,
                    child: TextField(
                      controller: controller.ratingFeedbackController,
                      maxLines: 30,
                      style: AppTheme.regularBlack14spTextStyle,
                      decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.h, horizontal: 10.w),
                          border: AppTheme.inputFieldBorder,
                          enabledBorder: AppTheme.inputFieldEnabledBorder,
                          focusedBorder: AppTheme.inputFieldFocusBorder,
                          errorBorder: AppTheme.inputFieldEnabledBorder,
                          filled: true,
                          fillColor: AppColors.colorWhite),
                    ),
                  ),
                  SizedBox(
                    height: 27.74.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: AppTheme.matchParentButtonStyle,
                        onPressed: () {
                          controller.submitUserInAppFeedback();
                          Get.back();
                        },
                        child: Text(
                          StringsConstant.giveFeedback,
                          style: AppTheme.matchParentButtonTextStyle,
                        )),
                  ),
                  SizedBox(height: 35.11.h)
                ],
              ),
            ),
          ),
        ),
        enableDrag: true,
        backgroundColor: AppColors.colorBlueChalk,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))));
  }

  openplayStoreDialogueBox() {
    return showDialog(
      context: Get.context!,
      builder: (ctx) => AlertDialog(
        backgroundColor: Color(0XFFFFFFFF),
        content: SizedBox(
          height: 208.h,
          width: 1.sw,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(Get.context!);
                  },
                  color: Colors.black,
                ),
              ),
              SvgPicture.asset(
                ImagesConstant.imageIcon,
                height: 66.14.h,
                width: 129.09.w,
              ),
              SizedBox(height: 23.h),
              Text(
                //StringsConstant.playstore,
                "${controller.questions.value.appFeedbackQuestion!.question}",
                style: TextStyle(color: Color(0XFF000000)),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 37.h,
                  width: 105.w,
                  child: ElevatedButton(
                    style: AppTheme.dialogueYesButtonStyle,
                    child: Text('Not Now',
                        style: TextStyle(
                          color: Colors.black,
                          //fontSize: 15,
                        )),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(
                  width: 14.03.w,
                ),
                SizedBox(
                  height: 37.h,
                  width: 105.w,
                  child: ElevatedButton(
                    style: AppTheme.dialogueYesButtonStyle,
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Color(0XFF111111),
                        //fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      StoreRedirect.redirect(androidAppId: "", iOSAppId: '');
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 27.5.h),
        ],
      ),
    );
  }

  openAccountDeletedBottomSheet() {
    return Get.bottomSheet(
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 81.83.h),
                child: CircleAvatar(
                  child: Icon(Icons.check),
                  radius: 50.r,
                ),
              ),
              SizedBox(height: 21.47.h),
              Text(
                StringsConstant.accountIsDeleted,
                style: AppTheme.titleChineseBlackBoldTextStyle,
              ),
              SizedBox(height: 9.h),
              Text(
                StringsConstant.usingProduct,
                style: AppTheme.regularColorSmokeyGrey12spTextStyle,
              ),
              SizedBox(height: 99.h),
            ],
          ),
        ),
        enableDrag: true,
        backgroundColor: AppColors.colorWhite,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))));
  }

  openDeleteAccountBottomSheet() {
    return Get.bottomSheet(
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 33.26.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.h),
                    child: Text(
                      StringsConstant.deletingAccount,
                      style: AppTheme.boldChineseBlackColor16spTextStyle,
                    ),
                  ),
                ),
                SizedBox(height: 23.h),
                Obx(
                  () => Theme(
                    data: ThemeData(
                      unselectedWidgetColor: Color(0xffB1B2FC),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(0xffB1B2FC),
                              value: controller.reasonList[0],
                              groupValue: controller.selectedreasons.value,
                              onChanged: (val) {
                                controller.selectedreasons.value =
                                    val as String;
                              },
                            ),
                            Text(StringsConstant.dontNeed)
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(0xffB1B2FC),
                              value: controller.reasonList[1],
                              groupValue: controller.selectedreasons.value,
                              onChanged: (val) {
                                controller.selectedreasons.value =
                                    val as String;
                              },
                            ),
                            Text(StringsConstant.expensive)
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(0xffB1B2FC),
                              value: controller.reasonList[2],
                              groupValue: controller.selectedreasons.value,
                              onChanged: (val) {
                                controller.selectedreasons.value =
                                    val as String;
                              },
                            ),
                            Text(StringsConstant.switchApp)
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Color(0xffB1B2FC),
                              value: controller.reasonList[3],
                              groupValue: controller.selectedreasons.value,
                              onChanged: (val) {
                                controller.selectedreasons.value =
                                    val as String;
                              },
                            ),
                            Text("other")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.37.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38.h),
                  child: Text(StringsConstant.deleteAccntMeaning,
                      style: AppTheme.boldChineseBlackColor16spTextStyle),
                ),
                SizedBox(
                  height: 15.15.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 42.h),
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.colorVividTangerine,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Color(0xff111111),
                          size: 10,
                        ),
                      ),
                      Text(StringsConstant.loseAccess),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 42.h),
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: AppColors.colorVividTangerine,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Color(0xff111111),
                          size: 10,
                        ),
                      ),
                      Text(StringsConstant.deleteInformation),
                    ],
                  ),
                ),
                SizedBox(height: 21.15.h),
                ElevatedButton(
                    style: AppTheme.matchCloseAccntButtonStyle,
                    onPressed: () {
                      controller.checkValidateDeleteAccount(this);
                    },
                    child: Text(
                      StringsConstant.closeAccnt,
                      style: AppTheme.matchParentButtonTextStyle,
                    )),
              ],
            ),
          ),
        ),
        enableDrag: true,
        backgroundColor: AppColors.colorWhite,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))));
  }

  @override
  void onCall() {
    Navigator.pop(Get.context!);
    openAccountDeletedBottomSheet();
  }
}
