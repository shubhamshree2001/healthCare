import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindpeers_mobile_flutter/callback/callback.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/apiPhoneNoResponse.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/request/signup_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/navigationParamsModel/navigation_params_model.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/auth_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/authRepo/auth_repo.dart';
import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:http/http.dart' as http;

import '../../../data/localStorage/local_storage.dart';
import '../../../widgets/common_widget.dart';

class WelcomeScreenController extends GetxController {
  final AuthRepo authRepo;

  WelcomeScreenController({required this.authRepo});
  var selectedStrengthIndex = 0.obs;
  final corporateAccessCodeController = TextEditingController();
  final manualPhoneNumber = TextEditingController();
  late GoogleSignIn googleSign;
  var isAccessOrganization = false.obs;
  var isSignIn = false.obs;
  var receiveParams = NavigationParamsModel().obs;
  FocusNode focusNode = FocusNode();
  CallBack? callBack;
  GoogleSignInAccount? currentUser;
  GoogleApiPhoneNumberResponse? phoneNumber;

  @override
  void onInit() {
    googleSign = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/user.phonenumbers.read',
        //'https://www.googleapis.com/auth/user.gender.read'
        //'https://www.googleapis.com/auth/userinfo.profile.',
      ],
    );
    super.onInit();
  }

  Future<void> signUpApiCall(String query) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo.userSignup(query);
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.signup != null) {
          if (r.signup!.verifyToken != null &&
              r.signup!.verifyToken!.isNotEmpty) {
            Get.toNamed(Routes.emailOtpScreen,
                arguments: [currentUser!.email, r.signup!.verifyToken]);
          } else {
            LocalStorage.setAccessToken(r.signup!.accessToken!);
            LocalStorage.setRefreshToken(r.signup!.refreshToken!);
            LocalStorage.setIsLogin(true);
            Get.offAllNamed(Routes.dashboard);
          }
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void checkSignupValidation() {
    hideSoftKeyboard(Get.context!);
    //final isValid = signupFormKey.currentState!.validate();
    if (currentUser == null) {
      //!isValid
      return;
      // } else if (!termAndConditionCheckBox.value) {
      //   showSnackBar("Error", "Please agree to the terms & conditions", true);
    } else {
      //Get.toNamed(Routes.dashboard); //temporaryCHeck
      //Get.toNamed(Routes.privacyPolicyScreen); //added by shubham
      //signupFormKey.currentState!.save();

      var signupRequest = SignupRequest(
          code: "+91",
          mobileNo: phoneNumber!.phoneNumbers![0].canonicalForm.toString(),
          email: currentUser!.email,
          name: currentUser!.displayName.toString(),
          password: "master",
          org: "");

      if (isAccessOrganization.value) {
        getOrganization(signupRequest);
      } else {
        signUpApiCall(AuthQueryMutation.userSignup(signupRequest));
      }
    }
  }

  Future<void> getOrganization(SignupRequest signupRequest) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo.getOrganization(
          AuthQueryMutation.getOrganization(
              corporateAccessCodeController.text));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.organisation != null) {
          signupRequest.org = r.organisation!.id;
          signUpApiCall(AuthQueryMutation.userSignupCorporate(signupRequest));
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> loginApiCall() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.custom);
      final either = await authRepo
          .userLogin(AuthQueryMutation.userLogin(currentUser!.email, "master"));
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.login != null) {
          if (r.login!.verifyToken != null &&
              r.login!.verifyToken!.isNotEmpty) {
            Get.toNamed(Routes.otp,
                arguments: [currentUser!.email, r.login!.verifyToken]);
          } else {
            LocalStorage.setAccessToken(r.login!.accessToken!);
            LocalStorage.setRefreshToken(r.login!.refreshToken!);
            LocalStorage.setIsLogin(true);
            LocalStorage.setEmail(currentUser!.email);
            Get.offAllNamed(Routes.dashboard);
          }
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  ///for account signup

  Future googleLogin() async {
    //(CallBack callBack)
    //this.callBack = callBack;
    final googleUser = await googleSign.signIn();

    currentUser = googleUser!;
    if (currentUser == null) {
      showSnackBar("Error", "SignUpFailed", true);
    } else {
      getUserPHoneNumber();
      // print(currentUser!.displayName);
      // LocalStorage.setIsLogin(true);
      // Get.offAllNamed(Routes.dashboard);
    }
  }

  /// for account login

  Future googleAccountLogin() async {
    final googleUser = await googleSign.signIn();
    currentUser = googleUser!;
    if (currentUser == null) {
      showSnackBar("Error", "loginFailed", true);
    } else {
      loginApiCall();
    }
  }

  Future getUserPHoneNumber() async {
    const host = "https://people.googleapis.com";
    const endpoint = "/v1/people/me?personFields=names,phoneNumbers";
    final header = await googleSign.currentUser!.authHeaders;

    final response =
        await http.get(Uri.parse("$host$endpoint"), headers: header);

    if (response != null) {
      phoneNumber = googleApiPhoneNumberResponseFromJson(response.body);
      if (phoneNumber!.phoneNumbers![0].canonicalForm!.isNotEmpty) {
        checkSignupValidation();
      }
      // print(response.body);
      // print(phoneNumber!.phoneNumbers![0].canonicalForm);
    } else {
      //callBack!.onCall();
      print("$response");
    }
  }
}
