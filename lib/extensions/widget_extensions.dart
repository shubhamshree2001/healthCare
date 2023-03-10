import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:mindpeers_mobile_flutter/theme/dark_theme_app_color.dart';
import '../theme/app_theme.dart';

extension WidgetExtensions on Widget {

  Align toAlign({Alignment alignment = Alignment.topLeft}) => Align(
        alignment: alignment,
        child: this,
      );

  SizedBox toSizedBox(double height, double width) => SizedBox(
        height: height,
        width: width,
        child: this,
      );
  SizedBox toSizedBoxHeight(double height) => SizedBox(
        height: height,
        child: this,
      );

  SizedBox toSizedBoxWidth(double width) => SizedBox(
        width: width,
        child: this,
      );

  Widget toPadding(double value) => Padding(
        padding: EdgeInsets.symmetric(vertical: value, horizontal: value),
        child: this,
      );

  Widget toSymmetricPadding(double horizontal, double vertical) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget toHorizontalPadding(double horizontal) => Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal),
        child: this,
      );

  Widget toVerticalPadding(double vertical) => Padding(
        padding: EdgeInsets.symmetric(vertical: vertical),
        child: this,
      );

  Widget toPaddingOnly(
          {double top = 0,
          double bottom = 0,
          double right = 0,
          double left = 0}) =>
      Padding(
          padding: EdgeInsets.only(
              top: top, right: right, left: left, bottom: bottom),
        child: this,
      );

  Widget get toSafeArea => SafeArea(
        child: this,
      );

  Widget get toSingleChildScrollView => SingleChildScrollView(
        child: this,
      );

  Widget toCenter() => Container(
    alignment: Alignment.center,
    child: this,
  );

  Widget toObx()=>Obx(() =>this);

  Container toContainer(
      {
        AlignmentGeometry alignment = Alignment.topLeft,
        double? height,
        double? width,
        Color? color,
        BoxDecoration? decoration,
      }) =>
      Container(
        alignment: alignment,
        color: color,
        decoration: decoration,
        height: height,
        width: width,
        child: this,
      );

  Positioned toPositioned(
      {
        double? height,
        double? width,
        double? left,
        double? top,
        double? right,
        double? bottom,

      }) =>
      Positioned(
        height: height,
        width: width,
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        child: this,
      );

  Card toCard(
      {
        Color? color,
        double? elevation=5,
        Color? shadowColor,
        ShapeBorder? shape,
        bool semanticContainer=true,
        bool borderOnForeground=true
      }) =>
      Card(
        elevation: elevation,
        color: color,
        shadowColor: shadowColor,
        semanticContainer: semanticContainer,
        borderOnForeground: borderOnForeground,
        shape: shape,
        child: this,
      );



  Expanded toExpanded({int flex = 1}) => Expanded(
    flex: flex,
    child: this,
  );

  Flexible toFlexible({int flex = 1}) => Flexible(
    flex: flex,
    child: this,
  );

  Widget toVisibility(bool visibility)=> Visibility(visible: visibility,child: this);

  TextButton toTextButton(VoidCallback callback) => TextButton(
    onPressed: callback,
    child: this
  );

  Widget onTapWidget(VoidCallback callback,{bool removeFocus=true,VoidCallback? onLongPress}) => InkWell(
    onLongPress: onLongPress,
    splashColor: Colors.transparent,
    onTap: () {
      if(removeFocus)
      {
        FocusManager.instance.primaryFocus?.unfocus();
      }
      callback.call();
    },
    child: this,
  );

  Widget toRoundedButtonMatchParent(
      VoidCallback voidCallback,
      {Color color=AppColors.colorPrimary}
      ) =>
      ElevatedButton(
          onPressed: voidCallback,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27.r),
                )
            ),
          ),
          child: this
      ).toSizedBox(54.9.h, 1.sw);

  Widget toRoundedButtonWrapContent(
      VoidCallback voidCallback,
      {
        double height=0,
        double width=0,
        double borderWidth=1,
        Color color=AppColors.colorPrimary,
        Color borderColor=AppColors.colorPrimary
      }
      ) =>
      ElevatedButton(
          onPressed: voidCallback,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27.r),
                    side:  BorderSide(
                        color: borderColor,
                        width: borderWidth
                    )
                )
            ),
          ),
          child: this
      ).toSizedBox(height==0?54.9.h:height,width==0?100.w:width);


  Widget toSquareButtonMatchParent(
      VoidCallback voidCallback,
      {
        Color color=AppColors.colorPrimary,
        double height=0,
        double width=0
      }
      ) =>
      ElevatedButton(
          onPressed: voidCallback,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                  side: const BorderSide(
                      color: AppColors.colorPrimary
                  )
                )
            ),
          ),
          child: this
      ).toSizedBox(height==0?54.9.h:height, width==0?1.sw:width);


  Widget toSquareButtonWrapContent(
      VoidCallback voidCallback,
      {
        Color color=AppColors.colorPrimary,
        double height=0,
      }
      ) =>
      ElevatedButton(
          onPressed: voidCallback,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                    side:  BorderSide(
                        color:color
                    )
                )
            ),
          ),
          child: this
      ).toSizedBoxHeight(height==0?54.9.h:height);


  Widget toRoundedButtonIcon(
      VoidCallback voidCallback,
      {
        Color shadowColor=DarkThemeAppColors.colorPrimary,
        Color color=DarkThemeAppColors.colorWhite,
        double horizontalPadding = 30,
        double verticalPadding = 10,
        bool isVisibleIcon = false
      }
      ) =>
      InkWell(
        onTap: voidCallback,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24.r)),
                  color: shadowColor
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal:horizontalPadding,vertical: verticalPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24.r)),
                    color: color
                ),
                child: Row(
                  children: [
                    ImagesConstant.checked24.toSvg(width: 20.w,height: 20.h).toVisibility(isVisibleIcon),
                    5.w.toSizedBoxHorizontal,
                    this
                  ],
                ),
              ).toPaddingOnly(bottom: 3.h),
            ),
          ],
        )
      );


  Widget toSquareButton(
      VoidCallback voidCallback,
      {
        Color shadowColor=DarkThemeAppColors.colorPrimary,
        Color color=DarkThemeAppColors.colorWhite,
        double horizontalPadding = 30,
        double verticalPadding = 10,
        bool enable=true
      }
      ) =>
      InkWell(
        onTap: voidCallback,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.r)),
              color: shadowColor
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal:horizontalPadding,vertical: verticalPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
                color: enable?color:DarkThemeAppColors.colorDisableButton
            ),
            child: this,
          ).toPaddingOnly(bottom: enable?3.h:0),
        ),
      );


  Form toForm({required GlobalKey globalKey})=>Form(
      key: globalKey,
      child: this
  );



  TextFormField toTextFormField({
    required TextEditingController controller,
    required String? Function(String?)? validator,
    AutovalidateMode autoValidateMode=AutovalidateMode.onUserInteraction,
    void Function(String?)? onChange,
    bool readOnly=false,
    TextInputType keyboardType = TextInputType.text,
    Color fillColor = AppColors.colorWhite,
    int maxLines=1,
    int errorMaxLines=1,
    List<TextInputFormatter>?inputFormatter
  })=>TextFormField(
    controller: controller,
    autovalidateMode: autoValidateMode,
    readOnly: readOnly,
    keyboardType: keyboardType,
    maxLines: maxLines,
    inputFormatters: inputFormatter,
    style: AppTheme.heading2.copyWith(color: AppColors.colorDavyGray,fontFamily: FontsConstant.appRegularFont),
    decoration: InputDecoration(
        isDense: true,
        errorMaxLines: errorMaxLines,
        contentPadding:
        EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
        border: AppTheme.inputFieldBorder,
        enabledBorder: AppTheme.inputFieldEnabledBorder,
        focusedBorder: AppTheme.inputFieldFocusBorder,
        errorBorder: AppTheme.inputFieldEnabledBorder,
        filled: true,
        fillColor: readOnly
            ? AppColors.colorPorcelain
            : AppColors.colorWhite
    ),
    validator: validator,
    onChanged: onChange,
  );
}

TextFormField toTransparentTextFormField({
  required TextEditingController controller,
  required String? Function(String?)? validator,
  AutovalidateMode autoValidateMode=AutovalidateMode.onUserInteraction,
  void Function(String?)? onChange,
  bool readOnly=false,
  TextInputType keyboardType = TextInputType.text,
  Color fillColor = AppColors.colorWhite,
  int maxLines=1,
  int errorMaxLines=1,
  String? hintText ="",
  Color? hintColor=DarkThemeAppColors.colorSubTitle,
  Color? textColor=DarkThemeAppColors.colorTitle,
  List<TextInputFormatter>?inputFormatter
})=>TextFormField(
  controller: controller,
  autovalidateMode: autoValidateMode,
  readOnly: readOnly,
  keyboardType: keyboardType,
  maxLines: maxLines,
  inputFormatters: inputFormatter,
  style: AppTheme.heading2.copyWith(color: textColor,fontFamily: FontsConstant.appRegularFont),
  decoration: InputDecoration(
      isDense: true,
      hintStyle: AppTheme.heading2.copyWith(color: hintColor,fontFamily: FontsConstant.appRegularFont),
      hintText: hintText,
      errorMaxLines: errorMaxLines,
      contentPadding:
      EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
      border: const UnderlineInputBorder(
        borderSide: BorderSide.none
      ),
      filled: true,
      fillColor: readOnly
          ? AppColors.colorPorcelain
          : fillColor
  ),
  validator: validator,
  onChanged: onChange,
);

extension CountryCodeExtension on List<CountryCodeItem>
{
  Widget toMobileCodeDropdown({
    required CountryCodeItem selectedCountryCode,
    required void Function(CountryCodeItem?)onChange,
    bool readOnly=false

  }) => IgnorePointer(
    ignoring: readOnly,
    child: Container(
      width: 90.w,
      height: 43.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.colorPrimary,
        ),
        color: readOnly
            ? AppColors.colorPorcelain
            : AppColors.colorWhite,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CountryCodeItem>(
          value: selectedCountryCode,
          // isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 20,
          menuMaxHeight: 0.4.sh,
          onChanged:onChange,
          items: this.map((CountryCodeItem map) {
            return DropdownMenuItem<CountryCodeItem>(
                value: map,
                child: Row(
                  children: [
                    SvgPicture.network(map.flag!),
                    Text(map.code!,
                        style: AppTheme.regularBlack14spTextStyle),
                  ],
                )
            );
          }).toList(),
        ),
      ),
    ),
  );

}

