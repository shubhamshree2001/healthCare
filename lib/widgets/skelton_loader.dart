import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:skeletons/skeletons.dart';

Widget clubListSkeleton()
{
  return ListView.separated(
    itemCount: 20,
    scrollDirection: Axis.horizontal,
    physics: const NeverScrollableScrollPhysics(),
    separatorBuilder: (context,index){
    return Padding(padding: EdgeInsets.only(left: 23.r));
    },
    itemBuilder: (context,index){
      return Column(
        children: [
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
                shape: BoxShape.circle, width: 84.w, height: 84.h),
          ),
        ],
      );
    },
  ).toHorizontalPadding(20.w);
}

Widget ventListSkeleton()
{
  return ListView.separated(
    itemCount: 20,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    separatorBuilder: (context,index){
      return Padding(padding: EdgeInsets.only(left: 23.r));
    },
    itemBuilder: (context,index){
      return  Column(
        children: [
          Row(
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    shape: BoxShape.circle, width: 84.w, height: 84.h),
              ),
              10.w.toSizedBoxHorizontal,
              [
                const SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 5,
                    maxLength: 2  ,
                  ),
                ),
                5.h.toSizedBoxVertical,
                const SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 5,
                    maxLength: 2  ,
                  ),
                )
              ].toColumn()

            ],
          ),
           SkeletonLine(
            style: SkeletonLineStyle(
              height: 5.h,
              maxLength: 2  ,
            ),
          ),
          5.h.toSizedBoxVertical,
           SkeletonLine(
            style: SkeletonLineStyle(
              height: 5.h,
              maxLength: 2  ,
            ),
          ),
          5.h.toSizedBoxVertical,
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 5.h,
              maxLength: 2  ,
            ),
          )
        ],
      );
    },
  );
}