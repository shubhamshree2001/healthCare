import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/webView/webview_controller.dart';

class WebViewBinding extends Bindings
{
  @override
  void dependencies() {
   Get.put(WebViewScreenController());
  }
}