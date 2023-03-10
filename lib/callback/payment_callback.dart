abstract class PaymentCallBack
{
  void onPaymentSuccess(dynamic response,String type);
  void onPaymentFailed(dynamic response,String type);
}