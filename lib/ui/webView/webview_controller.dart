import 'package:get/get.dart';

import '../../constants/strings_constant.dart';

class WebViewScreenController extends GetxController
{

  var url="".obs;
  var isLoading=true.obs;
  @override
  void onInit() {
    url.value= Get.parameters[StringsConstant.urlKey]!;
    super.onInit();
  }

}