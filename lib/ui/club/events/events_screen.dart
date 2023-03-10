import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/appUtils/app_util.dart';
import 'package:mindpeers_mobile_flutter/constants/fonts_constant.dart';
import 'package:mindpeers_mobile_flutter/constants/images_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/event_list_response.dart';
import 'package:mindpeers_mobile_flutter/extensions/double_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/list_widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/string_extensions.dart';
import 'package:mindpeers_mobile_flutter/extensions/widget_extensions.dart';
import 'package:mindpeers_mobile_flutter/ui/club/events/events_controller.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';
import 'package:mindpeers_mobile_flutter/widgets/response_widget_animator.dart';
import '../../../repository/clubRepo/club_repo_impl.dart';
import '../../../routes/app_pages.dart';
import '../../../service/graph_ql_configuration.dart';
import '../../../theme/dark_theme_app_color.dart';

class EventsScreen extends GetView<EventsController>
{
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EventsController(clubRepo: Get.put(ClubRepoImpl(graphQLConfiguration: Get.find<GraphQLConfiguration>()))));
    return  Scaffold(
      backgroundColor: DarkThemeAppColors.colorBackgroundScreen,
      body:Obx(() => eventsScreenBody()),
    );
  }

  Widget eventsScreenBody()
  {
    return Column(
      children: [
        20.h.toSizedBoxVertical,
        ResponseWidgetsAnimator(
            apiCallStatus: controller.eventListApiStatus.value,
            loadingWidget: (){
              return showProgress();
            },
            errorWidget: (){
              return SizedBox();
            },
            successWidget:(){
              return eventListView();
            }
        ),
        20.h.toSizedBoxVertical,
      ],
    ).toHorizontalPadding(33.w);
  }
  
  Widget eventListView()
  {
    return ListView.separated(
        itemCount: controller.eventList.length,
        shrinkWrap: true,
        separatorBuilder:(context,index){
          return Padding(padding: EdgeInsets.only(top: 29.h));
        },
        itemBuilder: (context,index){
          if(controller.eventList[index].type=="PROMO_CARD")
            {
              return promoCardItem(controller.eventList[index],index);
            }
          return eventItem(controller.eventList[index],index);
        },
    );
  }

  Widget eventItem(CommunityEvent communityEvent,int index)
  {
    return Container(
      decoration: BoxDecoration(
        color: DarkThemeAppColors.colorBackgroundCard,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "${communityEvent.name}".toHeading3(color: DarkThemeAppColors.colorTitle),
                  4.h.toSizedBoxVertical,
                  AppUtil.convertStringToDateFormat(communityEvent.start,format:AppUtil.dateTimeMMMDYHHMMA).toHeading4(fontFamily: FontsConstant.appRegularFont,color: DarkThemeAppColors.colorSubTitle),
                  7.h.toSizedBoxVertical,
                  "${communityEvent.enrolled?.enrolledText}".toHeading4(fontFamily: FontsConstant.appRegularFont,color: const Color(0xFFFF0000)),
                  17.h.toSizedBoxVertical,
                 [
                   if(communityEvent.cta!=null && communityEvent.cta!.text!=null &&  communityEvent.cta!.text!.isNotEmpty) ...[
                     "${communityEvent.cta?.text}".toHeading3(color:DarkThemeAppColors.colorTitle,textDecoration: TextDecoration.underline),
                   ],

                   8.w.toSizedBoxHorizontal,
                   ImagesConstant.rightArrow.toSvg(color: DarkThemeAppColors.colorWhite)
                 ].toRow().onTapWidget(() {
                   if(communityEvent.locked!)
                     {
                       controller.redirectToPlanScreen();
                     }
                   else
                     {
                       controller.getMeetLink(communityEvent.id!);
                     }
                 }),
                  14.h.toSizedBoxVertical,
                ],
              ).toPaddingOnly(top: 25.h,left: 18.w).toExpanded(),
              Stack(
                children: [
                  "${communityEvent.image}".toNetWorkBackgroundImage(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 3.h),
                    decoration: BoxDecoration(
                      color: Color(0xFFFF8556),
                      borderRadius: BorderRadius.circular(13.r)
                    ),
                    child: "Live".toHeading4(color: DarkThemeAppColors.colorBlack),
                  ).toAlign(alignment: Alignment.topRight).paddingOnly(top: 14.h,right: 13.w).toVisibility(communityEvent.isLive!)
                ],
              ).toExpanded()
            ],
          )
        ],
      ),
    ).onTapWidget(() {
      if(communityEvent.id!=null)
        {
          controller.getBoatAvailability(communityEvent.slug!);
        }
    });
  }

  Widget promoCardItem(CommunityEvent communityEvent,int index)
  {
    return  Stack(
      alignment: Alignment.center,
      children: [
        "${communityEvent.backgroundImage}".toNetWorkBackgroundImage(),
        [
          "${communityEvent.text}".toHeading2(color: DarkThemeAppColors.colorBlack).toExpanded(),
          "${communityEvent.image}".toNetWorkImage()
        ].toRow().toSymmetricPadding(20.w, 20.h).onTapWidget(() { Get.toNamed(Routes.plan);})
      ],
    );
  }
}