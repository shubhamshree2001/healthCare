import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';

class CommunityListRequest
{
  String screen;
  List? inclusive;
  List? exclusive;
  int? limit;
  int? offset;

  CommunityListRequest({
    required this.screen,
    this.inclusive,
    this.exclusive,
    this.limit = 100,
    this.offset = 0,
  });

  Map<String, dynamic> toMap() {

    if(screen == "HOME")
      {
        return {
          'token': LocalStorage.getAccessToken(),
          'screen': screen,
          'inclusive': inclusive,
          'exclusive': exclusive,
          'limit':limit,
          'offset':offset
        };
      }
    else
      {
        return {
          'token': LocalStorage.getAccessToken(),
          'limit':limit,
          'offset':offset
        };
      }

  }
}