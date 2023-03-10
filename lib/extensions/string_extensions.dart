import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/theme/app_color.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:skeletons/skeletons.dart';

import '../theme/app_theme.dart';

extension StringExtensions on String
{
  Widget toNetWorkImage(
      {double? height, double? width}){

    if(contains(".svg"))
      {
        return SvgPicture.network(
          this,
            height: height,
            width: width,
            fit: BoxFit.contain,
            placeholderBuilder: (context)=>SvgPicture.asset(ImagesConstant.profilePlaceholder)
        );
      }
    else
      {
        return CachedNetworkImage(
          imageUrl: this,
          height: height,
          width: width,
          fit: BoxFit.contain,
          placeholder: (context, url)=>SvgPicture.asset(ImagesConstant.profilePlaceholder),
          errorWidget: (context, url, error) => SvgPicture.asset(ImagesConstant.profilePlaceholder),
        );
      }
  }


  Widget toNetWorkBackgroundImage(
      {double? height, double? width}){

    if(contains(".svg"))
    {
      return SvgPicture.network(
          this,
          height: height,
          width: width,
          fit: BoxFit.contain,
          placeholderBuilder: (context)=>SvgPicture.asset(ImagesConstant.bannerPlaceholder)
      );
    }
    else
    {
      return CachedNetworkImage(
        imageUrl: this,
        height: height,
        width: width,
        fit: BoxFit.contain,
        placeholder: (context, url)=>SvgPicture.asset(ImagesConstant.bannerPlaceholder),
        errorWidget: (context, url, error) => SvgPicture.asset(ImagesConstant.bannerPlaceholder),
      );
    }
  }


  Widget toProfileNetWorkImage(
      {double? height, double? width}){

    if(contains(".svg"))
    {
      return SvgPicture.network(
        this,
        height: height,
        width: width,
        fit: BoxFit.contain,
        placeholderBuilder: (context)=>SvgPicture.asset(ImagesConstant.profilePlaceholder),
      );
    }
    else
    {
      return CachedNetworkImage(
        imageUrl: this,
        height: height,
        width: width,
        fit: BoxFit.contain,
        placeholder: (context, url)=>SvgPicture.asset(ImagesConstant.profilePlaceholder),
        errorWidget: (context, url, error) => SvgPicture.asset(ImagesConstant.profilePlaceholder),
      );
    }
  }

  Widget toProfileRoundedNetWorkImage(
      {double height = 50, double width = 50, double borderRadius = 25}) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.toDouble()),
        child: CachedNetworkImage(
          imageUrl: trim(),
          height: height,
          width: width,
          fit: BoxFit.cover,
          placeholder: (context, url)=>SvgPicture.asset(ImagesConstant.profilePlaceholder,fit: BoxFit.cover,width: width,height: height),
          errorWidget: (context, url, error) => SvgPicture.asset(ImagesConstant.profilePlaceholder,fit: BoxFit.cover,width: width,height: height),
        ),
      );


  Widget toRoundedNetWorkImage(
      {double height = 50, double width = 50, double borderRadius = 25}) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.toDouble()),
        child: CachedNetworkImage(
          imageUrl: trim(),
          height: height,
          width: width,
          fit: BoxFit.cover,
          placeholder: (context, url)=>SvgPicture.asset(ImagesConstant.profilePlaceholder),
          errorWidget: (context, url, error) => SvgPicture.asset(ImagesConstant.profilePlaceholder),
        ),
      );

  SvgPicture toSvg({double? height, double? width, Color? color,BoxFit boxFit = BoxFit.contain}) =>
      SvgPicture.asset(this,
          color: color,
          width: width,
          height: height,
          fit: boxFit,
      );

  Image toAssetImage({double? height, double? width}) =>
      Image.asset(this, height: height, width: width);


   Text toHeading1(
      {
        String fontFamily = FontsConstant.appBoldFont,
        Color color = AppColors.colorBlack,
        TextAlign textAlign=TextAlign.start,
        TextDecoration textDecoration= TextDecoration.none,
        double letterSpacing=0.2
      }) =>
      Text(
        this,
        style:AppTheme.heading1.copyWith(fontFamily: fontFamily, color: color,decoration:textDecoration,letterSpacing: letterSpacing),
        textAlign: textAlign,
      );


  Text toHeading2(
      {
        String fontFamily = FontsConstant.appBoldFont,
        Color color = AppColors.colorBlack,
        TextAlign textAlign=TextAlign.start,
        TextDecoration textDecoration= TextDecoration.none,
        double letterSpacing=0.2
      }) =>
      Text(
        this,
        style:AppTheme.heading2.copyWith(fontFamily: fontFamily, color: color,decoration:textDecoration,letterSpacing: letterSpacing),
        textAlign: textAlign,
      );

  Text toHeading3(
      {
        String fontFamily = FontsConstant.appBoldFont,
        Color color = AppColors.colorBlack,
        TextAlign textAlign=TextAlign.start,
        TextDecoration textDecoration= TextDecoration.none,
        double letterSpacing=0.2
      }) =>
      Text(
        this,
        style:AppTheme.heading3.copyWith(fontFamily: fontFamily, color: color,decoration:textDecoration,letterSpacing: letterSpacing),
        textAlign: textAlign,
      );

  Text toHeading4(
      {
        String fontFamily = FontsConstant.appBoldFont,
        Color color = AppColors.colorBlack,
        TextAlign textAlign=TextAlign.start,
        TextDecoration textDecoration= TextDecoration.none,
        double letterSpacing=0.2
      }) =>
      Text(
        this,
        style:AppTheme.heading4.copyWith(fontFamily: fontFamily, color: color,decoration:textDecoration,letterSpacing: letterSpacing),
        textAlign: textAlign,
      );

  Text toHeading5(
      {
        String fontFamily = FontsConstant.appBoldFont,
        Color color = AppColors.colorBlack,
        TextAlign textAlign=TextAlign.start,
        TextDecoration textDecoration= TextDecoration.none,
        double letterSpacing=0.2
      }) =>
      Text(
        this,
        style:AppTheme.heading5.copyWith(fontFamily: fontFamily, color: color,decoration:textDecoration,letterSpacing: letterSpacing),
        textAlign: textAlign,
      );

  Text toHeading6(
      {
        String fontFamily = FontsConstant.appBoldFont,
        Color color = AppColors.colorBlack,
        TextAlign textAlign=TextAlign.start,
        TextDecoration textDecoration= TextDecoration.none,
        double letterSpacing=0.2
      }) =>
      Text(
        this,
        style:AppTheme.heading6.copyWith(fontFamily: fontFamily, color: color,decoration:textDecoration,letterSpacing: letterSpacing),
        textAlign: textAlign,
      );

  /*ReadMoreText toReadMoreText({
    int trimLines=3,
    String trimCollapsedText="more",
    String trimExpandedText="",
    double fontSize=AppFontSize.heading2,
    String fontFamily = FontsConstant.appBoldFont,
    Color color = AppColors.colorBlack,
    TextAlign textAlign=TextAlign.start,
    TextDecoration textDecoration= TextDecoration.none,
    double letterSpacing=0.2
   })=>
   ReadMoreText(
     this,

     trimMode: TrimMode.Line,
     trimLines: trimLines,
     trimCollapsedText: trimCollapsedText,
     trimExpandedText: trimExpandedText,
     style: AppTheme.heading6.copyWith(fontSize:fontSize,fontFamily: fontFamily, color: color,decoration:textDecoration,letterSpacing: letterSpacing),
     moreStyle: AppTheme.heading6.copyWith(fontSize:fontSize,fontFamily: fontFamily, color: const Color(0xFF00DFEB)),
   );*/


  Text toText(
      {
        double fontSize=AppFontSize.heading6,
        String fontFamily = FontsConstant.appBoldFont,
        Color color = AppColors.colorBlack,
        TextAlign textAlign=TextAlign.start,
        TextDecoration textDecoration= TextDecoration.none,
        double letterSpacing=0.2
      }) =>
      Text(
        parseHtmlString(this),
        style:AppTheme.heading6.copyWith(fontSize:fontSize,fontFamily: fontFamily, color: color,decoration:textDecoration,letterSpacing: letterSpacing),
        textAlign: textAlign,
      );

  String parseHtmlString(String htmlString) {
    if(htmlString==null)return '';
    final unescape = HtmlUnescape();
    final text = unescape.convert(htmlString).replaceAll(
        RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true), "");
    return text;
  }

}
