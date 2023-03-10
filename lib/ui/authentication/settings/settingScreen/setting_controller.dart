import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindpeers_mobile_flutter/callback/callback.dart';
import 'package:mindpeers_mobile_flutter/constants/strings_constant.dart';
import 'package:mindpeers_mobile_flutter/data/localStorage/local_storage.dart';
import 'package:mindpeers_mobile_flutter/data/models/authModel/country_code_list_response.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/deleteUser_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/logoutUser.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/referUs_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/requestSetting/submitFeedback_request.dart';
import 'package:mindpeers_mobile_flutter/data/models/settingModel/responseSetting/feedback_questionsList.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/auth_query_mutation.dart';
import 'package:mindpeers_mobile_flutter/data/queryMutation/setting_query_Mutation.dart';
import 'package:mindpeers_mobile_flutter/repository/settingRepo/setting_repo.dart';

import 'package:mindpeers_mobile_flutter/routes/app_pages.dart';
import 'package:mindpeers_mobile_flutter/widgets/common_widget.dart';

class SettingController extends GetxController {
  final SettingRepo settingRepo;

  SettingController({required this.settingRepo});
  var rating = 0.0.obs;
  List<String> reasonList =
      ["don't need", "expensive", "switching", "other"].obs;
  var selectedreasons = "".obs;
  final nameController = TextEditingController();
  final orgNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final ratingFeedbackController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var googleSignIn = GoogleSignIn();
  late CallBack callBack;

  var readOnly = false.obs;
  final GlobalKey<FormState> referFormKey = GlobalKey<FormState>();

  var selectedCountryCode = CountryCodeItem().obs;
  var countryCodeList = <CountryCodeItem>[].obs;
  var questions = Questions().obs;

  @override
  void onInit() {
    initEasyLoading();
    getFeedbackQuesttions();
    getCountryCodeList("");
    super.onInit();
  }

  Future<void> getCountryCodeList(String accessCode) async {
    try {
      final either = await settingRepo
          .getCountryCodeList(AuthQueryMutation.getCountryCodeList(""));
      either.fold((l) {
        readOnly.value = true;
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.countryCodeList != null &&
            r.countryCodeList != null &&
            r.countryCodeList!.isNotEmpty) {
          selectedCountryCode.value = r.countryCodeList![0];
          countryCodeList.value = r.countryCodeList!;
          readOnly.value = false;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> getFeedbackQuesttions() async {
    try {
      final either = await settingRepo.getFeedbackQuestionsList(
          SettingQueryMutation.getFeedbackQuestionsList());
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.auth != null &&
            r.auth!.getSettingsMenuData != null &&
            r.auth!.getSettingsMenuData!.questions != null) {
          questions.value = r.auth!.getSettingsMenuData!.questions!;
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> deleteAccount(String query) async {
    try {
      final either = await settingRepo.deleteUser(query);
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        //callBack.onCall();
      }, (r) {
        if (r.authMutation != null && r.authMutation!.update != null) {
          callBack.onCall();
          Get.toNamed(Routes.welcomeScreen);
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  Future<void> logOutAccount(String query) async {
    try {
      final either = await settingRepo.logOut(query);
      either.fold((l) {
        showSnackBar("Error", l.errorMessage, true);
        //callBack.onCall();
      }, (r) {
        if (r.authMutation != null && r.authMutation!.update != null) {
          showSnackBar("success", "Logged Out Successfully", false);
          googleSignOut();
          LocalStorage.setIsLogin(false);
          Get.toNamed(Routes.welcomeScreen);
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
    }
  }

  void checkValidateDeleteAccount(CallBack callBack) {
    this.callBack = callBack;
    if (selectedreasons.isNotEmpty) {
      var deleteUserAccount = DeleteUserRequest(
        token: LocalStorage.getAccessToken(),
      );
      deleteAccount(SettingQueryMutation.deleteUser(deleteUserAccount));
    } else {
      showSnackBar("error", "Please select an option", true);
    }
  }

  void logOut() {
    var logOutUserAccount = LogOutUserRequest(
      token: LocalStorage.getAccessToken(),
    );
    logOutAccount(SettingQueryMutation.logout(logOutUserAccount));
  }

  void googleSignOut() async {
    await googleSignIn.signOut();
    LocalStorage.setIsLogin(false);
    Get.toNamed(Routes.welcomeScreen);
  }

  Future<void> submitEnquiryRequest(String query) async {
    try {
      final either = await settingRepo.submitEnquiry(query);
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("Error", l.errorMessage, true);
      }, (r) {
        if (r.submitEnquiry != null && r.submitEnquiry!) {
          showSnackBar("success", "Thank you for reffering us", false);
          nameController.text = "";
          orgNameController.text = "";
          mobileController.text = "";
          emailController.text = "";
        }
        EasyLoading.dismiss();
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  Future<void> submitFeedbackRequest(String query) async {
    try {
      final either = await settingRepo.submitUserFeedback(query);
      either.fold((l) {
        EasyLoading.dismiss();
        showSnackBar("error", l.errorMessage, true);
      }, (r) {
        if (r.authMutation != null) {
          showSnackBar("success", "Thank you for your views", false);
          Get.back();
        }
      });
    } catch (e, stacktrace) {
      print("Exception==$e");
      print("Stacktrace==${stacktrace.toString()}");
      EasyLoading.dismiss();
    }
  }

  void submitRating() {
    hideSoftKeyboard(Get.context!);
    if (rating.value.toString().isNotEmpty) {
      var submitFeedback = SubmitFeedbackRequest(
        answer: rating.toString(),
        question: questions.value.starRatingQuestion!.question,
        id: questions.value.starRatingQuestion!.id,
        token: LocalStorage.getAccessToken(),
      );
      submitFeedbackRequest(
          SettingQueryMutation.submitUserFeedback(submitFeedback));
    }
  }

  void submitUserInAppFeedback() {
    hideSoftKeyboard(Get.context!);
    if (ratingFeedbackController.text.isNotEmpty) {
      var submitFeedback = SubmitFeedbackRequest(
        answer: ratingFeedbackController.text,
        question: questions.value.userFeedbackQuestion!.question,
        id: questions.value.userFeedbackQuestion!.id,
        token: LocalStorage.getAccessToken(),
      );
      submitFeedbackRequest(
          SettingQueryMutation.submitUserFeedback(submitFeedback));
    }
  }

  void submitAppFeedback() {
    hideSoftKeyboard(Get.context!);
    if (rating.value.toString().isNotEmpty) {
      var submitFeedback = SubmitFeedbackRequest(
        answer: "",
        question: questions.value.appFeedbackQuestion!.question,
        id: questions.value.appFeedbackQuestion!.id,
        token: LocalStorage.getAccessToken(),
      );
      submitFeedbackRequest(
          SettingQueryMutation.submitUserFeedback(submitFeedback));
    }
  }

  // void deleteUser() {
  //   var deleteUserAccount = DeleteUserRequest(
  //     token:
  //         "d9ba07ab5a8b90ce171ea4543761c2d0a5e562eff18ba29f8341b9a2922277c7a6c0a32c7fb09960ee0a91e39435f85f07e1f39ea256556dac9ba781a1619d881af4c6a5348d426f08623261f80cb3e81f8d1478dd09df27360586c89c9a55c9335923f4905f8fa5e2ecafac432ad50f",
  //   );
  //   deleteAccount(SettingQueryMutation.deleteUser(deleteUserAccount));
  // }

  void checkReferUsValidation() {
    hideSoftKeyboard(Get.context!);
    final isValid = referFormKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      referFormKey.currentState!.save();

      var referUsRequest = ReferUsRequest(
        code: selectedCountryCode.value.code!,
        mobileNo: mobileController.text.toString(),
        email: emailController.text.toString(),
        name: nameController.text.toString(),
        company: orgNameController.text.toString(),
        via: "refer-us",
      );
      submitEnquiryRequest(SettingQueryMutation.submitEnquiry(referUsRequest));
    }
  }

  void redirectToWebView(String url) {
    Get.toNamed('${Routes.webView}?${StringsConstant.urlKey}=$url');
  }

  @override
  void onClose() {
    EasyLoading.dismiss();
    nameController.dispose();
    orgNameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
