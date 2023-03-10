import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/auth_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/authRepo/auth_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:otp_text_field/otp_field.dart';
import '../../../widgets/common_widget.dart';

class OtpController extends GetxController {
  final AuthRepo authRepo;

  OtpController({required this.authRepo});

  final otpController = OtpFieldController();
  var email = "".obs;
  var otp = "".obs;
  var verifyToken = "";

  @override
  void onInit() {
    // email.value = Get.arguments[0];
    // verifyToken = Get.arguments[1];
    initEasyLoading();
    super.onInit();
  }

  Future<void> verifyOtp() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo
          .verifyOtp(AuthQueryMutation.verifyOtp(otp.value, verifyToken));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.verifyOtp != null) {
          LocalStorage.setAccessToken(r.verifyOtp!.accessToken!);
          LocalStorage.setRefreshToken(r.verifyOtp!.refreshToken!);
          LocalStorage.setIsLogin(true);
          LocalStorage.setEmail(email.value);
          Get.toNamed(Routes.home, arguments: r);
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void checkOtpValidation() {
    hideSoftKeyboard(Get.context!);
    if (otp.value.isEmpty) {
      showSnackBar("Error", "Enter Otp", true);
    } else {
      verifyOtp();
    }
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    super.onClose();
  }
}
