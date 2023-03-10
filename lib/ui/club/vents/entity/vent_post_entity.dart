import 'package:mindpeers_mobile_flutter/data/models/clubModels/vent_list_response.dart';

class VentPostEntity
{
   int ventTotal;
   int venLimit;
   int ventOffset;
   String lastFetchTime;
   List<Vent> ventList;

   VentPostEntity({
      required this.ventTotal,
      required this.venLimit,
      required this.ventOffset,
      required this.lastFetchTime,
      required this.ventList
   });

   factory VentPostEntity.from(VentListResponse ventListResponse){
    return VentPostEntity(
     ventTotal: ventListResponse.ventOutWallMessagesTotal,
     venLimit: ventListResponse.ventOutWallMessagesLimit,
     ventOffset: ventListResponse.ventOutWallMessagesOffset,
     lastFetchTime: ventListResponse.auth?.listVents?.lastFetchedTime!=null?ventListResponse.auth!.listVents!.lastFetchedTime!:"",
     ventList: ventListResponse.auth?.listVents?.ventList!=null?ventListResponse.auth!.listVents!.ventList!:[],
    );
   }
}

/*class VentEntity
{
   String id;
   String userName;
   String message;
   bool verified;
   String userTitle;
   String avatar;
   String ventTime;
   int likesCount;
   int repliesCount;
   bool isLiked;
   bool isSensitive;
   bool isGiftingEnabled;
   Share share;
   String type;
   String backgroundImage;
   String text;
   String image;
   bool isAnonymous;
   List<String> resources;
   List<ResourceObject> resourceObjects;
   Cta cta;
   bool pinned;
   bool locked;

   VentEntity({
      required this.id,
      required this.userName,
      required this.message,
      required this.verified,
      required this.userTitle,
      required this.avatar,
      required this.ventTime,
      required this.likesCount,
      required this.repliesCount,
      required this.isLiked,
      required this.isSensitive,
      required this.isGiftingEnabled,
      required this.share,
      required this.type,
      required this.backgroundImage,
      required this.text,
      required this.image,
      required this.isAnonymous,
      required this.resources,
      required this.resourceObjects,
      required this.cta,
      required this.pinned,
      required this.locked,
   });


   factory VentEntity.from(Vent vent){
      return VentEntity(
         id: vent.id??"",
         userName: vent.userName??"",
         message: vent.userName??"",
         verified: vent.verified??false,
         userTitle: ventListResponse.auth?.listVents?.ventList!=null?ventListResponse.auth!.listVents!.ventList!:[],
         avatar:

      );
   }*/

