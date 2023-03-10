import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/user_response.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../callback/payment_callback.dart';
import '../../data/models/therapyModel/checkout_response.dart';

class RazorPayClient
{
  final  String razorpayKey = "rzp_test_n5ogtpZOhjufXQ";
  static const RAZORPAY="RAZORPAY";
  var razorpay = Razorpay();
  late GetUser userData;
  late PaymentCallBack paymentCallBack;

  RazorPayClient(){
    init();
  }

  init()
  {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    userData=LocalStorage.getUserData();
  }


  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    paymentCallBack.onPaymentSuccess(response, RAZORPAY);
   print("Success==$response");
  }

  void handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    paymentCallBack.onPaymentFailed(response, RAZORPAY);
    print("Failed==$response");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void razorPayCheckout(Checkout checkout,PaymentCallBack paymentCallBack)
  {
    this.paymentCallBack=paymentCallBack;
    var request = {
      'key': razorpayKey,
      'amount': checkout.amount, //in the smallest currency sub-unit.
      "currency": checkout.currency,
      'name': '${userData.name}',
      'order_id': checkout.id, // Generate order_id using Orders API
      'description': '',
     /* 'timeout': 60, // in seconds*/
      'prefill': {
        'contact': '${userData.contact?.mobile}',
        'email': '${userData.email}'
      }
    };
    razorpay.open(request);
  }
}