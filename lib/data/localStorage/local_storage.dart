import 'package:get_storage/get_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/login_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/clubModels/community_config_response.dart';

class LocalStorage
{

  static const accessToken="accessToken";
  static const refreshToken="refreshToken";
  static const verifyToken="verifyToken";
  static const isLoginUser="isLogin";
  static const username="username";
  static const login="login";
  static const communityConfig="community-config";
  static const emailId="email";
  static const countryList="countryList";
  static const userData="user";
  static const isShowNewClubSlider="new-club-slider";

  static void setAccessToken(String token)
   {
     GetStorage().write(accessToken, token);
   }

  static String getAccessToken()
   {
     var token=GetStorage().read(accessToken);
     return token ?? "";
   }

  static void setRefreshToken(String token)
  {
    GetStorage().write(refreshToken, token);
  }

  static String getRefreshToken() {
    var token = GetStorage().read(refreshToken);
    return token ?? "";
  }

  static void setVerifyToken(String token) {
    GetStorage().write(verifyToken, token);
  }

  static String getVerifyToken() {
    var token = GetStorage().read(verifyToken);
    return token ?? "";
  }

  static void setIsLogin(bool isLogin) {
    GetStorage().write(isLoginUser, isLogin);
  }

  static bool getIsLogin() {
    var isLogin = GetStorage().read(isLoginUser) ?? false;
    return (isLogin != null && isLogin) ? true : false;
  }

  static setLoginData(Login user) {
    GetStorage().write(login, user.toJson());
  }

  static Login getLoginData() {
    final userMap = GetStorage().read(login) ?? {};
    return Login.fromJson(userMap);
  }

  static void setEmail(String email) {
    GetStorage().write(emailId, email);
  }

  static String getEmail() {
    var email = GetStorage().read(emailId);
    return email ?? "";
  }

  static setCountryListData(CountryCodeListResponse countryCodeListResponse) {
    GetStorage().write(countryList, countryCodeListResponse.toJson());
  }

  static CountryCodeListResponse getCountryListData() {
    final countryCodeResponse = GetStorage().read(countryList) ?? {};
    return CountryCodeListResponse.fromJson(countryCodeResponse);
  }

  static setUserData(GetUser user) {
    GetStorage().write(userData, user.toJson());
  }

  static GetUser getUserData() {
    final user = GetStorage().read(userData) ?? {};
    return GetUser.fromJson(user);
  }

  static setCommunityConfig(CommunityConfig communityConfigData)
  {
    GetStorage().write(communityConfig, communityConfigData.toJson());
  }

  static CommunityConfig getCommunityConfig()
  {
    final communityConfigData =  GetStorage().read(communityConfig) ?? {};
    return CommunityConfig.fromJson(communityConfigData);
  }

  static bool getIsShowNewClubSliderView()
  {
    var isShowNewClub = GetStorage().read(isShowNewClubSlider)??true;
    return (isShowNewClub==null || isShowNewClub)?true:false;
  }

  static void setIsShowNewClubSliderView(bool isShowNewClub)
  {
    GetStorage().write(isShowNewClubSlider, isShowNewClub);
  }
}


