import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';

import 'app_color.dart';

class AppTheme {
  static TextStyle get heading1 => TextStyle(
      fontSize: AppFontSize.heading1.sp,
      fontFamily: FontsConstant.appBoldFont,
      letterSpacing: 0.2,
      decoration: TextDecoration.none);
  static TextStyle get heading2 => TextStyle(
      fontSize: AppFontSize.heading2.sp,
      fontFamily: FontsConstant.appBoldFont,
      letterSpacing: 0.2,
      decoration: TextDecoration.none);
  static TextStyle get heading3 => TextStyle(
      fontSize: AppFontSize.heading3.sp,
      fontFamily: FontsConstant.appBoldFont,
      letterSpacing: 0.2,
      decoration: TextDecoration.none);
  static TextStyle get heading4 => TextStyle(
      fontSize: AppFontSize.heading4.sp,
      fontFamily: FontsConstant.appBoldFont,
      letterSpacing: 0.2,
      decoration: TextDecoration.none);
  static TextStyle get heading5 => TextStyle(
      fontSize: AppFontSize.heading5.sp,
      fontFamily: FontsConstant.appBoldFont,
      letterSpacing: 0.2,
      decoration: TextDecoration.none);
  static TextStyle get heading6 => TextStyle(
      fontSize: AppFontSize.heading6.sp,
      fontFamily: FontsConstant.appBoldFont,
      letterSpacing: 0.2,
      decoration: TextDecoration.none);

  /// Bold Font Family
  static TextStyle h3BoldBlackTextStyle = TextStyle(
    color: AppColors.colorChineseBlack,
    fontSize: 14.sp,
    fontFamily: FontsConstant.kosticRocGroteskBold,
  );

  static TextStyle boldChineseBlack30spTextStyle = TextStyle(
    color: AppColors.colorChineseBlack,
    fontSize: 30.sp,
    fontFamily: FontsConstant.kosticRocGroteskBold,
  );
  static TextStyle boldChinesewhite28spTextStyle = TextStyle(
    color: AppColors.colorWhiteMci,
    fontSize: 28.sp,
    fontFamily: FontsConstant.kosticRocGroteskBold,
  );
  static TextStyle boldChinesewhite21spTextStyle = TextStyle(
    color: AppColors.colorWhiteMci,
    fontSize: 21.sp,
    fontFamily: FontsConstant.kosticRocGroteskBold,
  );

  static TextStyle titleChineseBlackBoldTextStyle = TextStyle(
    color: AppColors.colorChineseBlack,
    fontSize: 22.sp,
    fontFamily: FontsConstant.kosticRocGroteskBold,
  );

  static TextStyle regularChineseBlackBoldTextStyle = TextStyle(
    color: AppColors.colorChineseBlack,
    fontSize: 22.sp,
    fontFamily: FontsConstant.kosticRocGroteskBold,
  );

  static TextStyle titleChineseBlackBold20TextStyle = TextStyle(
    color: AppColors.colorChineseBlack,
    fontSize: 20.sp,
    fontFamily: FontsConstant.kosticRocGroteskBold,
  );

  static TextStyle boldChineseBlackColor16spTextStyle = TextStyle(
    color: AppColors.colorChineseBlack,
    fontSize: 16.sp,
    fontFamily: FontsConstant.kosticRocGroteskBold,
  );

  static TextStyle subTitleRegularTextStyle = TextStyle(
    color: AppColors.colorDavyGray,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
  );
  static TextStyle subTitleRegular20TextStyle = TextStyle(
    color: AppColors.colorDavyGray,
    fontSize: 20.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle underlineTextStyle = TextStyle(
      color: AppColors.colorAzureBlue,
      fontSize: 16.sp,
      fontFamily: FontsConstant.avenirRegular,
      decoration: TextDecoration.underline);

  static TextStyle underlineTextblackStyle = TextStyle(
      color: AppColors.colorChineseBlack,
      fontSize: 16.sp,
      fontFamily: FontsConstant.avenirBold,
      decoration: TextDecoration.underline);
  static TextStyle underlineTextwhiteStyle = TextStyle(
      color: AppColors.colorSubText,
      fontSize: 16.sp,
      fontFamily: FontsConstant.avenirBold,
      decoration: TextDecoration.underline);
  static TextStyle underlinePrimaryTextStyle = TextStyle(
      color: Color(0xff16A9B1),
      fontSize: 16.sp,
      fontFamily: FontsConstant.avenirBold,
      decoration: TextDecoration.underline);
  static TextStyle primaryTextStyle = TextStyle(
    color: Color(0xff16A9B1),
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle text14blackStyle = TextStyle(
    color: AppColors.colorText,
    fontSize: 14.sp,
    fontFamily: FontsConstant.avenirBold,
  );
  static TextStyle text16blackStyle = TextStyle(
    color: AppColors.colorText,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirBold,
  );

  static TextStyle underlineBlack14sp = TextStyle(
      color: AppColors.colorBlack,
      fontSize: 14.sp,
      fontFamily: FontsConstant.avenirRegular,
      decoration: TextDecoration.underline);

  static TextStyle underlineDarkBlueBold14sp = TextStyle(
      color: AppColors.colorDarkBlue,
      fontSize: 14.sp,
      fontFamily: FontsConstant.avenirBold,
      decoration: TextDecoration.underline);

  static TextStyle inputFieldTextStyle = TextStyle(
    color: AppColors.colorTextFieldText,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
  );
  static TextStyle inputFieldBlackTextStyle = TextStyle(
    color: AppColors.colorTitleText,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle inputFieldDarkTextStyle = TextStyle(
    color: AppColors.colorDavyGray,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
  );
  static TextStyle inputFieldUnderlineTextStyle = TextStyle(
    color: AppColors.colorDavyGray,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
    decoration: TextDecoration.underline,
  );

  static TextStyle inputFieldHintTextStyle = TextStyle(
    color: AppColors.colorDavyGray,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle matchParentButtonTextStyle = TextStyle(
    color: AppColors.colorBlack,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle regularColorRangoonGreen16sp = TextStyle(
    color: AppColors.colorRangoonGreen,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle boldColorRangoonGreen16sp = TextStyle(
    color: AppColors.colorRangoonGreen,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirBold,
  );
  static TextStyle boldColorwhite16sp = TextStyle(
    color: AppColors.colorWhite,
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirBold,
  );
  static TextStyle white16sp = TextStyle(
    color: Color(0xffCFCFCF),
    fontSize: 16.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle subTitle2Regular14spTextStyle = TextStyle(
    color: AppColors.colorDavyGray,
    fontSize: 14.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle regularCarbonGrey14spTextStyle = TextStyle(
    color: AppColors.colorCarbonGray,
    fontSize: 14.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle regularBlack14spTextStyle = TextStyle(
    color: AppColors.colorBlack,
    fontSize: 14.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle regularColorSmokeyGrey12spTextStyle = TextStyle(
    color: AppColors.colorSmokeyGrey,
    fontSize: 12.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle regularColorDarkGreyBlue12spTextStyle = TextStyle(
    color: AppColors.colorDarkGreyBlue,
    fontSize: 12.sp,
    fontFamily: FontsConstant.avenirRegular,
  );
  static TextStyle boldBlack10spTextStyle = TextStyle(
    color: AppColors.colorBlack,
    fontSize: 10.sp,
    fontFamily: FontsConstant.avenirBold,
    decoration: TextDecoration.underline,
  );
  static TextStyle boldBlack10spnormalTextStyle = TextStyle(
    color: AppColors.colorBlack,
    fontSize: 10.sp,
    fontFamily: FontsConstant.avenirBold,
  );
  static TextStyle boldBlack8spTextStyle = TextStyle(
    color: AppColors.colorBlack,
    fontSize: 8.sp,
    fontFamily: FontsConstant.avenirBold,
    decoration: TextDecoration.underline,
  );
  static TextStyle regularBlack10spTextStyle = TextStyle(
    color: AppColors.colorBlack,
    fontSize: 10.sp,
    fontFamily: FontsConstant.avenirRegular,
  );
  static TextStyle boldRed10spTextStyle = TextStyle(
    color: AppColors.colorRed,
    fontSize: 10.sp,
    fontFamily: FontsConstant.avenirBold,
  );
  static TextStyle regularWhite10spTextStyle = TextStyle(
    color: AppColors.colorWhite,
    fontSize: 14.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  static TextStyle regularColorIronSideGrey12spTextStyle = TextStyle(
    color: AppColors.colorIronSideGrey,
    fontSize: 12.sp,
    fontFamily: FontsConstant.avenirRegular,
  );

  /// TextField related border theme
  ///
  static UnderlineInputBorder textFieldFocusedBottomBorder =
      UnderlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide:
              BorderSide(color: AppColors.colorPrimaryDark, width: 0.5.w));

  ////
  static UnderlineInputBorder textFieldErrorBottomBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: BorderSide(color: Color(0xffDE575A), width: 0.5.w));
  /////
  ///
  static OutlineInputBorder textFieldErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: BorderSide(color: Color(0xffDE575A), width: 0.5.w));

  ///
  static OutlineInputBorder textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: BorderSide(color: AppColors.colorPrimaryDark, width: 0.5.w));
  //
  static OutlineInputBorder inputFieldDarkModeBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorPrimaryDark, width: 0.5.w),
      borderRadius: BorderRadius.circular(8.0.r));
  static OutlineInputBorder inputFieldBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorPrimary, width: 0.5.w),
      borderRadius: BorderRadius.circular(8.0.r));

  static OutlineInputBorder inputFieldDarkEnabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorPrimaryDark, width: 0.5.w),
      borderRadius: BorderRadius.circular(8.0.r));

  static OutlineInputBorder inputFieldEnabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorPrimary, width: 0.5.w),
      borderRadius: BorderRadius.circular(8.0.r));

  static OutlineInputBorder inputFieldUnabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorPrimaryDark, width: 0.5.w),
      borderRadius: BorderRadius.circular(8.0.r));

  static OutlineInputBorder inputFieldUnabledDarkBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorPrimary, width: 0.5.w),
      borderRadius: BorderRadius.circular(8.0.r));

  static OutlineInputBorder inputFieldFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorPrimaryDark, width: 0.5.w),
      borderRadius: BorderRadius.circular(8.0.r));
  static OutlineInputBorder inputFieldUnabledFocusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorFrenchGrey, width: 0.5.w),
      borderRadius: BorderRadius.circular(8.0.r));

  /// Button related style
  static ButtonStyle matchParentButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorPrimary),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(color: AppColors.colorPrimary, width: 0.w))),
  );
  static ButtonStyle matchMciButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorBackgroundScreen),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
            side: BorderSide(
                color: AppColors.colorBackgroundScreen, width: 0.w))),
  );
  static ButtonStyle subscribeNowButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorPrimary),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.r),
            side: BorderSide(color: AppColors.colorPrimary, width: 0.w))),
  );
  static ButtonStyle matchParentButton27Style = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorPrimary),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27.r),
            side: BorderSide(color: AppColors.colorPrimary, width: 0.w))),
  );
  static ButtonStyle matchCloseAccntButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorVividTangerine),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(color: AppColors.colorPrimary, width: 0.w))),
  );

  static ButtonStyle roundedRightIconButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorTitanWhite),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
            side: BorderSide(color: AppColors.colorTitanWhite, width: 0.w))),
  );

  static ButtonStyle socialMediaButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorWhite),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(color: AppColors.colorWhite, width: 0.w))),
  );
  static ButtonStyle socialMediaAppleButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorIcon),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(color: AppColors.colorIcon, width: 0.w))),
  );
  static ButtonStyle socialMediaEmailButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorPrimaryDark),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(color: AppColors.colorPrimaryDark, width: 0.w))),
  );
  static ButtonStyle dialogueYesButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColors.colorPrimary),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(color: AppColors.colorPrimary, width: 0.w))),
  );
}

class AppFontSize {
  static const double heading1 = 21;
  static const double heading2 = 16;
  static const double heading3 = 14;
  static const double heading4 = 12;
  static const double heading5 = 10;
  static const double heading6 = 8;
}
