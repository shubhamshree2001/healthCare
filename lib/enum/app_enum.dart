enum TherapyPlanEnum
{
  GIFT,
  BOAT,
  VENT_GIFT,
  SESSION,
  COMMUNITY,
  WALLET
}

enum CommunicationModeEnum
{
  VIDEO,
  PHONE,
  CHAT,

}

class CommunicationModeEnumValue{
  static String getValue(String? mode)
  {
    switch(mode)
    {
      case "VIDEO":
        return "Video";
      case "PHONE":
        return "Phone";
      case "CHAT":
        return "Chat";
      default:
        return "";
    }
  }
}

enum TherapySessionEnum
{
  UPCOMING,
  PAST
}

enum PaymentGatewayEnum
{
  RAZORPAY,
  STRIPE
}

enum ApiCallStatus {
  loading,
  success,
  error,
  empty,
  holding,
  cache,
  refresh,
  lazyLoader
}
enum ClubTypeEnum
{
  HOME,
}



