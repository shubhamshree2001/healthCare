import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';

import '../theme/app_color.dart';

extension DoubleExtensions on double
{

  Widget toRatingView()=>  Container(
    decoration: BoxDecoration(
        color: AppColors.colorMediumGreen,
        borderRadius: BorderRadius.all(Radius.circular(3.r))
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.21.w,vertical: 1.5.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:  [
          const Icon(Icons.star,size: 10,color: AppColors.colorWhite),
          SizedBox(width: 3.45.w,),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child:"$this".toHeading6(color: AppColors.colorWhite)
          )
        ],
      ),
    ),
  );

  SizedBox get toSizedBoxVertical => SizedBox(height: this);
  SizedBox get toSizedBoxHorizontal => SizedBox(width: this);
}