import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/app_theme.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/fonts_constant.dart';
import '../data/models/therapyModel/schedule_date_time.dart';
import '../data/models/therapyModel/schedule_list_response.dart';

void initEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.black
    ..backgroundColor = AppColors.colorPrimary
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

void showSnackBar(String title, String message, bool isError) {
  Get.snackbar(title, message,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 0,
      margin: const EdgeInsets.all(0));
}

/*void showToast(String message)
{
  Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );
}*/

simpleMessageDialogWithoutTitle({
  required BuildContext context,
  required String message,
  String posBtnLabel = "OK",
}) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: message.toHeading2(
              fontFamily: FontsConstant.appRegularFont,
              textAlign: TextAlign.center),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: posBtnLabel.toHeading1(color: AppColors.colorPrimary),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

Widget alertMessageDialogWithBothAction(BuildContext context, String message,
    VoidCallback onClickPress, String posBtn, String nagBtn) {
  return CupertinoAlertDialog(
    content: Text(message),
    actions: <Widget>[
      CupertinoDialogAction(
          child: Text(nagBtn),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      CupertinoDialogAction(
          isDefaultAction: true, onPressed: onClickPress, child: Text(posBtn)),
    ],
  );
}

Widget alertMessageDialogWithOkAction(BuildContext context, String message,
    VoidCallback onClickPress, String posBtn) {
  return CupertinoAlertDialog(
    content: Text(message),
    actions: <Widget>[
      CupertinoDialogAction(
          isDefaultAction: true, onPressed: onClickPress, child: Text(posBtn)),
    ],
  );
}

Widget showProgress() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const CircularProgressIndicator(
              color: AppColors.colorAccent, strokeWidth: 3)
          .toSizedBox(25, 25),
    ],
  ).toCenter();
}

Widget matchParentCustomButton(String btnName, VoidCallback voidCallback) {
  return SizedBox(
    width: 1.sw,
    height: 43.34.h,
    child: ElevatedButton(
        onPressed: voidCallback,
        style: AppTheme.matchParentButtonStyle,
        child: Text(
          btnName,
          style: AppTheme.matchParentButtonTextStyle,
        )),
  );
}

Widget wrapContentCustomButton(String btnName, VoidCallback voidCallback) {
  return SizedBox(
    height: 43.34.h,
    child: ElevatedButton(
        onPressed: voidCallback,
        style: AppTheme.matchParentButtonStyle,
        child: Text(
          btnName,
          style: AppTheme.matchParentButtonTextStyle,
        )),
  );
}

Widget roundedButtonRightIcon(
    String btnName, String rightIcon, VoidCallback voidCallback) {
  return SizedBox(
    width: 1.sw,
    child: ElevatedButton(
        onPressed: voidCallback,
        style: AppTheme.roundedRightIconButtonStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                btnName,
                style: AppTheme.regularBlack14spTextStyle,
              ),
            ),
            SvgPicture.asset(rightIcon),
          ],
        )),
  );
}

Widget socialMediaButton(
    String btnName, String btnIcon, VoidCallback voidCallback) {
  return SizedBox(
    width: 1.sw,
    height: 48.h,
    child: ElevatedButton(
        onPressed: voidCallback,
        style: AppTheme.socialMediaButtonStyle,
        child: Stack(
          children: [
            Row(
              children: [
                SvgPicture.asset(btnIcon, height: 40, width: 40),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      btnName,
                      style: AppTheme.boldColorRangoonGreen16sp,
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
  );
}

void hideSoftKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

Future<DateTime?> showDatePickerDialog(BuildContext context) async {
  final DateTime? newDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(DateTime.now().year - 100),
    lastDate: DateTime.now(),
    helpText: 'Select Date',
    initialEntryMode: DatePickerEntryMode.calendarOnly,
  );
  return newDate;
}

Future<TimeOfDay?> showTimePickerDialog(BuildContext context) async {
  final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: "Select Birth time");

  return newTime;
}

showCustomDialog(
    {required BuildContext context,
    required VoidCallback posBtnCallBack,
    required VoidCallback negBtnCallBack,
    required VoidCallback removeBtnCallBack,
    String message = "Are you sure you want to cancel your booking?",
    String posBtnLabel = "Yes",
    String negBtnLabel = "Cancel"}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0.r)), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              16.h.toSizedBoxVertical,
              const Icon(Icons.close, size: 15, color: AppColors.colorBlack)
                  .onTapWidget(removeBtnCallBack)
                  .toAlign(alignment: Alignment.topRight)
                  .toHorizontalPadding(10.w),
              message
                  .toHeading2(textAlign: TextAlign.center)
                  .toCenter()
                  .toHorizontalPadding(20.w),
              35.h.toSizedBoxVertical,
              Row(
                children: [
                  posBtnLabel
                      .toHeading2(fontFamily: FontsConstant.appRegularFont)
                      .toSquareButtonWrapContent(posBtnCallBack,
                          color: AppColors.colorWhite)
                      .toExpanded(flex: 1),
                  20.w.toSizedBoxHorizontal,
                  negBtnLabel
                      .toHeading2(
                          fontFamily: FontsConstant.appRegularFont,
                          textAlign: TextAlign.center)
                      .toSquareButtonWrapContent(negBtnCallBack,
                          color: AppColors.colorPrimary)
                      .toExpanded(flex: 1)
                ],
              ).toHorizontalPadding(20.w),
              25.h.toSizedBoxVertical,
            ],
          ),
        );
      });
}

showCustomMsgDialog({
  required BuildContext context,
  required VoidCallback negBtnCallBack,
  String message =
      "Appointments cannot be cancelled when less than 24 hours are remaining for the session.",
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0.r)), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              16.h.toSizedBoxVertical,
              const Icon(Icons.close, size: 15, color: AppColors.colorBlack)
                  .onTapWidget(negBtnCallBack)
                  .toAlign(alignment: Alignment.topRight)
                  .toHorizontalPadding(10.w),
              message
                  .toHeading2(textAlign: TextAlign.center)
                  .toCenter()
                  .toHorizontalPadding(20.w),
              35.h.toSizedBoxVertical,
            ],
          ),
        );
      });
}

showCustomActionDialog({
  required BuildContext context,
  required VoidCallback posBtnCallback,
  required VoidCallback negBtnCallback,
  String posBtnLabel = "Yes",
  String negBtnLabel = "No",
  String message =
      "You will be notified for this event. Would you also like to add the event to your calendar",
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF383838),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21.0.r),
          ), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              43.h.toSizedBoxVertical,
              message.toHeading2(
                  fontFamily: FontsConstant.appRegularFont,
                  color: DarkThemeAppColors.colorSubTitle,
                  textAlign: TextAlign.center),
              30.h.toSizedBoxVertical,
              [
                negBtnLabel
                    .toHeading2(color: DarkThemeAppColors.colorBlack)
                    .toSquareButton(negBtnCallback),
                21.w.toSizedBoxHorizontal,
                posBtnLabel
                    .toHeading2(color: DarkThemeAppColors.colorBlack)
                    .toSquareButton(posBtnCallback),
              ].toRow(mainAxisAlignment: MainAxisAlignment.center),
              39.h.toSizedBoxVertical,
            ],
          ).toHorizontalPadding(27.w),
        );
      });
}

showSendGiftDialog({
  required BuildContext context,
  required VoidCallback sendGiftCallBack,
  String message =
      "Gift {Name} a therapy session. Thanks to you, someone is about to get one step closer to healing. You're a real Rockstar. 💛",
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFF383838),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21.0.r),
          ), //this right here
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              27.h.toSizedBoxVertical,
              ImagesConstant.sendGift.toSvg(),
              17.h.toSizedBoxVertical,
              message.toHeading2(
                  fontFamily: FontsConstant.appRegularFont,
                  color: DarkThemeAppColors.colorSubTitle,
                  textAlign: TextAlign.center),
              17.h.toSizedBoxVertical,
              "Send Gift"
                  .toHeading2(color: DarkThemeAppColors.colorBlack)
                  .toSquareButton(sendGiftCallBack),
              25.h.toSizedBoxVertical,
            ],
          ).toHorizontalPadding(27.w),
        );
      });
}

Widget showSyncfusionDatePicker(List<Schedule> list,
    {required dynamic Function(Object?)? onSubmit,
    required DateTime initialSelectedDate}) {
  int year =
      int.parse(DateFormat("yyyy").format(DateTime.parse(list[0].startDate!)));
  int month =
      int.parse(DateFormat("MM").format(DateTime.parse(list[0].startDate!)));
  int day =
      int.parse(DateFormat("dd").format(DateTime.parse(list[0].startDate!)));

  List<DateTime> dates = [];

  for (int i = 0; i < list.length; i++) {
    int year = int.parse(
        DateFormat("yyyy").format(DateTime.parse(list[i].startDate!)));
    int month =
        int.parse(DateFormat("MM").format(DateTime.parse(list[i].startDate!)));
    int day =
        int.parse(DateFormat("dd").format(DateTime.parse(list[i].startDate!)));
    dates.add(DateTime(year, month, day));
  }

  // dates.add(DateTime(2022, 9, 24));
  // dates.add(DateTime(2022, 9, 25));
  return Dialog(
    child: Container(
      height: 0.5.sh,
      color: AppColors.colorWhite,
      child: Column(
        children: [
          SfDateRangePicker(
              selectionShape: DateRangePickerSelectionShape.rectangle,
              viewSpacing: 30,
              selectionColor: AppColors.colorDarkBlue,
              initialSelectedDate: DateTime(year, month, day),
              //initialSelectedDate: initialSelectedDate,
              selectionMode: DateRangePickerSelectionMode.single,
              showNavigationArrow: true,
              showActionButtons: true,
              todayHighlightColor: Colors.transparent,
              selectableDayPredicate: (DateTime datetime) {
                return dates.contains(datetime);
              },
              onCancel: () => Navigator.pop(Get.context!),
              monthViewSettings: DateRangePickerMonthViewSettings(
                  specialDates: dates,
                  viewHeaderStyle: const DateRangePickerViewHeaderStyle(
                      backgroundColor: AppColors.colorAppBar),
                  showTrailingAndLeadingDates: false),
              monthCellStyle: DateRangePickerMonthCellStyle(
                  specialDatesDecoration: BoxDecoration(
                      color: AppColors.colorMediumGreen.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.transparent, width: 0),
                      shape: BoxShape.rectangle)),
              onSubmit: onSubmit,
              initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(const Duration(days: 0)),
                  DateTime.now().add(const Duration(days: 0))))
        ],
      ),
    ),
  );
}

shareSocial(
    {required BuildContext context,
    required String title,
    required String description,
    required String url}) async {
  final box = context.findRenderObject() as RenderBox?;

  await Share.share(
    "$description\n$url",
    subject: title,
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
}

openInfoBottomSheet({required String title, required String message}) {
  Get.bottomSheet(
      [
        30.h.toSizedBoxVertical,
        title.toHeading1().toAlign(alignment: Alignment.topLeft),
        15.h.toSizedBoxVertical,
        message
            .toHeading3(fontFamily: FontsConstant.appRegularFont)
            .toAlign(alignment: Alignment.topLeft),
        30.h.toSizedBoxVertical,
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          .toHorizontalPadding(33.w)
          .toSingleChildScrollView,
      //.toSizedBoxHeight(0.4.sh),
      backgroundColor: AppColors.colorBlueChalk,
      isDismissible: true,
      enableDrag: true,
      persistent: false,
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r))));
}

Future<void> launchWebUrl(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}

Widget socialMediaAppleButton(
    String btnName, String btnIcon, VoidCallback voidCallback) {
  return SizedBox(
    width: 1.sw,
    height: 48.h,
    child: ElevatedButton(
        onPressed: voidCallback,
        style: AppTheme.socialMediaAppleButtonStyle,
        child: Stack(
          children: [
            Row(
              children: [
                SvgPicture.asset(btnIcon, height: 40, width: 40),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      btnName,
                      style: AppTheme.text16blackStyle,
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
  );
}

Widget socialMediaEmailButton(
    String btnName, String btnIcon, VoidCallback voidCallback) {
  return SizedBox(
    width: 1.sw,
    height: 48.h,
    child: ElevatedButton(
        onPressed: voidCallback,
        style: AppTheme.socialMediaEmailButtonStyle,
        child: Stack(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.h),
                  child: SvgPicture.asset(btnIcon, height: 24, width: 24),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      btnName,
                      style: AppTheme.boldColorRangoonGreen16sp,
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
  );
}
