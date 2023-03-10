import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/auth_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/authRepo/auth_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';

import '../../../widgets/common_widget.dart';

class SendResetLinkController extends GetxController {
  final AuthRepo authRepo;

  SendResetLinkController({required this.authRepo});

  var email = "".obs;
  final emailController = TextEditingController();
  var receiveParams = NavigationParamsModel().obs;
  @override
  void onInit() {
    //email.value = Get.arguments;
    receiveParams.value = Get.arguments;
    emailController.text =
        receiveParams.value.email.toString(); //"ABC"; //Get.arguments;
    initEasyLoading();
    super.onInit();
  }

  Future<void> sendLinkForgotPass() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo.sendLinkForgotPass(
          AuthQueryMutation.sendLinkForgotPass(email.value));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r != null) {
          showSnackBar("", "Reset link sent to your email", false);
          Get.offAllNamed(Routes.initial);
          //TO BE DIRECTED TO Get.offAllNamed(Routes.welcomeScreen/ or / Routes.LoginDarkMOdeScreen)
        }

        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }
}
