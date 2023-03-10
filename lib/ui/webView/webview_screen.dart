import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/ui/webView/webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends GetView<WebViewScreenController>
{
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(()=>SafeArea(child: webViewScreenBody())));
  }

  Widget webViewScreenBody()
  {
    return Stack(
      children: [
        WebView(
          initialUrl: controller.url.value,
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (String url) {
            print('Page started loading: $url');

          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            controller.isLoading.value=false;
          },
        ),
        controller.isLoading.value?const Center(
          child: CircularProgressIndicator(),
        ):Stack()
      ],
    );
  }

}